{ generated, python3Packages, ... }:
python3Packages.buildPythonPackage {
  pname = generated."samloader".pname;
  version = generated."samloader".version;

  src = generated."samloader".src;

  propagatedBuildInputs = with python3Packages;
    [ pycryptodomex requests tqdm ];

  doCheck = false;
}
