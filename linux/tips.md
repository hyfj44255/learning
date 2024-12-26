## 设置 crontab
编辑 /etc/crontab

```bash
*/1 * * * * robinyang bash /home/robinyang/development/learn/shell/alarm.sh 
```

## crontab 防止脚本运行冲突
如果脚本要运行30min，设置至少1h的间隔来避免冲突

利用 lockf (freeBSD 8.1 - lockf, centos 5.5 flock),执行脚本前检测是否能获取某个文件的锁

lockf 参数
- -k 一直等待获取锁
- -s 即使拿不到锁，不发出任何信息
- -t 超过多少s后放弃

*/10 * * * *（lockf -s -t 0 /tmp/create.lock/usr/bin/python /home/project/cron/create_tab.py >> /home/project/logs/create.log 2>&1)

## nohup 让程序始终在后台运行
```shell
nohup 1.sh 2>&1 &
exit
```
注意必须这样，nohup 之后再执行一个 exit 才行，否则直接关闭 terminal nohup 的程序一样会退出

## 修复 bash
libintl.so.8 丢失 not found

- 单用户模式进入系统
- 扫描磁盘 fsck -y
- 将文件系统重新挂载 mount -a
- 将 root 默认 shell 切换到 shL: chsh -s sh，目前可以用 root 用 sh 模式进入系统
- 安装 bash :pkg_add -r -v bash

## 普通用户身份编辑无权限文件
```shell
:w ! sudo tee %
```
把当前编辑的文件内容，但作标准输入，并输入到命令 sudo tee 文件名里面去
也就是 sudo保存为当前文件名
**我要速度去找缘分**


## bash 快捷键
**zsh oh-my-zsh不好用**
- ctrl+A 命令行开始
- ctrl+E 命令行末尾
- ctrl+L 清屏幕
- ctrl+U 清除剪切光标之前的内容,在nslookup也好用
- ctrl+k 清除剪切光标之后的内容
- ctrl+Y 粘贴所删除的字符
- ctrl+r 在历史命令中查找
- ctrl+D exit
- ctrl+Z 转入后台运行
- !! 重复执行上一条命令
- !$ 显示系统最近一条参数（可以用他把 cat 123 转成 cat !$
