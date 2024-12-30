## find

**find pathname -options [ -print -exec -ok ...]**
- -pathname .代表当前目录，/代表系统根目录
- -print:表 find 将匹配的文件 输出到 标准输出
- -exec:表 find 对匹配的文件执行该参数所给出的Shell 命令。相应命令的形式为: **'command' {} \;**，注意{}和符号\;之间的空格。
- -ok:作用和-exec相同，不过以更为安全的模式来执行该参数所给出的Shell命令，执行每一个命令之前，都给提示，让用户确定是否执行。


**find命令选项**
- -name 按文件名查找文件
- -perm 按文件权限查找文件
- -prune 使find 不在当前指定的目录查找，如果同时使用-depth选项，那么find 会忽略 -prune
- -user 文件属主来查找文件。
- -group 文件所属的组来查找文件。
- -mtime -n + n 按文件更改时间查找，-n 从此刻算起，文件的更改时间是在n天以内;+n表示更改时间是在n天以前。find 命令还有-atime和-ctime选项，它们和-mtime选项的时间规定类似
- -nogroup 查找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。
- -nouser 查找无有效属主的文件，即该文件的属主在/etc/passwd 中不存在。
- -newer file1!file2 查找更改时间比文件file1新但比文件file2 旧的。
- -type 查找某一类型的文件，诸如:
  - b:表示块设备文件
  - d:表示目录
  - c:表示字符设备文件
  - p:表示管道文件
  - 1:表示符号链接文件
  - f:表示普通文件
  - -size n:[c]:表示查找文件长度为n块的文件，带有c时表示文件长度以字节计。
  - -depth: 查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
  - -fstype:查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件/etc/fstab 中找到，该配置文件包含系统有关文件系统的信息。
  - -mount: 查找文件时不跨越文件系统mount点。
  - -follow: 如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。
  - -cpio: 对匹配的文件使用cpio命令，将这些文件备份到磁带设备中。

```shell
# 当前目录下所有普通文件，并在-exec选项中使用ls -l 列出他们
find . -type f -exec ls -l {} \;

# 在当前目录中查找，更改时间在5日以内文件询问删除它们，如下所示:
# ok 比 exec 更为安全，需要用户输入y才执行命令
find . -type f -mtime -5 -ok rm {} \;

# 用find命令匹配所有文件名为“passwd*”的文件，例如passwd、passwd.old、passwd.bak 然后执行grep命令看看在这些文件中是否存在一个sam用户
find /etc -name "passwd*" -exec grep "sam" {} \;
```

## find 命令的实例说明

1. 查找当前用户主目录下的所有文件，命令如下:
**find ~ -print**

2. 让当前目录中的文件属主具有读、写权限,并且文件所属组的用户和其他用户具有读权限的文件，其实就是查找权限为644的文件，命令如下:
**find . -type f -perm 644 -exec ls -l {} \;**

3. 查找系统中所有文件长度为0的普通文件，并列出它们的完整路径，命令如下:
**find . -type f -size 0 -exec ls -l {} \;**

4. 查找/var/logs目录中更改时间在7日以前的普通文件，删除之前提示，命令如下
**find /var/logs -type f -mtime +7 -ok rm {} \;**

5. 当前目录下，属root组的文件
**find . -group root -exec ls -l {} \;**

6. 删除目录中访问时间在7日以内、且含有数字后缀的admin.log文件
**find . -name "admin.log[0-9]" -atime -7 -ok rm {} \;**

7. 查当前文件系统中的所有目录并排序，命令如下:
**find . -type d | sort**
```shell
# shell 下
ls -1F |grep /$
```

8. 查找系统中所有的rt磁带设备，命令如下:
**find /dev/rmt -print**

## xargs 来配合 find 工作
exec 参数的个数有限，会出现溢出错误，所以用xargs，xagrs原理是一批一批处理

1. 查找系统中每一个普通文件，用xargs命令测试它们分别属于哪类文件
**find . -type f -print |xargs file**

2. 当前目录查找所有用户具有读、写和执行权限的文件，并收回相应的写权限,用 ls -lsart 检查 find 是否生效
**find . -perm -777 -print | xargs chmod o-w**

3. 用grep在普通文件中搜索文件内容包含 mt 这个词的文件。find 命令配合着exc 和xangs使用
**find . -type f -print | xargs grep rmt** 
等价于 
**grep rmt -rl .** r，表示递归; 1，表list

## 更详细和强大的find 实例

**find . -name "*.txt" -print** -name的参数需要用引号包围

在当前目录及子目录中查找文件名以一个大写字母开头的文件
**find . -name "[A-Z]*" -print**

在/etc查找以host开头的文件
**find /etc -name "host*" -print**

**find . -name "[a-z][a-z][0-9][0-9],txt"-print**

### 使用 perm 选项
按文件权限模式来查找文件，不过最好使用八进制法表示权限
**find . -perm 755 -print**

**perm mode** 说明

- -perm mode: 文件许可正好符合mode
- -perm +mode: 文件许可部分符合mode，如果是+006，表示文件的某一项权限为6，可以随便是哪一项，如果属主符合6权限，也可由find 命令打印出来
- -perm -mode: 文件许可完全符合mode，如果是-007，表示文件的所有权限都必须是7，即777。

### 忽略某个目录进行查找
用-prune，同时使用-depth选项，那么-prune 选项就会被find 命令忽略了
```bash
# 如果希望在/home/andrewy目录下查找文件，但不在/home/andrewy/tv目录下查找，可
find /home/andrewy/ -path "/home/andrewy/tv" -prune -o -type f -print
```

### 使用user 和 nouser 选项7个一位热各动
按文件属主查找文件
**find ~ -user sam -print**

属主在/etc/passwd 文件中没有有效账户的文件了，不用给出属主名字
**find /home -nouser -print**

### 使用 group 和 nogroup 选项

```bash
find /apps -group gem -print

# 无有效用户组
find / -nogroup -print
```

### 按照更改时间或访问时间等查找文件
系统突然没有可用空间，可能是某一个文件在此期间增长迅速造成的，这时就可以用 用 mtime atime 或 ctime
减号-来限定更改时间在距今n日以内，而用加号+来限定更改时间是n日以前
```bash
find / -mtime -5 -print  # last update 距今 5天内
find /var/adm -mtime +3 -print # last update 3 天以前
```

### 查找比某个文件新或旧的文件
找更改时间比temp文件新，可以用如下命令:
```bash
find . -newer temp -print
```

可以选择建立一个文件，然后用以下命令找出这颗频繁被写的文件
```bash
find / - newer test.txt -print
```

### 使用type选项
```sh
find /etc -type d -print # 所有目录
find . ! -type d -print # 除目录以外
find /etc -type l -print # 所有符号连接
```

### 使用size选项
按照文件长度来查找，长度既可以用块(block)来计量，也可以用字节来计量
以字节计量文件长度的表达形式为Nc;以块计量文件长度只用数字表示即可
在按照文件长度查找文件时，一般使用这种以字节表示的方式;
在查看文件系统的大小，则用以块表示，因为这时使用块来计量更容易转换

```bash
find . -size +1000000c -print #找文件长度大于1M字节

# 找文件长度恰好为100字节的文件
find /home/apache -size 100c -print

# 长度超过10块的文件(一块等于512字节)
find. -size +10 -print
```
工作中我们其实都是用M来进行比对的

### 使用depth选项
从文件系统的根目录开始，查找一个名为CON.FILE 的文件
**find / -name "CON.FILE" -depth -print**