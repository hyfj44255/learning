#!/bin/bash 
slice="------------------------------"

# if 判断表达式返回值
if w;then
    echo "if 判断表达式返回值"
fi

if myprog;then
    echo "命令不存在"
fi
echo $slice

# test 命令
if test w
then
    echo "test 命令"
fi

# test 检测变量，变量有值为真
v1="value1"
v2=""
if test v2;then
    echo "v2存在"
elif test v1;then
    echo "v1存在"
fi

echo $slice

# 用 [ ] 代替test命令
if [ w ];then
    echo "用 [ ] 代替test命令"
fi

# 比较数字,但是只能处理整数
a1=10
if [ $a1 -ge 9 ];then
    echo "a1 is $a1 ,大于等于9"
fi
echo $slice

# 字符串比较
a2="abc"
a3="def"
if [ a2 = a3 ];then
    echo "a2 等于 a3"
elif [ a2 != a3 ];then
    echo "a2 is not = a3"
fi

# 字符串比较大小需要用 \> \<
if [ $a2 \> $a3 ];then
    echo "$a2 > $a3"
fi

# 检查 str1 的长度是否为 0
if [ -z "$a4" ];then
    echo "a4 length is 0"
fi

#-z str1检查 str1 的长度是否为 0
if [ -n "$a3" ];then
    echo "a3 length is not 0"
fi

echo $slice

# 试一试 shell中cd mkdir 好用不,pwd取的是在哪个路径调用的这个shell
pp=`pwd`
echo nowpath=$pp
mkdir -p ${pp}/tmp2
cd ${pp}/tmp2
touch aa
ls -ltr
cd ..
echo $slice

# -e 文件存在吗 
if [ -d /dev/null ];then
    echo "/etc存在"
fi

# -f 是一个文件么 -d 存在且为目录

# -s 文件存在且非空

# -w file检查 file 是否存在且可写
# -x file检查 file 是否存在且可执行
# -O file检查 file 是否存在且属当前用户所有
# -G file检查 file 是否存在且默认组与当前用户相同
# file1 -nt file2检查 file1 是否比 file2 新
# file1 -ot file2检查 file1 是否比 file2 旧
echo $(pwd)/basic.sh
if [ -f $(pwd)/basic.sh ];then
    if [ ./basic.sh -nt ./ifelse.sh ];then
        echo "file1 is newer than file2"
    elif [ ./basic.sh -ot ./ifelse.sh ];then
        echo "file1 is older than file2"
    fi
else
    echo "error"
fi
echo $slice

# 复合条件测试
if [ 0 -eq 0 ] && [ 2 -eq 3 ] || [ 3 -eq 3 ];then
    echo "符合测试条件"
fi
echo $slice

# if else 高级用法
# 单括号()在if语句中使用子shell
# 进程列表: cd;ls;pwd;touch aa;
# 在()中使用进程列表的话，除最后一个命令之外的其他命令全都失败，if还是会为真，这个要小心
if ( ls &> /dev/null;w &> /dev/null );then
    echo "found ls command"
fi
echo $slice

inner1=4
# (()) 高阶数学表达式
# i++ i-- ++i --i ! **幂 bool and/or :& | ,logic and/or && ||
if (( 2 ** 2 < 90 ));then
    ((inner2=$inner1**2 ))
    echo "2**2 < 90"
    echo $inner2
fi
echo $slice

# 高级字符串比较的高级特性 [[]] 支持正则表达式 双中括号内使用==运算符或!=运算符时，运算符的
# 右侧被视为通配符。如果使用的是=~运算符，则运算符的右侧被视为 POSIX 扩展正则表达式
tmpStr=5.i
if [[ "$tmpStr" == 5.* ]];then
    echo "高级比较成功"
fi
echo $slice

# case
param1=$1
case $param1 in
"gege" | "da")
    echo "is gegeda";;
"aa")
    echo "is aa";;
*)
    echo "is others";;
esac

echo $slice

score=$[ 1 + 2 ]
echo $score