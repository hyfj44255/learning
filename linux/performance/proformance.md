## 系统性能评判标准

![图片(D:/xxx/md/1.png)](./resources/system-proformance-judge.png)

## 创建单一线程的CPU密集型负载

**while :; do :; done**

## dmesg
dmesg | tail
查找可能导致性能问题的错误。上面的示例包括oom-killer和TCP丢弃请求。**不要错过这一步！dmesg 总是值得检查**。这些日志可以帮助排查性能问题。

## TOP
第一部分
- us: User CPU time; 高百分比代表 user processes (like web servers or databases) might be causing the load.
- sy: System CPU time; a high percentage suggests kernel processes may be contributing to the load.
- id: Idle CPU time; a higher percentage indicates the CPU is more available.
- wa: I/O wait time; a high percentage here suggests that the CPU is waiting on I/O operations, indicating possible memory or disk issues.

- USER: 进程属主用户名
- PR: 进程优先级
- NI: 进程谦让度
- VIRT: 进程占用的虚拟内存总量
- RES: 进程占用的物理内存总量
- SHR: 进程和其他进程共享内存总量
  - S: 进程状态
  - D 可客终端的休眠
  - R 运行
  - S 修休眠
  - T 被跟踪/停止
  - Z 僵化，进程已结束，父进程无响应
- %CPU 使用CPU时间比例
- %MEM 使用的可用物理内存比例
- TIME+ 进程启动到目前为止占用 CPU 时间总量
- COMMAND: 进程所对应的命令行名称，也就是启动的程序名

top 默认按照%CPU 值排序进程进行,
- 输入f 选择排序字段 顶部有操作说明
- d 修改轮询间隔

P 根据CPU多少进行排序
T 根据时间、累计时间排序
m 切换显示内存信息
t 切换显示进程和 CPU状态信息
c toggle 命令名称和完整命令行
M 内存大小排序
W 设置写入 ~/.toprc 文件中

**top -p 6903** 查看某个pid

Use **top -H -p <PID>** to view individual threads within the process and identify any threads consuming excessive CPU.

## PS 

%CPU 该进程占用 CPU 的时间与该进程总的运行时间比
%MEM 占用内存/总内存
VSZ 占用虚拟内存大小 kb
RSS 占用物理内存 kb
TTY 进程建立时对应的终端 ？表不占用
sATAT 运行状态 
  D 不可中断睡眠
  R 就绪
  S 睡眠
  T 被跟踪或者停止
  Z 僵尸
  W 没有足够内存分页可分配
  < 高优先级进程
  N 第优先级进程
  L 有内存分页分配，并锁在内存体 （实时系统或io）
START 进程开始时间
TIME 执行时间
COMMAND

**ps axjf** 树形显示进程

## pgrep nginx
显示 nginx的pid

## kill
-s 指定发送的信号
-p 模拟发送信号
-l 指定信号的名称列表
pid
signal 表示信号

## killall
killall nginx 
否则如果通过 kill pid 需要杀死 nginx相关的所有 pid

## CPU
```shell
cat /proc/cpuinfo | grep "physical id" | sort | uniq|wc -l # 查看物理 CPU核心数量
cat /proc/cpuinfo | grep "cpu cores" | uniq # 每个物理 CPU 中 core个数
cat /proc/cpuinfo | grep "processor" | wc -l # 逻辑 CPU 个数

```
### CPU问题分析

sudo perf top

## CPU-hungry system calls: 
Run **sysdig -c topprocs_cpu** to see the top CPU-consuming system calls.


## 查看内存
```bash
free -m
```
- total 总数
- used 已经使用的内存
- free 空闲的内存
- shared 多个进程共享的内存总额
- -buffers/cache 已用内存总数，used - buffer - cached
- +buffers/cache 可用内存总数 free + buffers + cached

可用内存 = free + buffers + cached

如果经常看到 swap 用了很多，就说明要考虑增加内存了

+buffers/cache 对应用程序来讲属于可用内存，作用是可提高程序执行速度

buffer是对磁盘数据的缓存，cache是对文件数据的缓存，它们既会用在读请求也会用在写请求中

## 硬盘使用情况

```shell
# 硬盘及分区信息
fdisk -l

# 文件系统的磁盘占用情况
df -h
```

### 硬盘 io 性能

当遇到高 I/O 等待问题时，您应该检查的第一件事就是机器是否使用了大量交换。由于硬盘比 RAM 慢，当系统用完 RAM 并开始在服务器中使用交换时，服务器的性能会受到影响。任何想要访问磁盘的东西，都必须与交换空间竞争磁盘 I/O。因此，您首先要诊断是否内存不足，如果是，则在那里解决问题。如果您的服务器中有足够的 RAM，则需要找出哪个程序获取了最多的 I/O。有时很难确切地找出哪个进程占用了高 I/O，但如果您的系统中有多个分区，则可以通过找出哪个分区获取了最多的 I/O 来缩小范围。为此，您将需要 iostat 程序

```shell
iostat -c 3 5 # -c 显示cpu使用情况
iostat -d -x -k 1 10  #-d 显示磁盘使用情况 %util 列代表磁盘压力
```
rrqm/s merge 操作数量
wrqm/s merge 写操作
r/s i/o 设备次数
avgrq-sz 平均每次设备 i/o 操作数据大小
avgqu-sz 平均 io 队列长度,average disk queue length
await 平均每次设备io 等待时间

%util 一秒钟有百分之多少时间用于io操作

%util 如果接近 100%，说明产生的 io请求太多，io负荷已经满了 磁盘可能存在瓶颈

await 大小取决于服务时间 (svctm),以及io队列长度和请求发出的模式。这响应时间应该小于5ms，否则要考虑更换更快的磁盘，调整内核 elevator 算法 ，优化应用，或者升级 cpu

buckup: **iostat -xz 1** svctm column, which indicates the average disk service time.


**iostat -h -t**
- t: print the time for each report displayed
- h : human readable

- kB_dscd/s: indicates the amount of data discarded for the device expressed in kilobytes per second.
- kB_dscd: the total amount of data discarded in the interval

### 查看某个目录大小
```shell
du -sh /root
```

找出分区内用空间最多的文件或目录

```shell
du -cks * | sort -rn | head -n 10
```

## vmstat

uptime 查看系统负载，如果负载过高，用 **vmstat** 查看系统是否过于繁忙
如果r经常大于系统的**逻辑 CPU**个数，且**id**经常少于 **50** ,表示 **CPU** 负荷很重
```shell
vmstat --wide 1 --unit M
```

### vmstat 监控系统整体性能
```shell
# 每隔一秒输出4组数据
vmstat 1 4
```

- Procs sector下
  - r 等待运行的进程数,多少个进程真的分配到CPU，和top的负载有关系，超过CPU数就会出现cpu瓶颈
  - b 非中断睡眠的进程数量，阻塞的进程；等待资源的进程数，比如正在等待IO或者内存交换
  - w 被交换出去的可运行的进程数
  - 标准情况下 r 和 b 应该为 r<5 b约等于0

- Memory sector下 
  - swpd: 虚拟内存使用情况，如果大于0，表示你的机器物理内存不足了，如果不是程序内存泄露的原因，那么你该升级内存了或者把耗内存的任务迁移到其他机器

- Swap sector下
  - si 从磁盘交换到内存的交换页数量， 每秒从磁盘读入虚拟内存的大小，如果这个值大于0，表示物理内存不够用或者内存泄露了，要查找耗内存进程解决掉
  - so 每秒虚拟内存写入磁盘的大小，如果这个值大于0，同上。
  - 一般情况下， si、 so 的值都为 0， 如果 si、 so 的值长期不为 0， 则表示系统内存不足。需要增加系统内存。


- io
  - bi 块设备每秒接收的块数量，这里的块设备是指系统上所有的磁盘和其他块设备，默认块大小是1024byte kb/s（即读磁盘 kb/s
  - bo 写到块设备的数据总量（即写磁盘 kb/s
  参考 bi+bo 参考值为1000,过了1000,而且wa 数值较大，说明io有问题，要考虑提升磁盘读写性能

- cpu 按cpu使用百分比显示
  - in 某一时间间隔内观测到的每秒设备中断数
  - cs （context switch） 每秒上下文切换次数。 cs in越大，由内核消耗的CPU时间月多
  - us cpu用户模式下使用时间，曾经在一个做加密解密很频繁的服务器上，可以看到us接近100,r运行队列达到80(机器在做压力测试，性能表现不佳)。 us 的值比较高时，说明用户进程消耗的 cpu 时间多，但是如果长期大于 50%，就需要考虑优化程序或算法
  - sy 系统CPU时间，如果太高，表示系统调用时间长，例如是IO操作频繁。Sy的值较高时，说明内核消耗的CPU 资源很多。
  - id 闲置时间 一般来说，id + us + sy = 100,一般我认为id是空闲CPU使用率，us是用户CPU使用率，sy是系统CPU使用率
  - 根据经验， us+sy的参考值为 80%， 如果 us+sy大于 80%说明可能存在 CPU 资源不足。
  - **wa** 列显示了 IO 等待所占用的 CPU 时间百分比。wa 值越高，说明 IO 等待越严重，根据经验，wa 的参考值为 20%，如果 wa 超过 20%，说明 IO 等待严重，引起 IO 等待的原因可能是磁盘大量随机读写造成的， 也可能是磁盘或者磁盘控制器的带宽瓶颈造成的（主要是块操作） 。

user% + sys% <70% 表示系统性能较好
user% + sys% >= 85% 系统性能比较糟糕，需要全方位检查

### 使用举例
vmstat 1 1    #首先获取空闲系统的上下文切换次数
sysbench --threads=10 --max-time=300 threads run #模拟多线程切换问题

vmstat 1 1    #新终端观察上下文切换情况
此时发现cs数据明显升高，同时观察其他指标：
r列： 远超系统CPU个数，说明存在大量CPU竞争
us和sy列：sy列占比80%，说明CPU主要被内核占用
in列： 中断次数明显上升，说明中断处理也是潜在问题


**vmstat -a 1**
非活动页，活动页缓存明细

**vmstat -s** 
event counter statistic

## 查看系统内核

32位还是64位 ls -lF / grep /$

## 查看服务器使用的发行版相关信息
lsb_release -a

## linux 网络连接

```shell
# eth0 网络配置
ifconfig eth0

# eth0 ip 地址
ifconfig eth0 | grep "inet addr" |awk -F[:""]+ '{print $4}'

# 5 个数据包 ping baidu 看延迟
ping -c 5 baidu.com

# nslookup 查一台机器的IP和其对应的域名
nslookup
> mail.163.com

dig sina.com.cn # 查询A 记录
dig sina.com.cn ns # 查询 ns记录
dig sina.com.cn soa # 查询soa记录
# 在服务器上查询 sina.com.cn 记录
dig @127.0.0.1 sina.com.cn
#  从根服务器开始追踪域名解析过程
dig www.163.com +trace

# 查看 端口占用
lsof -i:22
# 查看文件系统阻塞 lsof /boot

# 查看端口号被哪个进程占用 lsof -i : 3306

# 查看用户打开哪些文件 lsof –u username

# 查看进程打开哪些文件 lsof –p 4838

# 查看远程已打开的网络链接 lsof –i @192.168.34.128
```

Test connectivity ,Verify if the port is open:

**telnet <server_ip> 22**

Check firewall rules:

**sudo ufw status sudo ufw allow 22/tcp**


### netstat

netstat 命令的功能是显示网络连接、路由表和网络接口的信息，可以让用户得知目前都有哪些网络连接正在运作

- -A:显示任何关联的协议控制块的地址。主要用于调试
- -a:显示所有套接字的状态。在一般情况下不显示与服务器进程相关联的套接字。
- -i:显示自动配置接口的状态。那些在系统初始引导后配置的接口状态不在输出之列。
- -m:打印网络存储器的使用情况
- -n:打印实际地址，而不是对地址的解释或显示主机、网络名之类的符号。
- -r:打印路由选择表。
- -f address:family会对于给出名字的地址簇打印统计数字和控制块信息,目前唯一支持的地址簇是 inet
- -i interface:表示只打印给出名字的接口状态。
- -p protocol-name:表示只打印给出名字的协议的统计数字和协议控制块信息。
- -s:打印每个协议的统计数字。
- -t:表示在输出显示中用时间信息代替队列长度信息

用得最多的也最习惯的有两个参数，即**netstat -an**
```bash
netstat -an | grep -v unix
```
其中 显示结果中 state 列含义如下

- LISTEN: 侦听来自远方的TCP端口的连接请求
- SYN-SENT :在发送连接请求后等待匹配的连接请求。
- SYN-RECEIVED: 在收到和发送一个连接请求后等待对方对连接请求的确认。
- ESTABLISHED: 代表一个打开的连接，我们常用此作为并发连接数
- FIN-WAIT-1: 等待远程TCP连接中断请求，或先前的连接中断请求的确认
- FIN-WAIT-2: 从远程TCP等待连接中断请求
- CLOSE-WAIT: 等待从本地用户发来的连接中断请求
- CLOSING: 等待远程TCP对连接中断的确认
- LAST-ACK: 等待原来发向远程TCP的连接中断请求的确认
- TIME-WAIT: 等待足够的时间以确保远程TCP接收到连接中断请求的确认
- CLOSED: 没有任何连接状态

常用Shell命令组合，用来查看服务器网络连接
```sh
netstat -an | awk '/^tcp/ { ++s[$NF]} END {for (a in S) print a, s[a]}'
TIME_WAIT 21 # 另一边已初始化一个释放。
ESTABLISHED 185 # 正常数据传输状态。它的值也可以近似理解为当前服务器的并发数
LISTEN 9 # 服务器在等待进入呼叫
# SYN_RECV:一个连接请求已经到达，等待确认。
# SYN_SENT:应用已经开始，打开一个连接。
# FIN_WAIT1:应用说它已经完成。
# FIN_WAIT2:另一边已同意释放。
# ITMED_WAIT:等待所有分组死掉。
# CLOSED:没有连接是活动的或正在进行的。
# CLOSING:两边同时尝试关闭。
LAST_ACK:等待所有分组死掉。
```

```bash
netstat –npl   # 可以查看你要打开的端口是否已经打开。
netstat –rn    # 打印路由表信息。
netstat –in    # 提供系统上的接口信息，打印每个接口的MTU,输入分组数，输入错误，输出分组数，输出错误，冲突以及当前的输出队列的长度。

netstat –i #查看路由情况 检查接口的错误计数器

netstat –r #查看网络接口状态/ 查看系统路由表 显示结果中 Flags=UG那一行就是系统默认网关

netstat -s # network error statistics. Look for high values in the errors column 查找高流量的重新传输和乱序数据包。哪些是“高”重新传输率依客 户机而不同，面向互联网的系统因具有不稳定的远程客户会比仅拥有同数据中心客户
的内部系统具有更高的重新传输率。

netstat -antp # 列出所有TCP的连接
netstat -nltp # 列出本地所有TCP侦听套接字，不要加-a参数

# 只想查看监听的TCP端口，可以使用：
netstat -tuln | grep TCP
```
**ss -tuln**
**ss -s**
to see the socket usage of each process.

**netstat -tuln**
- -t 显示TCP连接
- -u 显示UDP连接
- -l 显示监听中的服务端口
- -n 显示端口号而不是服务名称



### route
查看系统的路由表
```sh
route -n 
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.31.1    0.0.0.0         UG    600    0        0 wlp9s0
192.168.31.0    0.0.0.0         255.255.255.0   U     600    0        0 wlp9s0
# 所显示的内容中有UG的这行即是系统的默认网关
```

### ip

**ip addr show** see the network interface configuration.
**ip route show** network routing configuration
**iptables -n -L**  see the network firewall configuration.

### iftop
```bash
sudo apt install libpcap0.8 libpcap0.8-dev libncurses5 libncurses5-dev iftop

sudo iftop -P

```


## mpstat -P ALL 1

显示每个CPU的占用情况，如果有一个CPU占用率特别高，那么有可能是一个单线程应用程序引起的

## pidstat 1

buckup: **pidstat -C java -v/w**

进程的CPU占用率，该命令会持续输出，并且不会覆盖之前的数据，可以方便观察系统动态

- **pidstat -s -t -p 20731** -t，可以将进程中各个线程的详细信息罗列出来。-s 栈使用情况，-r 显示缺页错误和内存使用情况 -u CPU使用率

- **pidstat -d interval times** 统计各个进程的IO使用情况
  - kB_ccwr/s: 每秒进程向磁盘写入，但是被取消的数据量，This may occur when the task truncates some dirty pagecache.
  - iodelay: Block I/O delay, measured in clock ticks

- **pidstat -u interval times** 统计各个进程的CPU统计信息
  - %usr: 进程在用户空间占用 cpu 的百分比
  - %system: 进程在内核空间占用 CPU 百分比
  - %guest: 进程在虚拟机占用 CPU 百分比
  - %wait: 进程等待运行的百分比
- **pidstat -r interval times** 统计各个进程的内存使用信息
  - *pidstat -r -p 1 3* 获取内存 3 秒内的状态
  - Minflt/s : 每秒次缺页错误次数 （minor page faults），虚拟内存地址映射成物理内存地址产生的 page fault 次数
  - Majflt/s : 每秒主缺页错误次数 (major page faults), 虚拟内存地址映射成物理内存地址时，相应 page 在 swap 中
  - VSZ virtual memory usage : 该进程使用的虚拟内存 KB 单位
  - RSS : 该进程使用的物理内存 KB 单位
  - %MEM : 内存使用率
- **pidstat -w interval times** 统计各个进程的上下文切换
  - cswch 每秒自愿上下文切换次数 （进程无法获取所需资源导致的上下文切换）
  - nvcswch 每秒非自愿上下文切换次数 （时间片轮流等系统强制调度）

- 查看具体进程使用情况 **pidstat -T ALL -r -p 20955 1 10** p PID 指定PID

## strace

is a very dangerous tool, it can hang your process and might terminate it. So use only you have no option left.

**sudo strace -p XXX** 对app进程调用进行跟踪

## mtr/traceroute 命令

用 traceroute 轻松解追踪网络数据包的路径,数据包默认的大小为40字节

跟踪网络路由状态，推荐使用 mtr(my traceroute)，动态跟踪网络路由，用于排除网络问题非常方便。

用traceroute跟踪1个网络地址，其中第一条即为我们机器的网关(自己机器没成功)
```sh
traeroute www.163.com
# 以上是我们的机器到达 163.com 的数据包之间的完整路由，1 表示我们最近的路由器IP 地址
```
## pmap
pmap <PID> to analyze the memory usage of the process, including shared and private memory segments.