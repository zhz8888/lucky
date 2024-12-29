#!/bin/bash

installStart(){
    getCpuCore
    install_dir=/usr/share
    luckPathSuff='lucky.daji'
    luckydir=$install_dir/$luckPathSuff
	echo "luckdir:"$luckydir
	getTargetFileURL
    getFilesFromNetwork
	installSetProfile
	installSetInit
}

getCpuCore(){
	cputype=$(uname -ms | tr ' ' '_' | tr '[A-Z]' '[a-z]')
	echo "当前处理器架构为：" $cputype
	[ -n "$(echo $cputype | grep -E "linux.*armv.*")" ] && cpucore="armv5"
	[ -n "$(echo $cputype | grep -E "linux.*armv7.*")" ] && [ -n "$(cat /proc/cpuinfo | grep vfp)" ] && cpucore="armv7"
	[ -n "$(echo $cputype | grep -E "linux.*aarch64.*|linux.*armv8.*")" ] && cpucore="arm64"
	[ -n "$(echo $cputype | grep -E "linux.*86.*")" ] && cpucore="i386"
	[ -n "$(echo $cputype | grep -E "linux.*86_64.*")" ] && cpucore="x86_64"
}

getTargetFileURL(){
	version=$(curl -s https://api.github.com/repos/gdy666/lucky/releases/latest | jq -r '.tag_name')
    download_url='https://github.com/gdy666/lucky/releases/tag/'$version'/lucky_'$version'_Linux_'$cpucore'.tar.gz'
    echo "目标文件下载链接:" $download_url
}

webget(){
	#参数【$1】代表下载目录，【$2】代表在线地址
	#参数【$3】代表输出显示，【$4】不启用重定向
	if curl --version > /dev/null 2>&1;then
		[ "$3" = "echooff" ] && progress='-s' || progress='-#'
		[ -z "$4" ] && redirect='-L' || redirect=''
		result=$(curl -w %{http_code} --connect-timeout 5 $progress $redirect -ko $1 $2)
		[ -n "$(echo $result | grep -e ^2)" ] && result="200"
	else
		if wget --version > /dev/null 2>&1;then
			[ "$3" = "echooff" ] && progress='-q' || progress='-q --show-progress'
			[ "$4" = "rediroff" ] && redirect='--max-redirect=0' || redirect=''
			certificate='--no-check-certificate'
			timeout='--timeout=3'
		fi
		[ "$3" = "echoon" ] && progress=''
		[ "$3" = "echooff" ] && progress='-q'
		wget $progress $redirect $certificate $timeout -O $1 $2 
		[ $? -eq 0 ] && result="200"
	fi
}

getFilesFromNetwork(){
    webget /tmp/lucky.tar.gz $download_url
    [ "$result" != "200" ] && echo "文件下载失败，正在退出！" && exit 1
    echo "-----------------------------------------------"
	echo "开始解压文件！"
    mkdir -p $luckydir > /dev/null
	tar -zxvf '/tmp/lucky.tar.gz' -C $luckydir/
	[ $? -ne 0 ] && echo "文件解压失败，正在清理并退出！" && rm -rf /tmp/lucky.tar.gz && exit 1 
    echo "已解压到" $luckydir
	chmod +x $luckydir/lucky
	chmod +x $luckydir/scripts/*
	rm -rf /tmp/lucky.tar.gz
}

installSetProfile(){
	profile=/etc/profile
	if [ -n "$profile" ];then
		sed -i '/alias lucky=*/'d $profile
		echo "alias lucky=\"$luckydir/lucky\"" >> $profile #设置快捷命令环境变量
		sed -i '/export luckydir=*/'d $profile
		echo "export luckydir=\"$luckydir\"" >> $profile #设置快捷命令环境变量
	else
		echo "无法写入环境变量，请检查安装权限！"
		exit 1
	fi
	echo "Profile:" $profile
}

installSetInit(){
#判断系统类型写入不同的启动文件
if [ -f /etc/rc.common ];then
        #设为init.d方式启动
        echo "设为init.d方式启动"
        cp -f $luckydir/scripts/luckyservice /etc/init.d/$luckPathSuff
        chmod 755 /etc/init.d/$luckPathSuff
		/etc/init.d/$luckPathSuff enable
		/etc/init.d/$luckPathSuff start
else
    [ -w /etc/systemd/system ] && sysdir=/etc/systemd/system
    [ -w /usr/lib/systemd/system ] && sysdir=/usr/lib/systemd/system
    if [ -n "$sysdir" ];then
        #设为systemd方式启动
        echo "设为systemd方式启动"
		echo "sysdir:"$sysdir
        mv $luckydir/scripts/lucky.service $sysdir/$luckPathSuff.service
        sed -i "s%/etc/lucky%$luckydir%g" $sysdir/$luckPathSuff.service
		chmod 000 $sysdir/$luckPathSuff.service
        systemctl daemon-reload
		if [  ! $? = 0 ];then
			echo "systemctl daemon-reload 出错， 转为保守模式..."
			installStartDaemon
		else
			systemctl enable $luckPathSuff.service
			systemctl start $luckPathSuff.service
		fi
    else
    #设为保守模式启动
	installStartDaemon
    fi
fi
}

installStartDaemon(){
	echo "设为保守模式启动"
	type nohup >/dev/null 2>&1 && nohup=nohup
	$nohup $luckydir/lucky -c "$luckydir/lucky.conf" >/dev/null 2>&1 &
	cronset '#lucky保守模式守护进程' "*/1 * * * * test -z \"\$(pidof lucky)\" && $luckydir/lucky -c $luckydir/lucky.conf & #lucky保守模式守护进程"
}

installStart