{ nixpkgs ? import <nixpkgs> {}, pythonPkgs ? nixpkgs.pkgs.python312Packages }:
#with import <nixpkgs> {};
with nixpkgs.python312Packages;

buildPythonPackage rec {
  pname = "qrsync";
  version = "0.1.0";
  format = "pyproject";

  #src = /home/ejvend/Sync/Projects/QrSync;

   src = fetchGit {
     url = "git@github.com:PhenixDragyn/QrSync.git";
     ref = "refs/heads/master";
     rev = "21daf41f1c1fd6dfaad1b1b4723d5a6975670b7a";
   };
  
  # src = fetchFromGitHub {
  #   owner = "PhenixDragyn";
  #   repo = "master";
  #   #url = "git@github.com:PhenixDragyn/QrSync.git";
  #   #ref = "refs/heads/master";
  #   rev = "21daf41f1c1fd6dfaad1b1b4723d5a6975670b7a";
  #   sha256 = "";
  # };
  
  propagatedBuildInputs = with pythonPackages; [ 
    pyside6 
    setuptools 
  ];

  checkInputs = with pythonPackages; [ 
    pytest 
  ];

  doCheck = false;
  checkPhase = ''
    pytest
  '';

  #pythonImportsCheck = [ "" ];

   meta = {
     description = ''
       A QT frontend to rsync.
     '';
     #license = [ lib.licenses.gpl2 lib.licenses.gpl3 ];
     maintainers = [ "phenixdragyn" ];
   };
 }


