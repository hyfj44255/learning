## 替换

```shell

# 替换单个字符
echo "big dog dog"|sed 's/dog/cat/'

# 替换一行中的所有匹配字符
echo "big dog dog"|sed 's/dog/cat/g'

# 替换文件中的字符
sed 's/dog/cat/' text.txt
```

### sed中执行多个命令 -e
```shell
sed -e 's/big/small/; s/dog/cat/' text.txt
```

### 次提示符来分隔命令(''),命令列表
```shell
sed -e '
s/big/small/
s/dog/cat/
' text.txt
```

# sed 指令 from file
```shell
sed -f anti-dog.sed text.txt
```

# go on Sed

## sed 命令中的flag
s/pattern/replacement/flags

## g替换一行中全部匹配的，还可以指定替换第几个
替换第2处匹配
```shell
sed s/dog/cat/2 text.txt
```

## 只输出被替换命令修改过的行
sed 的 -e flag 抑制输出，-p指令只输出替换后的行，两者一般一起使用
```shell
sed -n s/dog/cat/p text.txt
```

## w将输出保存到文件

```shell
sed -n 's/dog/cat/w output.txt' text.txt

sed -n "s/dog/cat/gw output.txt" text.txt
```

## sed 命令中的替代字符
默认是斜线， 但是有时候会比较麻烦，比如相对本身就带有斜线的内容进行操作的话
```shell
sed 's/\/bin\/bash/\/bin\/csh/' /etc/passwd

sed 's!/bin/bash!/bin/csh!' /etc/passwd

echo "hello world"| sed 's@hello@oh@g'
```

## 使用地址符
### 数字形式的行寻址
```shell

sed '2s/fad/green/' ./sed-address/data.txt

sed '2,3s/fad/green/' ./sed-address/data.txt

sed '2,$s/fad/green/' ./sed-address/data.txt
```

#### 还有一种更复杂，特殊的寻址符，文本作为地址符
```shell
sed '/big/s/cat/dog/' ./sed-address/data.txt
# big可以是正则表达式，sed找到和big相符的行，再找到 cat 匹配的字符，然后把cat 替换成dog
```

### 命令组

```shell
sed '2{
s/big/little/
s/cat/pig/
}' ./sed-address/data.txt

# or

sed '2,3{
s/big/little/
s/cat/pig/
}' ./sed-address/data.txt

# 等效于
sed '2s/big/little/ ;2s/cat/pig/' ./sed-address/data.txt

# 回忆 ，没有使用(地址符)数字或正则表达式搜索行
sed -e '
s/big/small/
s/dog/cat/
' text.txt
```

## 删除行
delete command 'd', goes great with address
```shell
sed '3d' ./sed-address/data.txt

sed '2,3d' ./sed-address/data.txt

sed '3,$d' ./sed-address/data.txt
```

### 模式匹配 搜索行
```shell
sed '/gegeda/d' ./sed-address/data.txt
```

### 用两组行搜索来删除某1区间内的行
你指定的第一个模式会“启用”行删除功能，第二个模式会“关闭”行删除功能

只要 sed 编辑器在数据流中匹配到了开始模式，就会启用删除功能，如果没有匹配到结束行，就会删除开始之后所有的

```shell
$ cat data7.txt
This is line number 1.
This is line number 2.
This is the 3rd line.
This is the 4th line.
This is line number 1 again; we want to keep it.
This is more text we want to keep.
Last line in the file; we want to keep it.

sed '/1/,/3/d' ./data7.txt
This is the 4th line. # 1被匹配到2次，第二次么地有匹配到关闭，第二次匹配到1后面的数据都被删除，所以被删除的只剩下这一行了


```

## 插入和附加文本
```shell

# i insert 注意i 后面是反斜线\
echo 'hello world' | sed 'i\hello you'

# a append
echo 'hello moto'|sed 'a\hello nokia'

# 多行
echo "123"|sed 'a\
456
i\789'

# 插入到第3行后面

sed '3a\newline' ./sed-address/data8.txt

# 插入到末尾
sed '$a\newline' ./sed-address/data8.txt

# 在第一行前插入多行，行结束要加个反斜线,反斜线前面好像要有个空格

sed '1i\
hello \
we \
are \
new
' ./sed-address/data8.txt

```

## 修改行
```shell

sed '2c\
simple
' ./sed-address/data8.txt

# 通过字符匹配行
sed '/number 1/c\
simple
' ./sed-address/data8.txt

# 使用区间，未必一定如愿，这个需要注意
sed '2,3c\
simple
' ./sed-address/data8.txt
```

## 转换命令 y

```shell
# y/123/456/ 表示1转为4 2->5 3->6
sed 'y/123/456/' ./sed-address/data9.txt
```

# 再研究研究打印

## 打印标志位p（s/origin/new/p 最后那个p）
```bash

sed -n '/3/{
p
s/line/row/p
}' ./sed-address/data9.txt

# 解释：现匹配第三行，p-打印原内容，
# s/line/row/p - 替换line为row 并打印(p)
```

## 打印行号
是否为一行，由数据流中的换行符决定
```bash

sed '=' ./sed-address/data9.txt
```

sed在实际文本前会先打印行号，如果要在数据流中查找特定文本，=号很好用

```bash

sed -n '/again/{
=
p
}' ./sed-address/data9.txt
```
## 列出行
-l 显示不可打印的字符 \t \n 凤鸣字符
```bash

sed -n 'l' ./sed-address/data9.txt
```

## 写入文件
```bash
# 写到aa中
aa=$(mktemp -t gegeda.XXXXXX)
# "2,3w target-file.txt"
sed -n '2,3w '$aa ./sed-address/data9.txt
cat $aa

# 匹配行
# sed -n '/Browncoat/w Browncoats.txt' data12.txt
```

## 从文件读取数据 (不太好用)
```bash

# 正则匹配行也支持

sed '/LIST/{
r ./sed-address/content
d
}' ./sed-address/notice.std

# 用./sed-address/content的数据替换 ./sed-address/notice.std 中的 LIST那一行
```