ShadowsocksR-libev for OpenWrt
===


简介
---

 本项目是 [shadowsocksr-libev][1] 在 OpenWrt 上的移植  
 
 [ar71xx平台预编译IPK下载][4]

特性
---

软件包包含 [shadowsocksr-libev][1] 的可执行文件,以及luci控制界面  

支持自动分流，国内IP不走代理，国外IP段走透明代理，不需要再安装chnroute、gfwlist等软件

支持本地域名污染情况下的远程服务器解析，多数情况下无需对dns进行处理

可以和[Shadowsocks][5]共存，在openwrt可以通过luci界面切换使用[Shadowsocks][6]或ShadowsocksR

兼容SS和SSR服务端，使用SS服务端时，传输协议需设置为origin，混淆插件需设置为plain


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
本软件包依赖库：libopenssl、libpthread、ipset、ip、iptables-mod-tproxy、libpcre，opkg会自动安装

先将编译成功的luci-app-shadowsocksR_*_all.ipk通过winscp上传到路由器的/tmp目录，执行命令：

   ```
   #opkg update
   #opkg install /tmp/luci-app-shadowsocksR_*_all.ipk 
   ```

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
   protocol       | 字符串     | 传输协议，默认"origin"[详情参考][3]
   obfs           | 字符串     | 混淆插件，默认"plain" [详情参考][3]
   obfs_param     | 字符串     | 混淆插件参数 [详情参考][3]
   

   
   安装启用后自动分流国内、外流量，如需更新国内IP数据库在openwrt上执行如下命令即可：
   ```
   #wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/china_ssr.txt
         
   ```

截图  
---

![luci000](http://iytc.net/img/ssr.jpg)


  [1]: https://github.com/breakwa11/shadowsocks-libev
  [2]: https://github.com/shadowsocks/luci-app-shadowsocks/wiki/Encrypt-method
  [3]: https://github.com/breakwa11/shadowsocks-rss/wiki/config.json
  [4]: http://iytc.net/tools/luci-app-shadowsocksR_last_all.ipk " Chaos Calmer 15.05预编译 IPK 下载" 
  [5]: https://github.com/shadowsocks/openwrt-shadowsocks
  [6]: https://github.com/shadowsocks/luci-app-shadowsocks  
  [S]: https://wiki.openwrt.org/doc/howto/obtain.firmware.sdk
