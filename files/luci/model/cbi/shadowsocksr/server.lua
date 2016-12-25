-- Copyright (C) 2016 yushi studio <ywb94@qq.com>
-- Licensed to the public under the GNU General Public License v3.

local m, s, o
local shadowsocksr = "shadowsocksr"
local uci = luci.model.uci.cursor()
local ipkg = require("luci.model.ipkg")

if luci.sys.call("pidof ssr-redir >/dev/null") == 0 then
	m = Map(shadowsocksr, translate("ShadowSocksR Server"), translate("ShadowSocksR Server is running"))
else
	m = Map(shadowsocksr, translate("ShadowSocksR Server"), translate("ShadowSocksR Server is not running"))
end


local encrypt_methods = {
	"table",
	"rc4",
	"rc4-md5",
	"rc4-md5-6",
	"aes-128-cfb",
	"aes-192-cfb",
	"aes-256-cfb",
	"aes-128-ctr",
	"aes-192-ctr",
	"aes-256-ctr",	
	"bf-cfb",
	"camellia-128-cfb",
	"camellia-192-cfb",
	"camellia-256-cfb",
	"cast5-cfb",
	"des-cfb",
	"idea-cfb",
	"rc2-cfb",
	"seed-cfb",
	"salsa20",
	"chacha20",
	"chacha20-ietf",
}

local protocol = {
	"origin",
	"verify_simple",
	"verify_sha1",		
}

obfs = {
	"plain",
	"http_simple",
	"http_post",
	"tls1.2_ticket_auth",
}





-- [[ Global Setting ]]--
s = m:section(TypedSection, "server_global", translate("Global Setting"))
s.anonymous = true



o = s:option(Flag, "enable_server", translate("Enable Server"))
o.rmempty = false

-- [[ Server Setting ]]--
s = m:section(TypedSection, "server_config", translate("Server Setting"))
s.anonymous = true

o = s:option(Value, "server", translate("Server Address"))
o.datatype = "ipaddr"
o.default = "0.0.0.0"
o.rmempty = false

o = s:option(Value, "server_port", translate("Server Port"))
o.datatype = "port"
o.default = 8388
o.rmempty = false

o = s:option(Value, "timeout", translate("Connection Timeout"))
o.datatype = "uinteger"
o.default = 60
o.rmempty = false

o = s:option(Value, "password", translate("Password"))
o.password = true
o.rmempty = false

o = s:option(ListValue, "encrypt_method", translate("Encrypt Method"))
for _, v in ipairs(encrypt_methods) do o:value(v) end
o.rmempty = false

o = s:option(ListValue, "protocol", translate("protocol"))
for _, v in ipairs(protocol) do o:value(v) end
o.rmempty = false


o = s:option(ListValue, "obfs", translate("obfs"))
for _, v in ipairs(obfs) do o:value(v) end
o.rmempty = false

o = s:option(Value, "obfs_param", translate("obfs_param(optional)"))


return m
