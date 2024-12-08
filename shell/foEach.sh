#!/bin/bash
slice="--------------------------------------------------"
for ele in robin wayne dirk jim york;do
    echo $ele
done
echo $slice

for ele in $(ls);do
    echo file:$ele
done
for ele in `ls`;do
    echo file:$ele
done
echo $slice

for ele in i don\'t know if this\'ll work;do
    echo "$ele"
done

echo $slice
var1="abc dev"
for ele in $var1;do
    echo $ele
done
echo $slice

longText=$(cat <<EOF
this is robin
this is not me
I need a job
test content
1;2:3-4
EOF
) 

IFS_OLD=$IFS
IFS=$'\n;:-'

echo "after update IFS :"
for line in $longText;do
    echo line:$line
done
IFS=$IFS_OLD

echo "restore IFS :"
for line in $longText;do
    echo line:$line
done

echo $slice

# for from command
for boll in /home/robinyang/development/*;do
    if [ -f "$boll" ];then
        echo "is a file:"$boll
    elif [ -d "$boll" ];then
        echo "is a folder:"$boll 
    fi
done
echo $slice

# C lanage风格 for
for (( a=1;a<10;a++ ));do
    echo 'c styled ele is '$a
done

#使用多个变量
for (( i=0,b=10;i<10;i++,b--));do
    echo i=$i - b=$b
done

echo $slice
# while
# 多个判断条件，只有最后一个测试命令的退出状态码会被用于决定是否结束循环
# 下边 $a -gt 5 不满足了还是会执行，直到满足 $a -ge 4
a=10
while [ $a -gt 5 ] 
    [ $a -ge 4 ];do
    a=$(( --a ))
    echo $a
done
echo $slice

# until
b=5
until [ $b -eq 0 ];do
    b=$[ $b - 1 ]
    echo $b
done
echo $slice

# double loop
for (( i=0;i<5;i++));do
    echo "i is =$i"
    for (( j=0;j<5;j++));do
        echo "  j is="$j
    done
done
echo $slice

# handel file
# break n 1是当前层 2是向外一层
# continue n 
IFS_OLD=$IFS
counter=0
for content in $(cat /etc/passwd);do
    echo $content
    IFS=:
    for cc in $content;do
        if [ $counter -gt 15 ];then
            echo "will break from here"
            break 2
        else
            echo "  $cc"
            counter=$(( ++counter))
        fi
    done
    IFS=$'\n'
done
IFS=$IFS_OLD
echo $slice

# handle output of the for block
for city in 1 3 i5 i4 34j 563j 234io;do
    echo $city" is the next city to travel"
done | sort # > output.txt
echo $slice