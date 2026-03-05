{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  aiohttp,
  demjson3,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pysyncthru";
  version = "0.8.0";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "nielstron";
    repo = "pysyncthru";
    tag = version;
    hash = "sha256-Zije1WzfgIU9pT0H7T/Mx+5gEBCsRgMLkfsa/KB0YtI=";
  };

  patches = [
    # https://github.com/nielstron/pysyncthru/pull/63
    ./python-3.14-compat.diff
  ];

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    demjson3
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "pysyncthru" ];

  meta = {
    description = "Automated JSON API based communication with Samsung SyncThru Web Service";
    homepage = "https://github.com/nielstron/pysyncthru";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ dotlambda ];
  };
}
