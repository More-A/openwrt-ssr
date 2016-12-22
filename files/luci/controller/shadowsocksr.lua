--[[
openwrt-dist-luci: ShadowSocksR
]]--

module("luci.controller.shadowsocksr", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocksr") then
		return
	end

	entry({"admin", "services", "shadowsocksr"}, cbi("shadowsocksr"), _("ShadowSocksR"), 74).dependent = true
end
