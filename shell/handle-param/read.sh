#!/bin/bash
echo -n "pls enter your name:"
read name
echo hello! $name

read -p "pls enter you age: " age
days=$[ $age * 365 ]
echo "you are over $days days!"

# read 会把输入分给各个变量，但是如果变量不够就会把多出来的input全都给到最后一个变量
read -p "pls tell me your first and last name: " first last
echo "first : $first, last : $last"

# 没指定变量就会把给一个较REPLY的变量
read -p "what is the brand of you car? "
echo "oh it's $REPLY, I like it"

# 设定超时
if read -t 2 -p "where are you" where;then
    echo "ah you are at "$where
else
    echo
    echo did not tell me where you are!
fi


# read 统计输入字符数
read -n 1 -p "do you wanna continue?[Y|N]" continue
case $continue in
    y|Y) echo; echo "ok,lets continue";;
    n|N) echo; echo "ok, we will quit";;
esac

# 隐藏输入
read -s -p "pls enter your password" pass
echo
echo "the password is :"$pass

count=1
cat ./example.txt | while read line;do 
    echo
    echo this is the $count line
    echo "the content is: $line" 
    count=$[ $count+1 ]
done