#!/bin/bash
# set -x # 执行命令前打印命令
# set +x # disable
slice="-------------------------------"

# echo 不换行
echo -n "current time is: "
date

# 打印所有环境变量 env / printenv
# 显示单个环境变量 printenv PATH

# set 命令更多地用于查看和设置当前Shell会话中的变量，
# 而env 命令则用于查看和在特定命令中设置环境变量，这些环境变量对所有子进程都是可见的。
# set 命令中的变量不一定都是环境变量，而env 命令显示的变量都是环境变量

# 定义全局环境变量,用 export导出
# 子shell无法更改全局环境变量，甚至用export，影响不到父shell
GLOBAL=global
export GLOBAL

echo "全局环境变量："$GLOBAL

greeting="hello"

echo "set vars:"
set | grep greeting

echo "env vars:"
env | grep greeting

echo "$slice"

# 从命令输出中提取信息，赋值给变量
# 这样会创建一个子shell运行这个命令，子shell用不了父shell中的变量
current=$(date +%y年%m月%d日)
# or
current=`date +%y年%m月%d日`
echo $current

# wrong: 对于变量不能这么用,y以下这两种都不对
# echo $(slice)
# echo `$slice`

echo $slice

#数组
myArray=(one two three four five)
echo ${myArray[*]}
echo ${myArray[0]}
# unset某个元素这个元素变为空，但是没有被删掉
unset myArray[0]
echo ${myArray[*]}
echo ${myArray[0]}

echo $slice

sort << EOF
12

23
432
15
3
525
6
EOF

echo $slice
# 数学运算
a1=10
a2=20
res=$(expr $a2 \* $a1)
echo $res

# 使用[ ]将计算表达式值赋值给表达式
res=$[$a2 * $a1+1]
echo $res
# bash 在浮点操作有很大的短板，zsh 浮点运算比较好
item_rpm=1
item_dnfyum=2
item_flatpak=3

redhatscore=$[ $item_rpm+$item_dnfyum+$item_flatpak ]
# $[...]：这是Shell中的算术扩展语法，用于执行算术运算。在现代Shell脚本中，
# 更常见的是使用 $((...)) 来进行算术运算，但 $[...] 也是有效的。

echo $slice
# 使用bc 计算
echo "使用BC计算器"
r1=$(echo "scale=4; 3.44/5"|bc)
echo $r1

v1=100
v2=45
v3=$(echo "scale=4; $v1/$v2"|bc)
echo "v3 is "$v3

v4=$(bc << EOF
scale = 4
ab1 = ($v1 + $v2)
ab2 = $v1 + $v2
ab1 + ab2
EOF
)
echo "v4 is :"$v4