
## 输入输出描述符
- 0： 输入 stdin
- 1： 输出 stdout
- 2： 错误 stderr

## stdin
cat
cat < filename

## stdout

ls -ltra > test2

who >> test2

ls -la fileNotExists > test3
错误会直接输出到屏幕上，而不是新创建的 test3 文件当中

## stderr
- 只重定向错误,只有错误会发到 test4,正常输出会打到屏幕
**2>**

```shell
ls -la fileNotExists 2> test4
```

- 分别重定向，错误 和 正常输出

```shell
ls -la fileNotExists 2> test4 1> test2
```

- stdout stderr 重定向到统一文件，但是 stderr会被优先输出在文件顶部
ls -al test test2 test3 badtest &> test7

## 脚本中重定向
### 临时重定向

test.sh
```shell
#!/bin/bash
echo "This is an error" >&2
echo "normal output"
```

查看效果 ./test.sh 2> out

### 永久重定向

```shell
$ cat test10

#!/bin/bash
# redirecting all output to a file
exec 1>testout
echo "This is a test of redirecting all output"
echo "from a script to another file."
echo "without having to redirect every individual line"

$ ./test10
$ cat testout
This is a test
#### end ###
```