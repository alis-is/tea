local _metaStore = "__tea/.ami-definitions/"
local _eliMetaZip = _metaStore .. "eli/meta.zip"
local _amiMetaZip = _metaStore .. "ami/meta.zip"

log_info("Downloading metas...")
net.download_file("https://github.com/alis-is/eli/releases/latest/download/meta.zip", _eliMetaZip,
	{ followRedirects = true })
net.download_file("https://github.com/alis-is/ami/releases/latest/download/meta.zip", _amiMetaZip,
	{ followRedirects = true })

log_info("Extracting metas...")
zip.extract(_eliMetaZip, _metaStore .. "eli", { flattenRootDir = true })
zip.extract(_amiMetaZip, _metaStore .. "ami", { flattenRootDir = true })

log_success("eli & ami definitions downloaded")
