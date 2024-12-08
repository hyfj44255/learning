#!/bin/bash
testFunc(){
    echo 'new func'
    echo this
    echo are
    return 2
}

# 注意函数名字和{ 之间要有空格
function aa {
echo "just a teest"
}
# 调用函数aa
aa
slice=-------------------------------
echo 'invoke function'
var=$(testFunc)
status=$?
echo output of func is: 
echo $var 
echo status of func is: 
echo $status
echo $slice

# local 变量
handleVar(){
   var1=11
   var2=22
   local var3=33
   local var4=44
}
var1=1
var2=2
var3=3
var4=4
handleVar
echo var1 is: $var1
echo var2 is: $var2
echo var3 is: $var3
echo var4 is: $var4

echo $slice
# import lib
echo "import lib"
. ./mylib.sh
echo "2*3 is: "$(multipul 2 3)
echo "2+3 is: "$(add 2 3)

echo -en "user recursive:\n"
echo $(recursive 6) 
echo $slice

# 传递数组到方法中，并返回数组
arr=(1 2 3 4)
res=($(doubleArray ${arr[*]}))
echo ${res[*]}