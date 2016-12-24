-- Copyright (C) 2016 yushi studio <ywb94@qq.com>
-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.shadowsocksr", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocksr") then
		return
	end

         if nixio.fs.access("/usr/bin/ssr-redir") 
         then
         entry({"admin", "services", "shadowsocksr"},alias("admin", "services", "shadowsocksr", "client"),_("ShadowSocksR"), 10).dependent = true
         entry({"admin", "services", "shadowsocksr", "client"},cbi("shadowsocksr/client"),_("Client"), 10).leaf = true
         elseif nixio.fs.access("/usr/bin/ssr-server") 
         then 
         entry({"admin", "services", "shadowsocksr"},alias("admin", "services", "shadowsocksr", "server"),_("ShadowSocksR"), 10).dependent = true
         else
          return
         end  
	

	if not nixio.fs.access("/usr/bin/ssr-server") then
		return
	end
		
	entry({"admin", "services", "shadowsocksr", "server"},cbi("shadowsocksr/server"),_("SSR Server"), 20).leaf = true
	
	
end