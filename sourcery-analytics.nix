{ pkgs ? import <nixpkgs> { } }:
let
  pypkgs = pkgs.python310Packages;

  lazy-object-proxy = pypkgs.buildPythonPackage rec {
    pname = "lazy-object-proxy";
    version = "1.4.0";

    src = pypkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-f7EdM9maN05LDD+yASiJC5z3hMp+S5HsuxkdNGGL2f4=";
    };

    propagatedBuildInputs = [ pypkgs.setuptools ];
  };

  pydantic = pypkgs.buildPythonPackage rec {
    pname = "pydantic";
    version = "1.9.1";

    src = pypkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-HtmHw/8p//f9jD6jo+qHetMQquLvmImhGeItPy2waRo=";
    };

    doCheck = false;
    propagatedBuildInputs = [ pypkgs.typing-extensions ];
  };

  astroid = pypkgs.buildPythonPackage rec {
    pname = "astroid";
    version = "2.11.6";
    format = "wheel";

    src = pypkgs.fetchPypi {
      inherit pname version format;
      sha256 = "sha256-ujOoKpqcBqXO7ZgYDFqrFuKcKFuCjZRpa/MtYBXqgqk=";
      python = "py3";
      dist = "py3";
      platform = "any";
    };

    doCheck = false;
    propagatedBuildInputs = [
      lazy-object-proxy
      pydantic
      pypkgs.typing-extensions
      pypkgs.wrapt
    ];
  };

  typer = pypkgs.buildPythonPackage rec {
    pname = "typer";
    version = "0.6.1";
    format = "wheel";

    src = pypkgs.fetchPypi {
      inherit pname version format;

      python = "py3";
      dist = "py3";
      platform = "any";
      sha256 = "sha256-VLGeXfGGVAcKgvjCqh2kVqSsFqKoPm3NnxcOKRxWM44=";
    };

    propagatedBuildInputs = [ pypkgs.click ];
  };

  rich = pypkgs.buildPythonPackage rec {
    pname = "rich";
    version = "12.5.1";

    src = pypkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-Y6XFzjZz09X7vyPNh+EauEtrRRQ28bfxnsVLa8Nu18o=";
    };

    doCheck = false;
    propagatedBuildInputs = [ pypkgs.commonmark pypkgs.pygments ];
  };

  more-itertools = pypkgs.buildPythonPackage rec {
    pname = "more_itertools";
    version = "8.13.0";
    format = "wheel";

    src = pypkgs.fetchPypi {
      inherit pname version format;

      python = "py3";
      dist = "py3";
      platform = "any";
      sha256 = "sha256-xRIr/8XxBNN8Fia4YVtRHzQnqlOJuU1h5e+CNr+8Pds=";
    };

    doCheck = false;
  };

  sourcery-analytics = pypkgs.buildPythonPackage rec {
    pname = "sourcery-analytics";
    version = "1.2.0";

    src = pypkgs.fetchPypi {
      inherit pname version;

      sha256 = "sha256-xiEZ482rP+EBfKlOLyj2a4sEPd9c4QSXJlWTAHLvv4A=";
    };

    doCheck = false;
    propagatedBuildInputs = [
      astroid
      typer
      rich
      pypkgs.tomli
      more-itertools
    ];
  };

  deps = _: [ sourcery-analytics ];
in
(pkgs.python310.withPackages deps)
