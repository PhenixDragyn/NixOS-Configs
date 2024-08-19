# Below, we can supply defaults for the function arguments to make the script
# runnable with `nix-build` without having to supply arguments manually.
# Also, this lets me build with Python 3.7 by default, but makes it easy
# to change the python version for customised builds (e.g. testing).
{ nixpkgs ? import <nixpkgs> {}, pythonPkgs ? nixpkgs.pkgs.python312Packages }:

let
  # This takes all Nix packages into this scope
  inherit (nixpkgs) pkgs;
  # This takes all Python packages from the selected version into this scope.
  inherit pythonPkgs;

  # Inject dependencies into the build function
  f = { buildPythonApplication, pyside6, setuptools, pytest, rsync }:
    buildPythonApplication rec {
      pname = "qrsync";
      version = "0.1.0";
      format = "pyproject";

      # If you have your sources locally, you can specify a path
      src = /home/ejvend/Sync/Projects/QrSync;

      # Pull source from a Git server. Optionally select a specific `ref` (e.g. branch),
      # or `rev` revision hash.
      #src = builtins.fetchGit {
      #  url = "https://github.com/PhenixDragyn/QrSync.git";
        #url = "git+ssh://git@github.com:PhenixDragyn/QrSync.git";
      #  ref = "master";
        #rev = "0.1.0";
        #rev = "a9a4cd60e609ed3471b4b8fac8958d009053260d";
        #sha256 = "ef51e7b4c43c3168a997b9f4c531fc2b4f1524292d36469c17692355f8ec15ef";
      #};

      # Specify runtime dependencies for the package
      propagatedBuildInputs = [ pyside6 setuptools rsync ];

      # If no `checkPhase` is specified, `python setup.py test` is executed
      # by default as long as `doCheck` is true (the default).
      # I want to run my tests in a different way:

      #doCheck = false;
      nativeCheckInputs = [ pytest ];
      checkPhace = ''
        runHook preCheck
        pytest
        runHook postCheck
      '';
      #checkPhase = ''
      #  python -m unittest tests/*.py
      #'';
      
      #pythonImportsCheck = [ "pyside6" ];

      # Meta information for the package
      #meta = with lib; {
      meta = {
        description = ''
          A QT frontend to rsync.
        '';
        #license = [ lib.licenses.gpl2 lib.licenses.gpl3 ];
        maintainers = [ "phenixdragyn" ];
      };
    };

  drv = pythonPkgs.callPackage f {};
in
  if pkgs.lib.inNixShell then drv.env else drv

