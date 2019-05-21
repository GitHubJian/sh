#!/bin/sh

if [[ $# == 0 ]]
then
    echo -e "\033[31m param number wrong \033[0m"
    exit 1
fi

cd $1

git checkout .

git fetch

git checkout $2

git pull origin $2

git tag $3

git push origin $3

exit 1