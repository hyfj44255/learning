

----

SecurityContext

使用容器镜像扫描工具，如Clair、Trivy、Aqua Security等，对容器镜像进行漏洞扫描，并及时更新修复漏洞。
集成漏洞扫描工具到CI/CD流程中，自动扫描新构建的镜像，及时发现和修复漏洞。
定期检查容器镜像的漏洞报告，及时更新基础镜像和应用程序，确保容器镜像的安全性。

HPA
VPA

## ELB ALB NLB
ALB (Application Load Balancer), NLB (Network Load Balancer), and Classic Load Balancer (ELB) are all load balancers provided by AWS, each with its own specific use cases and features. Here is a comparison of the three load balancers:

1. Classic Load Balancer (ELB):
   - ELB is the original load balancer service provided by AWS.
   - It operates at the OSI Layer 4 (Transport Layer) and Layer 7 (Application Layer).
   - ELB supports TCP, SSL, and HTTP protocols.
   - It provides basic load balancing capabilities and is suitable for simpler applications.
   - ELB offers features like health checks, SSL termination, and sticky sessions.

2. Application Load Balancer (ALB):
   - ALB is a more advanced load balancer introduced by AWS.
   - It operates at the OSI Layer 7 (Application Layer).
   - ALB is designed to route traffic based on advanced application-level information.
   - It supports features like content-based routing, host-based routing, and path-based routing.
   - ALB is ideal for modern containerized applications and microservices architectures.
   - ALB also supports WebSockets and HTTP/2.

3. Network Load Balancer (NLB):
   - NLB is a high-performance load balancer provided by AWS.
   - It operates at the OSI Layer 4 (Transport Layer).
   - NLB is designed to handle high volumes of traffic with low latency.
   - It is ideal for TCP traffic where extreme performance is required.
   - NLB supports static IP addresses and preserves the client's IP address.
   - NLB is suitable for applications that require ultra-high performance, such as gaming, finance, or IoT applications.

In summary, Classic Load Balancer (ELB) is suitable for basic load balancing requirements, Application Load Balancer (ALB) is ideal for modern applications with advanced routing needs, and Network Load Balancer (NLB) is designed for high-performance, low-latency applications. The choice of load balancer depends on the specific requirements of your application and the level of performance, scalability, and features needed.


# AVI Networks

## GTM LTM

# devop vs platfrom engineering

CALMS 来表示：文化（Culture）、自动化（Automation）、精益（Lean）、测量（Measurement）和共享（Sharing）
具体实例分析

ABC 公司的 DevOps 转型：在 ABC 公司，DevOps 实践的引入带来了文化转变。通过采用 Jenkins 等工具进行 CI/CD，并促进定期召开跨部门会议，团队能够将软件部署时间缩短 40%。这不仅仅是工具的改变，更是团队沟通和协作方式的改变，从而加快了问题解决的速度，提高了软件发布的频率。



XYZ 公司的平台工程： XYZ 公司的平台工程团队开发了一个自助服务门户，允许开发人员将应用程序部署到预配置环境中，只需最少的人工干预。这一举措大大缩短了部署时间，并确保了所有应用程序的安全性和合规性标准保持一致。 

越来越多的人认为，平台工程可以被视为 DevOps 的进化。DevOps 打破了开发与运维之间的壁垒，而平台工程则在此基础上更进一步，创造了一个能让这些简化流程蓬勃发展的环境。这就是要建立一个支持 DevOps 原则（持续集成、持续交付和快速部署）的生态系统

平台工程并不能取代 DevOps。相反，它是对 DevOps 的补充和扩展。平台工程提供工具和基础设施，使 DevOps 实践更加有效和高效。 



DevOps 和平台工程是软件开发和运营领域中相关但不同的领域。

DevOps 是一种文化和组织方法，强调开发团队和运营团队之间的协作和沟通，目标是更快、更可靠地交付软件。 DevOps 实践通常涉及自动化、持续集成和部署、监控和反馈循环，以改进软件开发和部署过程。

另一方面，平台工程专门关注设计、构建和维护支持应用程序和服务开发和部署的基础设施和软件平台。 平台工程师负责确保平台可扩展、可靠、安全和高效，并努力优化平台以满足组织的需求。

总之，DevOps 更侧重于软件开发和运营的文化和组织方面，而平台工程更侧重于设计和维护支持软件开发和部署的平台的技术方面。 这两个领域对于创建高效可靠的软件交付管道都很重要。


--------------------
36：41

## alb nlb ingress 关联

user --> cdn --> dns --> alb/nlb --> ingress (with alb/nlb ingress controller) --> service -->pod

ingress 是个ip吗，前面还有ip吗，alb 还有ip吗

gcd


ingress service pod kube proxy 怎么分发到 分布在node 中的pod的
43：26

configmap 挂载

redyness
liveness
check

startup check


------------------------------------------------------------

50:03

# readyness liveness 之外还有啥检查 startup Probe

 配置一个较长的 initialDelaySeconds 和 failureThreshold，以避免在容器启动过程中过早地进行健康检查
 只在 pod 启动作用，liveness 是pod全生命周期中

# 多个 pod 里有多个 container 

Jenkins Pod 就是多 container

sidecar 转发日志

共享pod 存储内容






## awk sed


## find grep 通配符是干啥的

## jernaltpm journalctl

## linux 系统日志存在哪儿

   /var/log：这是存放系统日志的主要目录。大多数系统日志文件都存放在这里，例如syslog、auth.log、kern.log等。

## pause container
		Pause容器：
		每个Pod里都会运行一个Pause的容器，其他容器则是我们运行的业务容器。业务容器共享Pause容器的网络栈和Volume，这样的设计可以将一组有密切关系的容器服务放在统一个Pod中。它之前通过localhost进行通信。

		Pause容器提供的功能：
		PID命名空间：提供进程隔离能力
		Net命名空间：提供网络隔离能力
		IPC命名空间：提供进程间通信的隔离能力
		UTS命名空间：提供主机名隔离能力
		负责回收僵尸进程


		1. **网络命名空间隔离**：每个Pod都有自己的独立网络命名空间，Pause容器负责创建并维护这个网络命名空间，使得Pod中的其他容器能够共享这个网络命名空间，从而实现容器间的网络隔离和通信。

		2. **进程隔离**：Pause容器保持一个轻量级的进程运行，即使Pod中的其他容器都停止了，这个进程仍然存在，确保了Pod不会在没有容器运行的情况下被删除。这有助于维持Pod的生命周期。

		3. **资源隔离**：虽然Pause容器通常不分配大量的CPU和内存资源，但它可以配置以使用一些资源。这有助于确保即使Pod中没有其他容器运行时，Kubernetes仍然可以监控和管理Pod的资源使用情况。

		4. **IP地址维护**：Pause容器负责维护Pod的IP地址。由于Pause容器一直在运行，它可以维护Pod的IP地址，以便其他容器可以通过该地址进行通信，确保Pod的IP地址在整个Pod的生命周期内保持一致。

		5. **生命周期管理**：Pause容器的生命周期与Pod的生命周期相同。当Pod创建时，Pause容器被创建；当Pod删除时，Pause容器也会被删除。这确保了Pod的整个生命周期都由Kubernetes进行管理。

		6. **PID Namespace共享**：Pause容器启用PID命名空间共享，为每个Pod提供1号进程，并收集Pod内的僵尸进程，这有助于管理和维护Pod内容器的进程。

		总的来说，Pause容器在Kubernetes中扮演着基础设施容器的角色，为Pod中的其他容器提供一个稳定的运行环境，并确保Pod的网络、进程和生命周期管理的一致性和稳定性。


## ansible

## chef

## 设置一些 infra 层级的 alert，prometheus alert manager设置一些告警

	在Prometheus中为bare metal或Linux虚拟机设置基础设施层级的告警（alert），你可以根据USE（Utilization, Saturation, Errors）和RED（Rate, Errors, Duration/Latency）这两个关键性能指标来设置告警规则。以下是一些基于这些指标的告警设置建议：

	1. **Utilization（利用率）**：
	   - **内存利用率**：监控可用内存低于某个阈值的情况，这可能表明系统即将耗尽内存资源。
		 ```yaml
		 - alert: HostOutOfMemory
		   expr: node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100 < 10
		   for: 2m
		   labels:
			 severity: warning
		   annotations:
			 summary: Host out of memory (instance {{ $labels.instance }})
			 description: Node memory is filling up (< 10% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}
		 ```
	   - **磁盘利用率**：监控磁盘空间即将耗尽的情况，预测磁盘将在24小时内填满。
		 ```yaml
		 - alert: HostDiskWillFillIn24Hours
		   expr: (node_filesystem_avail_bytes * 100) / node_filesystem_size_bytes < 10 and ON (instance, device, mountpoint) predict_linear(node_filesystem_avail_bytes{fstype!~"tmpfs"}[1h], 24 * 3600) < 0 and ON (instance, device, mountpoint) node_filesystem_readonly == 0
		   for: 2m
		   labels:
			 severity: warning
		   annotations:
			 summary: Host disk will fill in 24 hours (instance {{ $labels.instance }})
			 description: Filesystem is predicted to run out of space within the next 24 hours at current write rate\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}
		 ```

	2. **Saturation（饱和度）**：
	   - **CPU饱和度**：监控CPU使用率超过某个阈值，表明系统可能面临CPU瓶颈。
		 ```yaml
		 - alert: HighCPUUsage
		   expr: 100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
		   for: 1m
		   labels:
			 severity: warning
		   annotations:
			 summary: "Instance {{ $labels.instance }}: High CPU Usage Detected"
			 description: "Instance {{ $labels.instance }}: CPU usage is {{ $value }}%, which is above 80%"
		 ```

	3. **Errors（错误）**：
	   - **系统错误**：监控系统错误率，如磁盘I/O错误或其他硬件错误。
	   - **网络错误**：监控网络错误，如丢包率或连接错误。

	4. **Rate（速率）**：
	   - **请求速率**：监控进入系统的请求速率，确保系统能够处理高负载。

	5. **Duration/Latency（持续时间/延迟）**：
	   - **服务响应时间**：监控服务的响应时间，特别是95百分位的响应时间，以确保服务质量。
		 ```yaml
		 - alert: High95thResponseTime
		   expr: histogram_quantile(0.95, sum(rate(http_request_duration_ms_bucket[1m])) by (le, service, route, method)) > 500
		   for: 60s
		   annotations:
			 summary: "95th percentile response time exceeded on {{ $labels.service }} and {{ $labels.method }} {{ $labels.route }}"
			 description: "{{ $labels.service }}, {{ $labels.method }} {{ $labels.route }} has a 95th percentile response time above 500ms (current value: {{ $value }}ms)"
		 ```

	6. **Pod重启告警**：
	   - **Pod重启**：监控Pod频繁重启的情况，这可能表明Pod存在问题。
		 ```yaml
		 - alert: PodRestarts
		   expr: increase(kube_pod_restarts_total[5m]) > 5
		   for: 1m
		   labels:
			 severity: critical
		   annotations:
			 summary: "Pod {{ $labels.pod }} is restarting frequently"
			 description: "Pod {{ $labels.pod }} has restarted more than 5 times in the last 5 minutes"
		 ```

	这些告警规则可以根据你的具体需求进行调整和扩展。记得将这些规则保存在`.yml`文件中，并在Prometheus的配置文件`prometheus.yml`中通过`rule_files`字段引入这些规则文件。


## K8S 上面有个简单应用几个deployment 前端后端都有，做监控要看那些指标呢 infra级别 不是应用（还是上一个问题
		idel CPU
		system load 1，5，10  node_load1
		memory usage

		### 1. 基础设施层级指标

		1. **CPU使用率**：
		   - 监控CPU的总体使用率，以及每个核心的使用情况。

		2. **内存使用率**：
		   - 监控总内存使用量和可用内存，以及内存页面交换（swap）的使用情况。

		3. **磁盘I/O**：
		   - 监控磁盘的读写速率和I/O等待时间。

		4. **网络流量**：
		   - 监控入站和出站的网络流量，以及丢包率。

		5. **磁盘使用率**：
		   - 监控各个磁盘分区的使用情况，预测磁盘空间何时耗尽。

		6. **系统负载**：
		   - 监控系统的1分钟、5分钟和15分钟平均负载。

		### 2. Kubernetes集群层级指标

		1. **节点状态**：
		   - 监控Kubernetes节点的状态，包括节点是否Ready。

		2. **Pod状态**：
		   - 监控Pod的状态，包括Running、Pending、Failed等状态的数量。

		3. **服务发现**：
		   - 监控Kubernetes服务和DNS解析的健康状态。

		4. **API服务器性能**：
		   - 监控Kubernetes API服务器的请求延迟和错误率。

		5. **调度器和控制器管理器**：
		   - 监控Kubernetes调度器和控制器管理器的性能和健康状态。

		6. **资源配额和限制**：
		   - 监控命名空间的资源使用情况，确保没有超出配额。

		### 3. 网络层级指标

		1. **网络策略**：
		   - 监控网络策略的实施情况，确保流量符合预期的安全策略。

		2. **服务网格性能**（如果使用）：
		   - 监控如Istio等服务网格组件的性能和健康状态。

		### 4. 存储层级指标

		1. **持久卷使用情况**：
		   - 监控Persistent Volumes的使用情况，确保存储资源得到合理分配。

		2. **存储类性能**：
		   - 监控不同存储类的性能，包括读写速率和延迟。

		### 5. 应用层级指标（对于前端和后端应用）

		1. **应用性能**：
		   - 监控应用的响应时间和错误率。

		2. **资源使用情况**：
		   - 监控应用的CPU和内存使用情况，以及Pod的重启次数。

		3. **服务健康检查**：
		   - 监控应用的服务健康检查结果，包括Liveness和Readiness Probes。

		4. **日志分析**：
		   - 监控和分析应用日志，以发现异常和错误。

		### 6. 安全性指标

		1. **安全事件**：
		   - 监控安全相关的事件，如未授权访问尝试。

		2. **合规性检查**：
		   - 监控Kubernetes集群的配置，确保符合安全合规性要求。

		通过监控这些指标，你可以确保Kubernetes集群及其运行的应用程序的稳定性和性能。你可以使用Prometheus的Grafana仪表板来可视化这些指标，并设置告警规则以自动通知潜在的问题。


## k8s 部署在 bare metal server 突发 node 倒了我们也应该监控，这个是想说我们还可以监控一些service的状态 deploment 状态或者是其他的

## 在 prometheus 做一些比较复杂的rule 来匹配所有的应用，复杂的公式，监控所有infra层级的 alert，

## K8S 、VM 、中间件、nginx 、redis 监控他们需要什么指标呢，比如 nignx apache 应用那些指标比较关键，重点关注呢

		在监控 Kubernetes (K8s)、虚拟机 (VM) 以及中间件（如 NGINX 和 Redis）时，需要关注一系列关键指标，以确保系统的健康和性能。以下是每个组件的重点监控指标：

		### 1. Kubernetes (K8s) 监控指标

		#### 节点级别
		- **CPU 使用率**：监控节点的 CPU 使用情况，识别潜在的资源瓶颈。
		- **内存使用情况**：检查节点的内存使用量以及可用内存，确保没有内存耗尽的风险。
		- **磁盘 I/O**：监控磁盘的读写速率，以及 I/O 等待时间，确保数据存取顺畅。
		- **网络流量**：监控节点的网络流量，包括发送和接收的数据包。

		#### Pod 和容器级别
		- **Pod 状态**：监控 Pod 的状态（Running、Pending、Failed 等），确保应用正常运行。
		- **容器重启次数**：记录每个容器的重启次数，识别可能的应用问题。
		- **CPU 和内存使用**：监控每个容器的 CPU 和内存使用情况，确保资源合理分配。

		### 2. 虚拟机 (VM) 监控指标

		- **CPU 使用率**：监控虚拟机的 CPU 使用情况，确保没有超负荷。
		- **内存使用情况**：检查虚拟机的内存使用量和可用内存，防止内存耗尽。
		- **磁盘使用率**：监控磁盘空间使用情况，确保未达到容量上限。
		- **网络延迟和带宽**：监控虚拟机的网络延迟和带宽，确保网络性能良好。

		### 3. NGINX 监控指标

		- **请求总数**：监控处理的总请求数，以评估流量。
		- **响应时间**：记录请求的平均响应时间，识别性能瓶颈。
		- **状态码分布**：监控 HTTP 状态码的分布（如 2xx、4xx、5xx），识别错误请求的来源。
		- **连接数**：监控当前活跃连接数和最大连接数，确保 NGINX 能够处理流量峰值。

		### 4. Redis 监控指标

		- **内存使用**：监控 Redis 实例的内存使用情况，确保不会超出配置的最大内存限制。
		- **命中率**：监控缓存命中率，评估 Redis 的缓存效率。
		- **请求速率**：记录每秒请求的数量，确保 Redis 能够处理流量。
		- **慢查询**：检查慢查询日志，优化性能。

## ice bger？ ansible 或者 python 脚本批量转



72： 48

## cacho base

top 1 5 15 超过2.0负载高，跟啥有关

## 设置一些infra 层级的alert

深入理解linux cpu负载
https://zhuanlan.zhihu.com/p/715019669

https://mp.weixin.qq.com/s?__biz=MzI2NzM1OTM4OA==&mid=2247508762&idx=1&sn=9622177e02028bddf45d590b3442d281&chksm=ebad73842a113974f1366ceb3b654b3025bef463c5048e752eb1cca84040f5ddb2bcd0b06b0a&scene=27


10.6　Linux下常见的性能分析工具 / 256
10.6.1　vmstat命令 / 256
10.6.2　sar命令 / 258
10.6.3　iostat命令 / 260
10.6.4　free命令 / 262
10.6.5　uptime命令 / 263
10.6.6　netstat命令 / 263
10.6.7　top命令 / 265
iotop
ps axjf
某个端口被谁占用
 lsof -i :9090
  netstat -tulnp | grep 9090
  ss -tlnp | grep 80
  fuser 9090/tcp

https://www.cnblogs.com/aquester/archive/2012/07/24/9891974.html

https://zhuanlan.zhihu.com/p/574521127

## 集群安装培训课件



	
# linux 版 portforward
 ssh -L 9090:localhost:9090 root@47.104.107.175
 
 
# 架构 direct connect
		好的,让我详细展开每个部分：

		1. 核心基础设施

		A. VPC设计
		- 网段规划
		```
		生产环境: 10.0.0.0/16
		- 公有子网: 10.0.1.0/24, 10.0.2.0/24 (多可用区)
		- 私有子网: 10.0.11.0/24, 10.0.12.0/24 (多可用区)
		- 数据库子网: 10.0.21.0/24, 10.0.22.0/24
		```

		B. 多区域架构设计
		```
		主区域(Primary): us-east-1
		备用区域(DR): us-west-2
		- 区域间VPC对等连接或Transit Gateway
		- 跨区域负载均衡策略
		- 数据同步(S3跨区域复制、数据库主从复制)
		```

		2. 安全架构

		A. IAM策略示例
		```json
		{
			"Version": "2012-10-17",
			"Statement": [
				{
					"Effect": "Allow",
					"Action": [
						"ec2:Describe*",
						"ec2:StartInstances",
						"ec2:StopInstances"
					],
					"Resource": "*",
					"Condition": {
						"StringEquals": {
							"aws:RequestedRegion": ["us-east-1"]
						}
					}
				}
			]
		}
		```

		B. 安全控制
		```
		- 网络层面：安全组、NACL、WAF
		- 应用层面：SSL/TLS、API网关认证
		- 数据层面：加密存储、传输加密
		```

		3. 应用架构

		A. Kubernetes集群设计
		```yaml
		管理面配置：
		- 控制平面高可用
		- etcd备份策略
		- 准入控制配置

		节点组配置：
		- 按工作负载类型分组
		- 自动扩缩容策略
		- 资源预留配置
		```

		B. 服务网格架构
		```
		Istio组件部署：
		- 流量管理
		- 安全策略
		- 可观测性
		```

		4. 监控和运维

		A. 监控架构
		```
		指标收集：
		- 系统层：CPU、内存、磁盘、网络
		- 应用层：响应时间、错误率、吞吐量
		- 业务层：用户活动、交易量

		告警策略：
		- P0: 立即响应 (5分钟)
		- P1: 30分钟内响应
		- P2: 4小时内响应
		```

		B. IaC示例 (Terraform)
		```hcl
		module "vpc" {
		source = "terraform-aws-modules/vpc/aws"
		
		name = "main-vpc"
		cidr = "10.0.0.0/16"
		
		azs             = ["us-east-1a", "us-east-1b"]
		private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
		public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
		
		enable_nat_gateway = true
		single_nat_gateway = false
		}
		```

		5. 成本优化

		A. 资源标签策略
		```yaml
		强制标签：
		Environment: [prod|dev|stage]
		Owner: [team-name]
		Project: [project-name]
		CostCenter: [cost-center-id]
		```

		B. 成本控制
		```
		- 自动关闭非生产环境资源
		- Spot Instance策略
		- 存储生命周期管理
		```

		6. 规范和标准

		A. 命名规范
		```
		资源命名格式：
		[environment]-[service]-[resource-type]-[region]

		例如：
		prod-web-alb-use1
		dev-api-eks-use1
		```

		B. 部署流程标准
		```
		CI/CD流水线：
		1. 代码检查
		2. 单元测试
		3. 安全扫描
		4. 构建容器镜像
		5. 部署到开发环境
		6. 集成测试
		7. 部署到生产环境
		```

		7. 合规性框架
		```
		安全合规检查清单：
		□ 数据加密
		□ 访问控制
		□ 审计日志
		□ 漏洞扫描
		□ 备份策略
		□ 灾难恢复计划
		```

		8. 性能优化

		A. 缓存策略
		```
		多级缓存：
		- CDN (CloudFront)
		- 应用缓存 (Redis)
		- 数据库缓存
		```

		B. 数据库优化
		```
		- 读写分离
		- 分片策略
		- 索引优化
		- 查询优化
		```

nohup wget https://mirrors.tuna.tsinghua.edu.cn/github-release/prometheus/prometheus/LatestRelease/prometheus-2.55.1.linux-amd64.tar.gz &
nohup wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz &
nohup wget https://dl.grafana.com/enterprise/release/grafana-enterprise-11.3.0.linux-amd64.tar.gz &


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# sonar scan 费时间，会用一会时间，你在pipeline怎么整

# trviy 扫描之后 升级了 依赖，怎么保证升级不会对prod造成不良影响

# jenkins pipeline 我们有2个app 跑不同的 java版本，怎么弄。切换 container？

# linux 很slow

# 2server file in serverA copy to server b

# 怎么看他们拷贝成功了

# 怎么确保增量copy

# 一旦有新文件了就copy 怎么做

# cron 设置 *****都代表啥

# cron触发了，传输正在进行，怎么不重复传送 怎么看已经有在传送的进程

# ansible怎么跑play book 并行串行 默认行为是啥

# deployment 改了image 默认行为是啥，怎么rollout？

# 有downtime，rollout 行为能在 yml里面设置吗

# readyness 是一直会被检查的吗，readyness liveness 区别是啥

# 怎么看 有多少pod 在接受 traffic


# 一个container 产log 一个消耗log ，怎么让他们共享 这个file

# 一个container发消息杀掉另外一个 container
	通过 提前设计的 http endpoint， container A 通过 localhost call 这个 http endpoint

# Ssl 一个 app 在另外一个app上登陆认证，用ssl证书

# domain已经有了，你的server对外暴露得是https，从哪儿能拿到证书

# ssl证书得trust怎么认证的，client怎么知道你是某个受信任org下得



# cold start in lambda func

		一段时间内没有被调用后，AWS 可能会释放与其相关的资源。当这个函数再次被触发时，AWS 需要重新初始化环境，加载代码和依赖项，然后才能执行函数。这个过程就被称为 "cold start"。"Cold start" 可能会导致函数的执行延迟增加

# 能给 lambda设置 secritiy group吗

# vpc中的lambnda 和私有云交互

		要实现AWS VPC中的Lambda函数与公司内部的裸金属服务器（Bare Metal Server, BMS）进行交互，你需要考虑以下几个步骤：

		1. **网络配置**：
		- 确保AWS VPC与公司内部网络之间有网络连接。这可以通过AWS Direct Connect或VPN连接实现。这样，AWS VPC中的资源（包括Lambda函数）就可以与公司内部的裸金属服务器通信。

		2. **安全组和NACL配置**：
		- 配置VPC的安全组（Security Groups）和网络访问控制列表（Network Access Control Lists, NACLs），以允许Lambda函数与公司内部裸金属服务器之间的流量。这意味着你需要在安全组和NACL中添加相应的规则来允许这种通信。

		3. **路由表配置**：
		- 配置VPC的路由表，以确保流量可以正确地从Lambda函数路由到公司内部的裸金属服务器。如果Lambda函数和裸金属服务器位于不同的VPC或子网中，你需要确保路由表中有指向裸金属服务器网络的路由。

		4. **IAM权限**：
		- 确保Lambda函数的执行角色（Execution Role）具有访问VPC资源的权限。这通常涉及到附加AWS托管的策略`AWSLambdaVPCAccessExecutionRole`到Lambda函数的执行角色，以允许Lambda函数创建和管理网络接口。

		5. **私有连接**：
		- 如果公司内部的裸金属服务器托管在AWS外部，可以考虑使用AWS PrivateLink来建立一个私有连接。这样，Lambda函数可以通过VPC终端节点安全地访问公司内部的服务，而无需通过公共互联网。



# lambda talke 2 ec2

		AWS Lambda 函数和 EC2 实例之间的交互可以通过几种不同的方式实现。以下是一些常见的方法：

		1. **直接网络通信**：
		- 如果你的 Lambda 函数和 EC2 实例都在同一个 VPC 内，它们可以直接通过私有 IP 地址进行通信。你需要确保 Lambda 函数的网络配置允许它访问 VPC，并且 EC2 实例的安全组和网络 ACL 允许来自 Lambda 函数的流量。

		2. **安全组配置**：
		- 配置 EC2 实例的安全组，允许来自 Lambda 函数的流量。你需要知道 Lambda 函数在 VPC 内的源 IP 地址范围，这通常是 VPC 的某个特定范围，可以在 Lambda 函数的配置中找到。

		3. **Lambda 执行角色权限**：
		- 确保 Lambda 函数的执行角色（Execution Role）有权限访问 EC2 实例。这可能需要添加策略，允许 Lambda 函数调用 EC2 API，例如 `ec2:DescribeInstances`。

		4. **使用 API 网关**：
		- 如果 Lambda 函数需要通过 HTTP 请求与 EC2 实例交互，你可以使用 API 网关来创建一个 RESTful API，Lambda 函数可以调用这个 API 来与 EC2 实例通信。

		5. **使用消息队列**：
		- 使用 Amazon SQS 或 Amazon SNS 作为中介，Lambda 函数可以发送消息到队列或主题，EC2 实例可以从队列或订阅主题来接收消息。

		6. **使用负载均衡**：
		- 如果 EC2 实例后面有一个 Classic Load Balancer 或 Application Load Balancer，Lambda 函数可以直接调用负载均衡器的公网或私网 DNS 名称来与 EC2 实例通信。

		7. **使用 VPC 端点**：
		- 如果 Lambda 函数需要访问 VPC 外部的服务，比如 Amazon S3，你可以使用 VPC 端点来保持流量在 AWS 网络内部。

		8. **使用 ENI 配置**：
		- Lambda 函数可以配置为使用一个 Elastic Network Interface (ENI)，这样它就可以有一个固定的私有 IP 地址，这个地址可以用来与 EC2 实例通信。

		9. **使用 AWS PrivateLink**：
		- 如果你的 EC2 实例托管在一个服务（如 Amazon RDS）后面，你可以使用 AWS PrivateLink 来创建一个私有连接，Lambda 函数可以通过这个私有连接安全地访问服务。

		10. **使用 AWS Step Functions**：
			- 如果你需要协调多个 AWS 服务的工作流，包括 Lambda 和 EC2，你可以使用 AWS Step Functions 来管理这些交互。

		在设置 Lambda 函数和 EC2 实例之间的交互时，你需要考虑安全性、网络配置、权限和成本等因素。确保你的配置符合你的安全策略，并且 Lambda 函数和 EC2 实例之间的通信是高效和可靠的。


# vpc里面的2 subnet 他们能相互通信吗
		在AWS VPC（Virtual Private Cloud）中，同一VPC内的不同子网（Subnet）默认情况下是可以相互通信的，只要它们满足以下条件：

		1. **同一VPC内**：两个子网必须属于同一个VPC。

		2. **安全组（Security Groups）**：实例的安全组规则必须允许它们之间的通信。这意味着，如果两个子网中的实例需要相互通信，它们的安全组规则需要允许来自另一个子网的流量。

		3. **网络访问控制列表（NACL）**：子网的网络访问控制列表（NACL）规则也必须允许它们之间的流量。NACL是子网级别的安全规则，它们可以允许或拒绝流量。

		4. **路由表**：如果子网配置了不同的路由表，那么路由表中的路由规则必须允许流量从一个子网流向另一个子网。通常，如果两个子网都配置了默认路由指向Internet Gateway或NAT Gateway，它们之间的流量是可以正常路由的。

		5. **无ACL限制**：如果VPC没有配置任何网络ACL，或者ACL规则允许两个子网之间的流量，那么它们可以通信。

		6. **无防火墙限制**：如果VPC中没有配置网络防火墙（如AWS Network Firewall）或其他防火墙设备，这些设备可能会限制子网间的通信。

		如果以上条件都满足，那么同一VPC内的两个子网中的实例可以相互通信，无论是通过私有IP地址还是公网IP地址（如果实例被分配了公网IP）。这种通信可以是直接的，也可以是通过VPC内部的其他网络服务和组件，如负载均衡器、数据库等。

		需要注意的是，如果子网位于不同的可用区（Availability Zone），它们仍然可以通信，因为VPC是跨越多个可用区的。但是，跨可用区的通信可能会受到网络延迟和带宽的影响。

# security group

# 1app in aws 1 ec2 1 xx 

# 1个ec2里面跑着 mysql 另一个ec2怎么连他

# 怎么知道一个 vpc是公网还是 private
		在AWS中，VPC（Virtual Private Cloud）本身并没有“公有”或“私有”的标签，这种区分更多是依据VPC中子网的配置和用途来确定的。以下是一些判断VPC中子网是公有还是私有的方法：

		1. **子网的路由表配置**：
		- **公有子网（Public Subnet）**：如果一个子网的路由表配置中包含了指向Internet Gateway（IGW）的默认路由（0.0.0.0/0），那么这个子网可以被认为是“公有”的，因为它允许实例访问互联网，并且可以从互联网接收流量。
		- **私有子网（Private Subnet）**：如果一个子网的路由表中没有指向IGW的默认路由，而是指向NAT Gateway或NAT Instance的路由，那么这个子网可以被认为是“私有”的，因为它不允许直接从互联网接收流量。

		2. **实例的网络接口配置**：
		- **公有子网**：如果子网中的EC2实例被分配了公网IP地址（Elastic IP），那么这些实例可以直接访问互联网。
		- **私有子网**：如果子网中的EC2实例没有公网IP地址，只能通过NAT Gateway或NAT Instance来访问互联网，那么这些实例所在的子网可以被认为是“私有”的。

		3. **网络访问控制列表（NACL）和安全组（Security Group）**：
		- **公有子网**：通常，公有子网的安全组和NACL会允许从互联网到实例的入站流量。
		- **私有子网**：私有子网的安全组和NACL通常会限制从互联网到实例的入站流量。

		4. **服务端点**：
		- **私有子网**：如果VPC配置了服务端点（如S3端点），这些端点通常只能在私有子网中访问，因为它们提供了一种安全的方式来访问AWS服务，而不需要通过IGW。

		5. **直接互联网访问**：
		- 你可以尝试从VPC中的实例直接访问互联网。如果能够成功访问，那么这个实例所在的子网可能是公有子网。如果不能直接访问，那么它可能是私有子网。

		6. **AWS管理控制台**：
		- 在AWS管理控制台中，你可以通过查看VPC Dashboard和子网设置来确定子网的类型。公有子网通常会显示为“Public”，而私有子网会显示为“Private”。

		通过这些方法，你可以判断一个VPC中的子网是公有还是私有。记住，VPC的设计可以包含公有子网和私有子网，以满足不同的安全和访问需求。


# NACL SG啥关系区别

	1. **作用级别不同**：
	- **安全组（Security Group）**：作为虚拟防火墙，它在实例级别上工作，可以控制特定EC2实例或资源的入站和出站流量。
	- **NACL（Network Access Control List）**：作为另一个防火墙层，它在子网级别上工作，控制一个或多个子网的入站和出站流量。

	2. **状态性不同**：
	- **安全组**：是有状态的（stateful），如果一个入站规则允许流量，相应的响应流量会自动被允许，无需显式配置出站规则。
	- **NACL**：是无状态的（stateless），需要为入站和出站流量显式定义规则，允许的入站流量不会自动允许相应的出站流量。

	3. **规则评估方式不同**：
	- **安全组**：所有规则都会被评估，以确定是否允许流量。
	- **NACL**：规则是按编号顺序评估的，从编号最低的规则开始。

	4. **默认规则不同**：
	- **安全组**：默认情况下，拒绝所有入站流量，允许所有出站流量，但可以自定义规则。
	- **NACL**：默认情况下，允许所有流量，但可以通过自定义规则来改变这一行为。

vpc里面两个 subnet 一个公有一个私有 怎么看哪个是公网，哪个是私网 private

# netgateway & nat gateeway 区别是啥
	在AWS中，Internet Gateway（IGW）和NAT Gateway是两种不同的网络组件，它们在VPC（Virtual Private Cloud）中扮演着不同的角色，并且有着不同的关系和用途：

	1. **Internet Gateway（IGW）**：
	- IGW是一个高度可用的VPC组件，允许VPC与互联网之间的通信。
	- 它支持IPv4和IPv6流量，并且不会对网络流量造成可用性风险或带宽限制。
	- IGW使得公有子网中的资源（如EC2实例）如果拥有公网IPv4地址或IPv6地址，就可以连接到互联网。同时，互联网上的资源也可以通过公网IPv4地址或IPv6地址发起连接到你的子网中的资源。
	- IGW在IPv4通信中还执行网络地址转换（NAT）。

	2. **NAT Gateway**：
	- NAT Gateway是一种网络地址转换（NAT）服务，允许私有子网中的实例连接到VPC外部的服务，但外部服务无法启动与这些实例的连接。
	- NAT Gateway只允许内网访问外网，比如进行升级，而不允许外网主动连接到内网。
	- NAT Gateway需要绑定公网IP才能正常工作，创建后可以为NAT Gateway绑定弹性公网IP（EIP）。

	3. **关系**：
	- NAT Gateway需要与IGW一起工作，以便私有子网中的实例可以通过NAT Gateway访问互联网。NAT Gateway将实例的私有IP地址转换为公网IP地址，然后通过IGW将流量路由到互联网。
	- 私有子网中的服务器通过NAT Gateway对外访问需要修改路由表规则，配置路由地址到NAT Gateway，而NAT Gateway再通过IGW将流量路由到互联网。
	- 需要注意的是，NAT Gateway所在的VPC必须同时有一个IGW才能正常工作，因为NAT Gateway只是起到了内网IP向公网IP转换的作用，最终还是要通过IGW才能把流量发向互联网的。

	总结来说，IGW是VPC与互联网之间通信的桥梁，而NAT Gateway是私有子网访问互联网的代理，它们共同协作以实现VPC内部资源的安全、可控的互联网访问。


 terrafrom staging & prod env

 万一有人误删了 state file 咋办

 asible
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


擅长cicd 那么是在 onprim 还是 cloud呢，你有 onprime CICD经验吧？

CI  c dilivery c deployment 各代表啥

	1. **Continuous Integration（持续集成）**：
	- **目的**：频繁地将代码变更集成到主分支中，以便尽早发现集成错误。
	- **过程**：开发人员频繁地将代码提交到版本控制系统，自动化构建和自动化测试会随之触发，以确保新代码与现有代码兼容。
	- **结果**：持续集成可以减少集成问题，提高代码质量，并且加快开发速度。

	2. **Continuous Delivery（持续交付）**：
	- **目的**：确保软件可以随时部署到生产环境中。
	- **过程**：在持续集成的基础上，持续交付增加了将软件部署到测试环境或预生产环境的步骤，确保软件在任何时候都是可部署的状态。
	- **结果**：持续交付提高了部署的频率和速度，减少了部署风险，并允许团队快速响应市场变化。

	3. **Continuous Deployment（持续部署）**：
	- **目的**：自动化地将软件部署到生产环境中。
	- **过程**：在持续交付的基础上，持续部署将软件自动部署到生产环境。
	- **结果**：持续部署可以进一步减少人工干预，提高部署速度和可靠性，并且可以更快地将新功能推向市场。


IAC tool
ansible terraform 什么时候用，什么时候捏一起用

terrafrom state 是啥

key conponents of k8s

pv pvc 

# app deployment is taking too long 怎么优化 怎么调查
看哪个stage 耗时比较长，可能是UT 可能是。。。
	
		### 1. **Analyze Pipeline Stages**
		- **Identify Slow Stages**: Review the pipeline logs to pinpoint which stages (build, test, deploy) are taking the most time.
		- **Check for Bottlenecks**: Look for stages that consistently take longer than expected.

		### 2. **Optimize Build Process**
		- **Use Caching**: Implement caching for dependencies and build artifacts to avoid redundant downloads and builds.
		- **Parallel Builds**: If possible, run jobs in parallel rather than sequentially to reduce overall build time.
		- **Optimize Docker Images**: If using containers, minimize image size by using multi-stage builds and only including necessary files.

		### 3. **Improve Testing Efficiency**
		- **Selective Testing**: Run only relevant tests based on code changes. Use techniques like test impact analysis.
		- **Test Parallelization**: Split tests into smaller chunks that can run simultaneously.
		- **Use Faster Testing Tools**: Evaluate if there are more efficient testing frameworks or tools that could reduce test execution time.

		### 4. **Review Deployment Strategies**
		- **Blue-Green Deployments**: Consider using blue-green deployments or canary releases to minimize downtime and allow for faster rollbacks if issues occur.
		- **Deployment Automation**: Ensure that deployment scripts are optimized and do not contain unnecessary steps.

		### 5. **Monitor Resource Usage**
		- **Check Resource Limits**: Ensure that the CI/CD environment has enough CPU and memory allocated to avoid slowdowns due to resource constraints.
		- **Scaling Resources**: If running in the cloud, consider scaling up the resources temporarily during peak times.

		### 6. **Utilize CI/CD Tools Effectively**
		- **Pipeline as Code**: Use tools like Jenkins, GitLab CI, or GitHub Actions to define your pipeline as code, making it easier to manage and optimize.
		- **Use Built-in Features**: Leverage built-in features of your CI/CD tool for optimization, such as build retries, notifications, and performance insights.

		### 7. **Review Dependencies**
		- **Minimize External Dependencies**: Limit the use of external services or APIs during the pipeline to reduce wait times.
		- **Update Dependencies**: Regularly update libraries and frameworks to their latest versions, which may include performance improvements.

		### 8. **Continuous Feedback and Improvement**
		- **Collect Metrics**: Continuously monitor pipeline performance metrics (execution time, failure rates) to identify trends and areas for improvement.
		- **Team Retrospectives**: Conduct regular reviews with the team to discuss what’s working and what can be improved in the CI/CD process.

# monitor logging 尤其 分布式系统，什么是 monitor logging的最佳实践

		Certainly! Here are some best practices for designing monitoring and alerting for an application:

		### 1. **Define Key Metrics**
		- **Performance Metrics**: Monitor response times, throughput, and error rates.
		- **Infrastructure Metrics**: Track CPU, memory, disk I/O, and network usage.
		- **Business Metrics**: Measure user engagement, transaction volumes, and other relevant KPIs.

		### 2. **Implement Distributed Tracing**
		- Use tools like Jaeger or Zipkin to trace requests across microservices, helping identify performance bottlenecks.

		### 3. **Set Up Logs Collection**
		- Centralize logs using tools like ELK Stack (Elasticsearch, Logstash, Kibana) or Fluentd. Ensure logs are structured for easier searching and analysis.

		### 4. **Establish Baselines**
		- Analyze historical data to establish normal behavior patterns for your metrics. This helps in identifying anomalies.

		### 5. **Configure Alerts Wisely**
		- **Threshold Alerts**: Set alerts based on thresholds for key metrics (e.g., response time > 200ms).
		- **Anomaly Detection**: Use machine learning or statistical methods to detect unusual patterns in metrics.

		### 6. **Use Alert Severity Levels**
		- Classify alerts by severity (e.g., critical, warning, info) to prioritize responses. This helps teams focus on the most impactful issues first.

		### 7. **Ensure Alert Noise Reduction**
		- Avoid alert fatigue by tuning alerts to reduce false positives. Use deduplication and aggregation to minimize noise.

		### 8. **Implement Incident Management**
		- Establish clear procedures for responding to alerts, including escalation paths and post-mortem analyses to learn from incidents.

		### 9. **Dashboard Visualization**
		- Use dashboards (e.g., Grafana, Kibana) to visualize key metrics and trends in real-time, providing a clear overview of system health.

		### 10. **Regularly Review and Adjust**
		- Continuously review monitoring and alerting strategies based on feedback, changing application behavior, and new business needs.

		### 11. **Documentation and Training**
		- Document monitoring configurations and alerting strategies. Train team members on how to respond to alerts effectively.

		### Conclusion
		By following these best practices, you can create a robust monitoring and alerting system that enhances application reliability and performance while minimizing downtime and alert fatigue.