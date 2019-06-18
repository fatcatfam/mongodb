$pkg_name="mongodb"
$pkg_origin="winhab"
$pkg_version="4.0.10"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_description="High-performance, schema-free, document-oriented database"
$pkg_license=@('AGPL-3.0')
$pkg_source="https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-$pkg_version.zip"
$pkg_shasum="86f31206d2f9bf097524626a26b764e632b382456f4bacff7c4ef41717184ffa"
$pkg_upstream_url='https://www.mongodb.com/'
$pkg_bin_dirs=@('bin')
$pkg_svc_run="mongod --config ${pkg_svc_config_path}\mongod.cfg"
$pkg_exports=@{port="mongod.net.port"}
$pkg_exposes=@('port')

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/mongodb-*/bin/*" "$pkg_prefix\bin" -verbose
  mkdir "$pkg_prefix\data\db"
  mkdir "$pkg_prefix\log"
}

function Invoke-Check {
  & "$HAB_CACHE_SRC_PATH\$pkg_dirname\mongodb-win32-*\bin\mongod" --version
  if($LASTEXITCODE -ne 0) { Write-Error "Invoke check failed with error code $LASTEXITCODE" }
}
