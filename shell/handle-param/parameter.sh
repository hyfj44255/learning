#!/bin/bash

slice="-----------------------------"

# 打印第10个参数，10个以上的参数要这样引用${position}
tenth=${10}
if [ -z $tenth ];then
    echo "don't have 10th param!"
else
    echo $tenth
fi
echo $slice

# 取脚本名字
scriptName=${0}
echo $scriptName

scriptName=$(basename $0)
echo "pure script name is: ${scriptName}"
echo $slice

# 命令行参数个数
echo "命令行参数个数为: "$#
echo $slice

# 直接获得最后一个参数 不能用 ${$#} 要用：${!#}
# 注意当没有任何参数 $# 为0,但是 ${!#}则为脚本名称
echo "the last parameter is: "${!#}

if [ $# -eq 0 ];then
    echo "没有参数，脚本名字为: "$(basename ${!#})

else
    echo "最后一个参数为："${!#}
fi
echo $slice

# 获取所有参数
# $* 所有参数当作1整个字符串
# $@ 所有参数当作一整个数组

for item in "$*";do
    echo 'read from $* :'$item
done
echo "++++++++++++++"
for item in "$@";do
    echo 'read from $@ :'$item
done

# 像这样用的化，for的时候就变成以空格作为分割，会成为数组
star=$*
at=$@
# 这两种也是
# for item in $*;do
# for item in $@;do
# 必须这样：
# for item in "$*";do
# for item in "$@";do

# 这里再详细说明一下$*和$@的区别。当$*出现在双引号内时，会被扩展成由多个命令行参数组成的单个单词，每
# 个参数之间以 IFS 变量值的第一个字符分隔，也就是说，"$*"会被扩展为"$1c$2c..."（其中 c 是 IFS 变量值
# 的第一个字符）。
# 当$@出现在双引号内时，其所包含的各个命令行参数会被扩展成独立的单词，也就是说，"$@"
# 会被扩展为"$1""$2"...。——译者注
echo $slice

# shift 参数
# 跳过参数 shfit n

# count=1
# while [ -n "$1" ];do
#     echo "parameter $count is： "$1
#     count=$[ count+1 ]
#     shift 2
# done

# echo "参数全被shift光了: $@"
set -- $(getopt -q ab:cd "$@")
while [ -n "$1" ];do
    case $1 in 
        -a) 
            echo "this is option -a" ;;
        -b)
            param=$2
            echo -n "this is option -b, "
            echo "the param is $param"
            shift ;;
        -c) 
            echo "this is option -c" ;;
        -d) 
            echo "this is option -d" ;;
        --) 
            shift
            break;;
        *) 
            echo "not a valid option: $1" ;;
    esac
    shift    
done

echo "the command are:"
for ele in "$@";do
    echo $ele
done
echo the command string is: "$*"

echo $slice

# 使用 getopt 解析组合 flag, 比如 -a -b 写成了 -ab
# -q 忽略不存在的flag ，-cde 中的 e
# ab:cd 意思为，b需要一个参数，因为b后面有个冒号“：”
getopt -q ab:cd -a -b BOption -cde uptime
# 在script中使用 getops
# set 命令有一个选项是双连字符（--），可以将位置变量的值替换成 set 命令所指定的值
# set -- $(getopt -q ab:cd "$@")
# 脚本使用： ./parameter.sh -a -b namespace -cde "df -h"
echo $script