#!/bin/sh

if [[ $# == 0 ]]
then
    echo -e "\033[31m param number wrong \033[0m"
    exit 1
fi

host=(<%- hostArray %>)
root=(<%- rootArray %>)
password=(<%- passwordArray %>)
path=(<%- pathArray %>)

echo $3

cd $2

git checkout .
git checkout master
git pull origin master

tag=`git tag | grep $3`

if [[ -z "$tag" ]]
then
    echo -e "\033[31m tag $3 not exist \033[0m"
    exit 1
fi

git checkout $3

npm install

if [[ $? -ne 0 ]]
then
    echo -e "\033[31m npm install wrong \033[0m"
    exit 1
fi

for ((i = 0; i <= 10; i++));
do
    expect rsync.exp ${host[i]} ${root[i]} ${password[i]} ${path[i]}

    if [[ $? -ne 0 ]]
      then
        echo -e "\033[31m rsync ${host[i]} ${path[i]} wrong \033[0m"
        exit 1
    fi

    echo "rsync ${host[i]} ${path[i]} finished"

    expect $1/online.exp ${host[i]} ${root[i]} ${password[i]} ${path[i]} $3

    if [[ $? -ne 0 ]]
    then
        echo -e "\033[31m probe wrong;${host[i]} online failed \033[0m"
        exit 1
    else
        echo -e "\033[32m probe success;${host[i]} online finished \033[0m"
    fi

    sleep 15
done

echo '\033[32m batch online complete \033[0m'