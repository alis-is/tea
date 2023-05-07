local _cmd = "node __tea/tools/originate.mjs"

return function(options)
	local _cwd = os.cwd()
	os.chdir("web")
	env.set_env("DEPLOYMENT_ID", options.DEPLOYMENT_ID)
	env.set_env("ID", options.ID)
	env.set_env("CREATOR_KEY", options.source)
	env.set_env("RPC", options.rpc)
	log_debug(_cmd)
	local _ok, _, _exitcode = os.execute(_cmd)
	os.chdir(_cwd)
	ami_assert(_ok, "Failed to deploy contract with taquito!")
end
