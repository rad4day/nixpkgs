{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools-scm,
  python-vagrant,
  docker,
}:

buildPythonPackage rec {
  pname = "molecule-plugins";
  version = "25.8.12";
  format = "pyproject";

  src = fetchPypi {
    inherit version;
    pname = "molecule_plugins";
    hash = "sha256-dfMnY+kCdb/CS8wNJ7m7IqyXNli/kCsuPor44qHDIIM=";
  };

  # reverse the dependency
  pythonRemoveDeps = [ "molecule" ];

  nativeBuildInputs = [
    setuptools-scm
  ];

  optional-dependencies = {
    docker = [ docker ];
    vagrant = [ python-vagrant ];
  };

  pythonImportsCheck = [ "molecule_plugins" ];

  # Tests require container runtimes
  doCheck = false;

  meta = with lib; {
    description = "Collection on molecule plugins";
    homepage = "https://github.com/ansible-community/molecule-plugins";
    maintainers = [ ];
    license = licenses.mit;
  };
}
