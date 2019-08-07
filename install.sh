#!/bin/bash

SUDO="sudo"
InstallCommand=""
OsName=""

function check_user()
{
    if [[ `id -u` -eq 0 ]];then
        echo "root用户!"
        SUDO=""
    else
        SUDO="sudo"
        echo "非root用户!"
    fi
}

# 获取平台类型，mac还是linux平台
function get_platform_type()
{
    echo $(uname)
}

# 获取linux平台类型，ubuntu还是centos
function get_linux_platform_type()
{
    export OS_NAME=$( cat /etc/os-release | grep ^NAME | cut -d'=' -f2 | sed 's/\"//gI' )    
    case "$OS_NAME" in    
      "CentOS Linux")    
        InstallCommand=" ${SUDO} yum install -y "
        OsName="centos"
        echo "centos" # centos redhat系列
      ;;    
      "Ubuntu")    
        OsName="ubuntu"
        InstallCommand=" ${SUDO} apt install -y "
        echo "ubuntu" # debian ubuntu系列
      ;;    
      *)    
    esac    
}

# 确认安装命令
function install_tools_on_linux()
{
    get_linux_platform_type
    ${InstallCommand}  git wget curl 
}


# main函数
function main()
{
    type=`get_platform_type`

    echo "platform type: "${type}

    if [ ${type} == "Linux" ]; then
        install_tools_on_linux
    else
        echo "not support platform type: "${type}
    fi
}

# 调用main函数
main

git clone https://github.com/ooknn/dotfiles.git && cd dotfiles &&  bash nvim_install.sh && bash shell_tools.sh