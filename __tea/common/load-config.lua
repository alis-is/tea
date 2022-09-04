log_success, log_info = util.global_log_factory("eli", "success", "info")

local _configuration = require"hjson".parse(fs.read_file("src/config.hjson"))
for k, v in pairs(_configuration) do
	_G[k] = v
end

local _offChainViews = require"hjson".parse(fs.read_file("src/offchain-views.hjson"))
local _contractMetadata = require"hjson".parse(fs.read_file("src/metadata.hjson"))

_G.configuration = _configuration
_G.CONTRACT_METADATA = _contractMetadata
_G.OFFCHAIN_VIEWS = _offChainViews

return {
	configuration = _configuration,
	offchainViews = _offChainViews,
	contractMetadata = _contractMetadata
}