#!/bin/bash

function add {
    local var1=$1
    local var2=$2
    local var3=$[ $1 + $2 ]
    echo $var3
}

multipul(){
    local var1=$1
    local var2=$2
    local var3=$[ $1 * $2 ]
    echo $var3
}

recursive(){
    local target=$1
    if [ $target -le 1 ];then
        echo $target
    else
        res=$(recursive $[ $target - 1 ])
        echo $[ $res * $target ]
    fi
}

function doubleArray {
    local i=0
    local getArr=($(echo "$@")) # 之所以用括号是数组的意思，定义数组时用括号把元素括起来
    local newArr=($(echo "$@"))
    local len=$#
    for (( i=0; i<= $[ $len - 1 ]; i++ )){
        newArr[$i]=$[ ${getArr[$i]} * 2 ]
    }
    echo ${newArr[*]}
}