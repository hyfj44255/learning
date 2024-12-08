#!/bin/bash

# usage: ./getopts.sh -a -b "ls -ltra" -cde "tar -zxvf"

# todo getopt 和 getops 的区别:
# getopt 与 getopts 的不同之处在于，前者在将命令行中选项和参数处理后只生成一个输
# 出，而后者能够和已有的 shell 位置变量配合默契。
# getopts 每次只处理一个检测到的命令行参数。在处理完所有的参数后，getopts 会退出
# 并返回一个大于 0 的退出状态码。这使其非常适合用在解析命令行参数的循环中。

# getops对于含有空格的 param (比如写成这样，加上双引号"tar -zxvf")可以当作一个字符串处理 getopt不行
# :ab:cd 中的第一个引号是发现未定义的flag 静默反映，第二个：是定义b后面需要参数
# getopts 提供两个参数 $OPTARG flag 后面跟着的参数值，flag不需要参数就为空， $OPTIND 索引 

slice="------------------------------"

while getopts :ab:cd opt;do
    echo "current index of getopts $OPTIND"
    case $opt in
        a) 
            echo "get flag a";;
        b) 
            echo -n "get flag b"
            echo ",and the param is $OPTARG";;
        c) 
            echo "get flag c";;
        d) 
            echo "get flag d";;
        *)
            echo "unknow flag $opt";;
    esac
    echo
done

# getopts 命令知道何时停止处理选项，并将参数留给你处理。在处理每个选项时，getopts
# 会将 OPTIND 环境变量值增 1。处理完选项后，可以使用 shift 命令和 OPTIND 值来移动参数：
shift $[ $OPTIND - 1]
for ele in "$@";do
    echo "the command is : $ele"
done