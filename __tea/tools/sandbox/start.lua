local _computed = require("__tea.common.computed")

local _cmd = string.interpolate("${ENGINE} run --rm --name ${NAME} --detach -p ${RPC_PORT}:20000 -e block_time=5" ..
" ${IMAGE} ${SCRIPT} start", _computed.SANDBOX_VARS)
log_debug(_cmd)
ami_assert(os.execute(_cmd), "Failed to start sandbox!")