local _computed = require "__tea.common.computed"

local _cmd = _computed.LIGO_VARS.LIGO .. " run test ${ROOT}"
log_debug(_cmd)
os.execute(string.interpolate(_cmd, _computed.TEST_VARS))
-- ligo reports failure on its own