## journalctl
sudo journalctl -u cron.service


## linux log config

Syslog started in 1980.
Rsyslog in 2004

Ubuntu uses rsyslog, config files are **rsyslog.conf** and **/etc/rsyslog.d/***

log config 文件 配置格式
> **facility.level.action** 设备.优先级处理方案

- facility.level字段也称为selector(选择条件)，选择条件和处理方案之间用空格或Tab分隔开
1. facility定义了日志消息的范围，可以使用的key如下所示。
- auth:由pam_pwdb报告的认证活动。
- authpriv:包括特权信息，如用户名在内的认证活动
- cron:与cron 和at有关的计划任务信息
- daemon:与inetd守护进程有关的后台进程信息
- kern:内核信息，首先通过klogd传递
- lpr:与打印服务有关的信息
- user:由用户程序生成的信息
- uucp:由uucp生成的信息
- local0~ local7:与自定义程序一起使用

2. level 优先级
- emerg:该系统不可用，等同于panic
- alert:需要立即被修改的条件
- crit:危急情况
- err:错误消息，等同于error
- warning
- notice 具有重要性的普通条件
- info
- debug
- none
- 优先级是由应用程序在编程的时候决定的，除非修改源码再编译，否则不能改变消息的优
- 低优先级包含高优先级，例如，为某个应用程序定义info的日志导向，则涵盖notice、warn.
3.  selector(选择条件)
通过小数点符号“.”把facility和 level 连接在一起则成为selector(选择条件)。可以使用分号“;”同时定义多个选择条件。也支持如下3个修饰符。
- * 表示所有日志信息
- = 等于，即仅包含本优先级的日志信息
- ! 不等于，本优先级日志信息除外
4. action(处理方案，行动)
由前面选择条件定义的日志信息，可执行下面的动作。
- file: 指定日志文件的绝对路径
- terminal 或 print:发送到串行或并行设备的标志符，例如/dev/ttyS2@host 表示远程的日志服
- username:发送信息到本机的指定用户信息窗口中，但该用户必须已经登录到系统中。
- named pipe:发送到预先使用mkfifo命令创建的FIFO文件的绝对路径中

## Linux 日志维护
### 系统日志

**/var/log/messages** 杂货铺，服务器的系统日志，也包括许多服务的日志，建议重点关注 tail -n 10 /var/log/messages

### 系统安全日志
**var/log/secure**记录登录系统存取数据的文件，如POP3、SSH、Telnet、FTP等都会被记录。可以利用此文件找出不安全的登录IP,

### 记录登录者的数据
**/var/log/wtmp**记录登录者的信息数据，此文件已经被编码过(二进制)，用cat直接查看是不行的，必须使用last指令来取出文件的内容

### 记录登录时间
**/var/log/lastlog** ,此可执行文件可用/usr/bin/lastlog指令读取

### 服务器的邮件日志
**/var/log/messages**，如果要用专业的日志分析工具来分析的话，我推荐使用Awstats

### 输出 iptables 日志到一个指定的文件中
可以使用 iptables 在 Linux 内核中建立、维护和检查IP包过滤规则表
iptables默认把日志信息在 /var/log/messages

在有些情况下(比如你的 Linux 服务器是用来作为防火墙或NAT路由器的)，你可能需要修改日志输出的位置
1. 打开/etc/syslog.conf 文件 # vim/etc/syslog.conf
2. 在文件末尾加入下面这行信息:**kern.warning /var/log/iptables.log**
3. 保存关闭文件，使用下面的命令重新启动syslogd **/etc/init.d/syslog restart**

### 日志文件的专业工具
Apache、Nginx、Squid推荐使用专业工具（如Awstats、Cacti）来分析。MySQL 的 binlog 日志可以用mysqlbinlog 来分析，Cacti 多用于 Nginx 负载均衡器一段时间内的并发情况及服务器的流量异常情况。

### 用 dmesg 查看启动消息
dmesg 可简单地查看系统启动信息。当Linux启动的时候，内核的信息被存入内核 ring缓存中，dmesg可以显示缓存中的内容。dmesg | grep error 其实看到的就是/var/log/dmesg 中的内容

### cron 日志
默认在 /var/log 下，可以看 /etc/syslog.conf 的配置 grep cron /etc/syslog.conf
cron失败，crontab日志会给用户发一封邮件，如果cron失败，邮件也失败，看看mail的日志，是否磁盘满了而造成的

**0 6 * * * root /root/test_file.sh >> /data/log/mylog.log 2 >&1