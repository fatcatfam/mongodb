$pkg_name="mongodb"
$pkg_origin="winhab"
$pkg_version="4.0.10"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_description="High-performance, schema-free, document-oriented database"
$pkg_license=@('AGPL-3.0')
$pkg_source="https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-4.0.10-signed.msi"
$pkg_shasum="d1ddac7ba6e2fbdfaaa0a787b83c165d4ad61795c051dc0f3142717a0b6a3707"
$pkg_upstream_url='https://www.mongodb.com/'
$pkg_deps=@("core/lessmsi")
$pkg_bin_dirs=@('MongoDB\Server\4.0\bin')
$pkg_exports=@{port="mongod.net.port"}
$pkg_exposes=@('port')

function Invoke-Unpack {
  mkdir "$HAB_CACHE_SRC_PATH\$pkg_dirname"
  Push-Location "$HAB_CACHE_SRC_PATH\$pkg_dirname"
  try {
    lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH\$pkg_filename").Path
  }
  finally { Pop-Location }
}

function Invoke-Install {
Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\mongodb-*\SourceDir\*" "$pkg_prefix" -Recurse -Force -verbose
# Set-Alias mongod "$pkg_prefix\MongoDB\Server\4.0\bin\mongod.exe"
# Set-Alias mongo "$pkg_prefix\MongoDB\Server\4.0\bin\mongo.exe"
mongod --version
}

function Invoke-Check {
  & "$HAB_CACHE_SRC_PATH\$pkg_dirname\mongodb-win32-*\MongoDB\Server\4.0\bin/mongod" --version
  if($LASTEXITCODE -ne 0) { Write-Error "Invoke check failed with error code $LASTEXITCODE" }
}
