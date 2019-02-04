require("SitePackage")

local cc_cluster = os.getenv("CC_CLUSTER") or "computecanada"
local arch = os.getenv("RSNT_ARCH") or ""
local interconnect = os.getenv("RSNT_INTERCONNECT") or ""

if not arch or arch == "" then
	if cc_cluster == "cedar" or cc_cluster == "graham" then
		arch = "avx2"
	elseif cc_cluster == "computecanada" then
		arch = get_highest_supported_architecture()
	end
end
if not interconnect or interconnect == "" then
	if cc_cluster == "cedar" then
		interconnect = "omnipath"
	else
		interconnect = get_interconnect()
	end
end
local generic_nixpkgs = true

assert(loadfile("/cvmfs/soft.computecanada.ca/custom/modules/nixpkgs/16.09.lua.core"))(arch, interconnect, generic_nixpkgs)

