#!/bin/sh

if [[ $# == 0 ]];then
    echo -e "\033[31m param number wrong \033[0m"
    exit 1
fi

echo $1

cd $1 

pm2 stop $2
service nginx stop
git checkout $3
git pull origin $3
git checkout $4
# npm install
pm2 start $2 --update-env
service nginx start

echo "release success by $4"

exit 1
