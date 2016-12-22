ShadowsocksR-libev for OpenWrt
===


简介
---

 本项目是 [shadowsocksr-libev][1] 在 OpenWrt 上的移植  
 
 [预编译IPK下载][4]

特性
---

软件包包含 [shadowsocksr-libev][1] 的可执行文件,以及luci控制界面  


编译
---

 - 从 OpenWrt 的 [SDK][S] 编译

   ```bash
   # 以 ar71xx 平台为例
   tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
   cd OpenWrt-SDK-ar71xx-*
   # 安装 feeds
   ./scripts/feeds update packages
   ./scripts/feeds install libpcre
   # 获取 Makefile
   git clone https://github.com/ywb94/openwrt-ssr.git package/openwrt-ssr
   # 选择要编译的包 luci ->3. Applications-> luci-app-shadowsocksR
   make menuconfig
   
   #如果没有安装po2lmo，则安装（可选）
   pushd package/openwrt-ssr/tools/po2lmo
   make && sudo make install
   popd
   #编译语言文件（可选）
   po2lmo ./package/openwrt-ssr/files/luci/i18n/shadowsocksr.zh-cn.po ./package/openwrt-ssr/files/luci/i18n/shadowsocksr.zh-cn.lmo
   
   # 开始编译
   make V=99
   ```
   
安装
--- 
本软件包依赖库：libopenssl、libpthread、ipset、ip、iptables-mod-tproxy、libpcre，opkg会自动安装，需先update软件包列表
先将luci-app-shadowsocksR_*_all.ipk通过winscp上传到路由器的/tmp目录
#opkg update
#opkg install /tmp/luci-app-shadowsocksR_*_all.ipk 

配置
---

   软件包可以通过luci配置，也可以通过配置文件, 配置文件内容为 JSON 格式, 支持的键:  

   键名           | 数据类型   | 说明
   ---------------|------------|-----------------------------------------------
   server         | 字符串     | 服务器地址, 可以是 IP 或者域名
   server_port    | 数值       | 服务器端口号, 小于 65535
   local_port     | 数值       | 本地绑定的端口号, 小于 65535
   password       | 字符串     | 服务端设置的密码
   method         | 字符串     | 加密方式, [详情参考][2]
   timeout        | 数值       | 超时时间（秒）, 默认 60
   protocol       | 字符串     | 协议插件，默认"origin"[详情参考][3]
   obfs           | 字符串     | 混淆插件 [详情参考][3]
   obfs_param     | 字符串     | 混淆插件参数 [详情参考][3]

截图  
---

![luci000](https://iytc.net/img/ssr.jpg)


  [1]: https://github.com/breakwa11/shadowsocks-libev
  [2]: https://github.com/shadowsocks/luci-app-shadowsocks/wiki/Encrypt-method
  [3]: https://github.com/breakwa11/shadowsocks-rss/wiki/config.json
  [4]: http://iytc.net/tools/luci-app-shadowsocksR_1.0-1_all.ipk "预编译 IPK 下载"  
  [S]: https://wiki.openwrt.org/doc/howto/obtain.firmware.sdk
