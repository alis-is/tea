local _computed = require "__tea.common.computed"

if type(_computed.CONTAINER_ENGINE) ~= "string" then
	log_warn("Failed to detect container engine! You need one to be able to run sandbox.")
	log_info("HINT: For docker see https://docs.docker.com/compose/gettingstarted/")
	log_info("HINT: For podman see https://podman.io/getting-started/installation")
else
	log_info(_computed.CONTAINER_ENGINE .. " detected.")
end

if _computed.USE_LIGO_CONTAINER then
	log_info("'image' in ligo configuration detected. Static ligo binary won't be downloaded.")
else
	-- download ligo
	local _ligoVersion = am.app.get_configuration({ "ligo", "version" }, "latest")
	log_info("Searching " .. _ligoVersion .. " ligo binary...")
	-- 12294987 ligo project ID
	local _releasesUrl = "https://gitlab.com/api/v4/projects/12294987/releases/" ..
		(_ligoVersion == "latest" and "" or _ligoVersion)
	local _releaseInfo = net.download_string(_releasesUrl)
	if not _releaseInfo then return ami_error("Failed to obtain ligo release info from gitlab.") end
	local _releases = hjson.parse(_releaseInfo)
	local _latest
	if _ligoVersion == "latest" then
		_latest = _releases[1] -- lua indexes from 1 ;)
	else
		_latest = _releases
	end

	local _links = _latest.assets.links
	local _pattern = ("Static Linux binary"):gsub('(%a)', function(v) return '[' .. v:lower() .. v:upper() .. ']' end)
	local _ligoUrl
	for _, link in ipairs(_links) do
		if link.name:match(_pattern) then
			_ligoUrl = link.url
			break
		end
	end
	ami_assert(_ligoUrl,
		"Failed to get static linux binary URL!\nPlease try to specify LIGO_VERSION in configuration section of your app.hjson.")
	local _ligoDestination = "__tea/bin/ligo"
	log_info("Downloading " .. _latest.tag_name .. " ligo binary...")
	net.download_file(_ligoUrl, "__tea/bin/ligo", { showDefaultProgress = 10 })
	fs.chmod(_ligoDestination, 755)
	log_success("ligo binary downloaded")
end
