#!/bin/bash

#$[]
#$()
#$(())
#bc expr

val1=10
val2=3

res=$(expr $val1 / $val2)
echo '$(expr $val1 / $val2 ) is '$res

# 等同于用expr
res=$[ $val1 / $val2 ]
echo '$[ $val1 / $val2 ] is '$res

# 高级运算支持 ** 幂运算
res=$(( $val1 / $val2 ))
echo '$(( $val1 / $val2 )) is '$res

#等同于 $() ``和$()都是 变量替换,运行子shell,结果赋值给变量
res=`expr $val1 / $val2`
echo 'expr $val1 / $val2 is '$res

# bc 计算器
res=$(echo "scale=9;$val1 / $val2" |bc)
echo 'using bc the res is '$res