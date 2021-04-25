# CHAP0x03 开机自启动项管理
## 1. 实验目的
### (1) 熟悉配置使用asciinema
### (2) 动手实战Systemd，开机自启动项管理
## 2. 实验过程
### (1) Systemd 入门教程：命令篇
- 三、系统管理：https://asciinema.org/a/404096
- 四、Unit：https://asciinema.org/a/404101
- 五、Unit 的配置文件：https://asciinema.org/a/404116
- 六、Target：https://asciinema.org/a/404118
- 七、日志管理：https://asciinema.org/a/404120
### (2) Systemd 入门教程：实战篇
- 实战篇：https://asciinema.org/a/404125

## 3. 问题回答
- **如何添加一个用户并使其具备sudo执行程序的权限？**
    `adduser [username] [username] ALL=(ALL) ALL`
- **如何将一个用户添加到一个用户组？**
    `usermod [-G] [GroupName] [UserName]`
- **如何查看当前系统的分区表和文件系统详细信息？**
    查看分区表:`sudo fdisk -l `
    文件系统详细信息:`df -h `
- **如何实现开机自动挂载Virtualbox的共享目录分区？**
    在文件 `/etc/rc.local` 中（用root用户）追加如下命令
    `mount -t vboxsf java /mnt/share`
- **基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？**
    扩容：`lvextend -L +<容量> <目录>`
    减容：`lvreduce -L -<容量> <目录>`  
- **如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？**
    `ExecStartPost=<路径1> post1`
    `ExecStopPost=<路径2> post2`
    `sudo systemctl daemon-reload`
    `sudo systemctl restart httpd.service`
- **如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？**
    ` Restart=always`
    `sudo systemctl daemon-reload`
## 4. 实验遇到的问题及解决
- 配置免密登录：执行**ssh-keygen.exe -b 4096**报错：**ssh-keygen.exe: command not found**
`没有搞清楚是在 ssh 之后的虚拟机 shell 里操作还是 git bash shell 里操作。应该在git bash shell里执行ssh-keygen.exe。`
## 5. 参考资料
- [Systemd 入门教程：命令篇 by 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd 入门教程：实战篇 by 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)
- [Linux fdisk命令操作磁盘(添加、删除、转换分区等)](https://blog.csdn.net/dat1842/article/details/102319620)
- [VirtualBox 共享文件夹设置 及 开机自动挂载](https://blog.csdn.net/ysh198554/article/details/73335844)
- [LVM逻辑卷管理--在线扩容、逻辑卷与卷组容量缩减、逻辑卷快照](https://blog.csdn.net/weixin_33923148/article/details/92724727)