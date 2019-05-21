#!/bin/sh

#$1为上线tag
#上线需要准备一台预上线机器，既可以用作预上线验证，又可以用作node_module增量同步base，上线都从预上线环境操作

if [[ $# == 0 ]]
then
    echo -e "\033[31m param number wrong \033[0m"
    exit 1
fi

host=<%- host %>
root=<%- root %>
password=<%- password %>
path=<%- path %>

echo $3

cd $2

git checkout .
git checkout master
git pull origin master

tag=`git tag|grep $3`

if [[ -z "$tag" ]]
then
    echo -e "\033[31m tag $3 not exist \033[0m"
    exit 1
fi

git checkout $3

# npm install

if [[ $? -ne 0 ]]
then
    echo -e "\033[31m npm install wrong \033[0m"
    exit 1
fi

expect $1/rsync.exp ${host} ${root} ${password} ${path}

if [[ $? -ne 0 ]]
then
    echo -e "\033[31m rsync ${host} ${path} wrong \033[0m"
    exit 1
fi

echo "rsync $host $path finished"

expect $1/online.exp ${host} ${root} ${password} ${path} $3

# node probe.js ${ip}

if [[ $? -ne 0 ]]
then
    echo -e "\033[31m probe wrong;$ip online failed \033[0m"
    exit 1
else
    echo -e "\033[32m probe success;$ip online finished \033[0m"
fi

