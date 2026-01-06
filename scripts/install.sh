#!/bin/bash

DEBUG_MODE=true

if [ "$DEBUG_MODE" == "true" ]; then
	set -e
	echo -e "\e[36;1m当前处于DEBUG模式，修改变量DEBUG为false以关闭\e[0m"
fi

function debug()
{
	if [ "$DEBUG_MODE" == "true" ]; then
		echo -e "[DEBUG] \e[33m$1\e[0m"
	fi
}

function home_dir()
{
	(
		cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
	)
}

ndk_archive_install_url="https://github.com/FullError11/android-ndk-r28c-ollvm/releases/download/v1.0.0/android-ndk-r28c-ollvm.tar.xz"
debug "ndk_archive_install_url=$ndk_archive_install_url"
ndk_archive_path="$(home_dir)/archives/android-ndk-r28c-ollvm.tar.xz"
debug "ndk_archive_path=$ndk_archive_path"



function error()
{
	echo -e "\e[31m$1\e[0m"
}

function info()
{
	echo -e "\e[32m$1\e[0m"
}

function test_command()
{
	command -v $1 >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		error "命令 $1 未安装"
		exit 1
	fi
}

function main()
{
	ndk_install_dir=$1

	test_command "xz"
	test_command "tar"

	info "开始安装 android-ndk-r28c-ollvm"

	if [ -z "$ndk_install_dir" ]; then
		info "请提供安装目录: "
		read -p "> " ndk_install_dir
		if [ -z "$ndk_install_dir" ]; then
			error "未输入安装目录"
			exit 1
		fi
	fi
	debug "ndk_install_dir=$ndk_install_dir"

	mkdir -p $ndk_install_dir

	info "下载 android-ndk-r28c-ollvm.tar.xz"
	wget -O $ndk_archive_path $ndk_archive_install_url
	if [ $? -ne 0 ]; then
		error "下载失败"
		exit 1
	else
		info "下载完成"
	fi

	info "解压 android-ndk-r28c-ollvm.tar.xz"
	tar -xf $ndk_archive_path -C $ndk_install_dir
	
	info "解压完成"

	info "ANDROID_NDK_HOME 应该设置为 $ndk_install_dir/android-ndk-r28c-ollvm"
}

main $@
