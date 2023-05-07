local _args = table.pack(...)

local _cmd = #_args == 0 and "npm run test" or "npm run test-selection"
os.chdir("web")
log_debug(_cmd)
os.execute(string.join(" ", _cmd, ...))
os.chdir("..")