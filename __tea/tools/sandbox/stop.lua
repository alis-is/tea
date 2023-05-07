local _computed = require("__tea.common.computed")

local _cmd = string.interpolate("${ENGINE} stop ${NAME}", _computed.SANDBOX_VARS)
log_debug(_cmd)
ami_assert(os.execute(_cmd), "Failed to stop sandbox!")