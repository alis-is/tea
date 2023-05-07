local _computed = require "__tea.common.computed"

local _cmd = _computed.LIGO_VARS.LIGO .. " compile contract ${FILE} --entry-point ${ENTRYPOINT}" ..
	" --michelson-format ${FORMAT} --output-file ${BUILD_DIR}/${CONTRACT_ID}${SUFFIX} ${PROTOCOL_ARG} ${SYNTAX_ARG}"

if _computed.COMPILE.TZ then
	log_info("Compiling contract to ${ID}.tz...", _computed)
	local _cmd = string.interpolate(_cmd, util.merge_tables(_computed.LIGO_VARS, {
		FORMAT = "text",
		SUFFIX = ".tz"
	}))
	log_debug(_cmd)
	local _ok = os.execute(_cmd)
	ami_assert(_ok, string.interpolate("Failed to compile contract ${ID}.tz", _computed))
end

if _computed.COMPILE.JSON then
	log_info("Compiling contract to ${ID}.json...", _computed)
	local _cmd = string.interpolate(_cmd, util.merge_tables(_computed.LIGO_VARS, {
		FORMAT = "json",
		SUFFIX = ".json"
	}))
	log_debug(_cmd)
	local _ok = os.execute(_cmd)
	ami_assert(_ok, string.interpolate("Failed to compile contract ${ID}.json", _computed))
end
