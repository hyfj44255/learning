## gawk 使用

```shell
# 从标准输入读取内容
gawk '{print $1}'

gawk '{print "hello world"}'

# $0 代表整个字符串，默认分割符为空格
gawk '{print $1}' text.txt

# -F 自定义分割符
gawk -F: '{print $1}' /etc/passwd

# 执行多条gawk命令，先替换再打印全部
echo "i am robin"|gawk '{$3="yang";print $0}'

# 多行命令放在各自行，输入了 gawk后，输入文字会被gawk处理掉
echo "I am Robin" | gawk '
{
$3="yang"
print $0
}'
```

## 从文件中读取脚本

```shell
cat single-line-script.gawk

{print $1 "'s home directory is " $6 }

cat multi-line-script.gawk

# 每行不用加分号，并且定义了content存放变量，使用的时候不用加$
{
content="'s home directory is "
print $1 content $6
}


gawk -F: -f single-line-script.gawk /etc/passwd
gawk -F: -f ./multi-line-script.gawk /etc/passwd
```

## 处理数据前运行脚本
```shell
# 第一段(第一组大括号)声明处理数据前运行脚本，需要第二段定义脚本
gawk 'BEGIN {print "hellow world"} 
{print $0}' text.txt

# or 
gawk 'BEGIN {print "hellow world"} {print $0}'
```

## 处理后运行脚本
```shell
gawk 'BEGIN {print "hellow world"} 
{print $0}
END {print "finished"}
' text.txt

gawk -f good-looking.gawk /etc/passwd
```

## 前后脚本例子
```shell
gawk -f good-looking.gawk /etc/passwd
```
