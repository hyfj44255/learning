## monitoring 命令
- **dmesg** hardware/system info
- **iostat** average CPU load,disk activity iostat -xz 1 还是使用 
- **iotop** **lsof**
- **vmstat** system activity
- **mpstat** multiprocess usage 监测单个CPU情况
- **pmap** process mem usage
- **strace** program
- **ulimit** system limits


### 系统信息
1. **lscpu**

2. **cat /proc/cpuinfo**

3. **nproc**

6. **vmstat**
    ```bash
    vmstat --wide 1 --unit M
    ```
7. **numactl**
    ```bash
    numactl --hardware
    ```
8. **cat /proc/meminfo**

9. **dmidecode**

10. **grep -i "model name" /proc/cpuinfo**


## Top/W/Uptime 平均负载
```
load average: 0.00, 0.01, 0.05 2/352 12:34:56
```
这里的三个数字解读如下：

1. **0.00**：表示过去1分钟内的平均负载。
2. **0.01**：表示过去5分钟内的平均负载。
3. **0.05**：表示过去15分钟内的平均负载。

当系统负荷持续大于0.7时应引起注意，超过1.0则需要采取措施,对于多处理器和多核CPU，负荷应除以核心总数，保持每个核心负荷不超过1.0。15分钟的系统负荷是评估长期性能的重要指标。

系统负载不仅受CPU使用率影响，还受到I/O、内存和其他资源的影响。因此，高负载可能是由于多种因素造成的，需要综合分析。

`load average`的解释依赖于CPU的核心数。对于多核系统，`load average`超过核心数并不一定意味着系统过载，因为多核可以并行处理多个任务。(需要确认)

### 在实际生产环境中，平均负载多高时，需要我们重点关注呢？

在我看来，当平均负载高于 CPU 数量 80% 的时候，你就应该分析排查负载高的问题了。一旦负载过高，就可能导致进程响应变慢，进而影响服务的正常功能。但 80% 这个数字并不是绝对的，最推荐的方法，还是把系统的平均负载监控起来，然后根据更多的历史数据，判断负载的变化趋势。当发现负载有明显升高趋势时，比如说负载翻倍了，你再去做分析和调查。

## 网络相关的性能

1.**tcpdump** 

1. **ifconfig**: The `ifconfig` command displays information about network interfaces, including IP addresses, MAC addresses, and network statistics such as input and output packets, errors, and collisions.

2. **ip**: The `ip` command is a more advanced tool for network configuration and monitoring. It can display detailed information about network interfaces, routes, and other networking parameters.
    Example:
    ```
    ip addr show
    ip route show
    ```
3. **ping**: The `ping` command is used to test network connectivity and measure round-trip time between the local host and a remote host. It can help you diagnose network connectivity issues.

4. **traceroute**: The `traceroute` command shows the route that packets take to reach a destination host. It can help you identify network latency and routing issues.  Example: traceroute google.com



6. **ss**: The `ss` command is a modern replacement for `netstat` and provides more detailed information about network connections and socket statistics.  Example: ss -s

7. **iftop**: The `iftop` command is a real-time network bandwidth monitoring tool that displays a list of network connections and their bandwidth usage.

8. **nload**: The `nload` command is another tool for monitoring network traffic and bandwidth usage in real-time. It provides a graphical representation of network traffic.


## telnet nslookup 查询 port 端口命令是啥 telnet 是 ping 端口

In Linux, you can check which ports are currently in use using several commands. Here are some common commands to check which ports are being used:

1. **netstat**: The `netstat` command displays network connections, routing tables, interface statistics, masquerade connections, and multicast memberships. You can use `netstat` to view a list of open ports and the processes that are using them.  Example: ``` netstat -tuln ```

    This command will display all listening (-l) TCP (-t) and UDP (-u) ports along with the numeric (-n) port numbers.

2. **ss**: The `ss` command is a modern replacement for `netstat` and provides more detailed information about network connections and socket statistics.  Example: ``` ss -tuln ```

    This command will display all listening (-l) TCP (-t) and UDP (-u) ports along with the numeric (-n) port numbers.

3. **lsof**: The `lsof` command lists open files, including network connections. You can use `lsof` to list all open files associated with a specific process or network connections.  Example: ``` lsof -i ```

    This command will list all network connections (-i) with the associated process information.

4. **nmap**: The `nmap` command is a network scanning tool that can be used to scan a host and identify open ports. It can be used to discover open ports on a remote host.  Example: ``` nmap localhost ```

    This command will scan the localhost and display a list of open ports.

5. **ss**: The `ss` command can also be used to list listening ports on a system.  Example: ``` ss -ltn ```
    This command will display all listening (-l) TCP (-t) ports along with the numeric (-n) port numbers.

## 内存
有效空闲内存 = used - buffer - cache
可用内存 =  free + buffer + cache

## 怎么看硬盘 iostate

3. **iostat**: The `iostat` command is used to monitor system input/output (I/O) statistics, including disk utilization, read and write speeds, and I/O operations per second (IOPS).  Example: ``` iostat -x 1 ```
    This command will display detailed disk I/O statistics every 1 second.

4. **iotop**: The `iotop` command is a top-like utility that shows real-time disk I/O usage by processes. It can help you identify processes that are using the most disk I/O.  Example: ``` iotop ```

    This command will display real-time disk I/O usage by processes.

5. **smartctl**: The `smartctl` command is used to monitor and control Self-Monitoring, Analysis, and Reporting Technology (SMART) data on hard drives and SSDs. It can provide information about disk health and performance.  Example: ``` smartctl -a /dev/sda ```

    This command will display SMART data for the specified disk (`/dev/sda` in this example).

6. **hdparm**: The `hdparm` command is used to get or set hard disk parameters, including reading and testing disk performance.  Example: ``` hdparm -tT /dev/sda ```


## 负载模拟

	### stress --cpu 1 --timeout 600
	watch -d uptime

	mpstat -P ALL 5
	-P ALL 表示监控所有 CPU，后面数字 5 表示间隔 5 秒后输出一组数据

	间隔 5 秒后输出一组数据
	pidstat -u 5 1

	### stress -i 1 --timeout 600

	# 显示所有 CPU 的指标，并在间隔 5 秒输出一组数据

	$ mpstat -P ALL 5 1


	# 间隔 5 秒后输出一组数据，-u 表示 CPU 指标

	$ pidstat -u 5 1

	16个进程：
	stress -c 16 --timeout 600



  ## DNS记录类型：

		A记录：将域名指向IPv4地址。
		AAAA记录：将域名指向IPv6地址。
		CNAME记录：将域名指向另一个域名（通常用于别名设置）。
		MX记录：指定邮件服务器的域名，用于电子邮件服务。
		TXT记录：用于存储文本信息，常用于SPF（发送方策略框架）记录，以防止垃圾邮件。
		NS记录：指定域名的权威DNS服务器。
		SRV记录：指定服务的位置（如LDAP、XMPP等）。