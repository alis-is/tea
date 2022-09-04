local _args = table.pack(...)
local _deployArgs = {}
local _force = false
for _, v in ipairs(_args) do
	if v == "--force" then
		_force = true
		goto CONTINUE
	end
	table.insert(_deployArgs, v)
	::CONTINUE::
end

local _computed = require("__tea.common.computed")

local _deploys = am.app.get_configuration("deploys", {})
ami_assert(type(_deploys) == "table" and #table.keys(_deploys) > 0, "No deploys found")

local _matched = false
for _, id in ipairs(_deployArgs) do
	local _deployConfig = _deploys[id]
	if _deployConfig == nil then
		log_warn("Deploy ${ID} not found!", { ID = id })
		goto CONTINUE
	end
	_matched = true
	local _ok, _deployer = pcall(require, "__tea.tools.deploy.plugin." .. _deployConfig.kind)
	if not _ok then
		log_warn("Failed to load deployer - ${DEPLOYER} - for deployment '${ID}'!", { ID = id, DEPLOYER = _deployConfig.kind })
		goto CONTINUE
	end
	if type(_deployer) ~= "function" then
		log_warn("Invalid deployer - ${DEPLOYER} (expected function, got: ${TYPE}) - of deployment '${ID}'!",
			{ ID = id, DEPLOYER = _deployConfig.kind, TYPE = type(_deployer) })
		goto CONTINUE
	end
	log_info("Deploying ${ID} with ${DEPLOYER}", { ID = id, DEPLOYER = _deployConfig.kind })
	local _ok, _err = pcall(_deployer, util.merge_tables(_deployConfig, {
		DEPLOYMENT_ID = id,
		ID = _computed.ID,
		FORCE = _force
	}, true))
	ami_assert(_ok, "Failed to deploy - " .. id .. "! (" .. tostring(_err) .. ")")
	log_success("${ID} deployed.", { ID = id })
	::CONTINUE::
end
if not _matched then
	log_warn("No deploys matched!")
end
