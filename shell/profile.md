# linux 环境变量

/etc/profile 中会 for each /etc/profile.d下面的文件，如果要持久化环境变量，我们就在/etc/profile.d下边建立一个.sh文件，把环境变量放进去,放在 /etc/profile 系统更新会被冲掉

```shell
/etc/profile
$HOME/.bash_profile
$HOME/.bashrc
$HOME/.bash_login
$HOME/.profile
```
ubuntu中 /etc/bash.bashrc 包含系统环境变量