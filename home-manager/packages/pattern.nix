{ python3Packages, fetchgit, fetchurl, unzip, mariadb, ... }:
python3Packages.buildPythonPackage rec {
  pname = "pattern";
  version = "3.7-beta";

  src = fetchgit {
    url = "https://github.com/clips/pattern";
    rev = "refs/tags/${version}";
    hash = "sha256-MkRVNu0E+cvp03sC6V3kgSNGoTWblncd7UtRStbMES0=";
  };

  propagatedBuildInputs = with python3Packages;
    ([ feedparser beautifulsoup4 nltk cherrypy ]
      ++ [ future requests scipy backports_csv python-docx ]
      ++ [ mysqlclient pdfminer ]);

  checkInputs = [
    python3Packages.pytestCheckHook
  ];

  patchPhase = ''
    sed -i 's/1285020000/1285027200/g' test/test_db.py
    sed -i 's/mariadb/127.0.0.1/g' test/test_db.py
  '';

  pytestFlagsArray = [
    # https://github.com/clips/pattern/blob/3.7-beta/test/test_web.py
    "--ignore=test/test_web.py"
  ];

  wordnet = fetchurl {
    url = "https://raw.githubusercontent.com/nltk/nltk_data" +
      "/gh-pages/packages/corpora/wordnet.zip";
    hash = "sha256-y9pepu7382qXpD1KdfheB/zLtPI2V9J7TMvJPiZGq1k=";
  };

  wordnet_ic = fetchurl {
    url = "https://raw.githubusercontent.com/nltk/nltk_data" +
      "/gh-pages/packages/corpora/wordnet_ic.zip";
    hash = "sha256-qTGzS7kBOsPBKR9kyBL9A5gCmVorEka491JegggBEOM=";
  };

  sentiwordnet = fetchurl {
    url = "https://raw.githubusercontent.com/nltk/nltk_data" +
      "/gh-pages/packages/corpora/sentiwordnet.zip";
    hash = "sha256-tmh2oXqutMfHyNL1uyz5H94W4bduJCHlSA/t0XrSSME=";
  };

  omw-1_4 = fetchurl {
    url = "https://raw.githubusercontent.com/nltk/nltk_data" +
      "/gh-pages/packages/corpora/omw-1.4.zip";
    hash = "sha256-O5QeZkhS8yl7YEAjZiYGV5aiqvfX+e7Id5o76qEJbC0=";
  };

  preCheck = ''
    export HOME=/tmp/homeless-shelter
    mkdir -p $HOME/nltk_data/corpora

    ${unzip}/bin/unzip ${wordnet} -d $_
    ${unzip}/bin/unzip ${wordnet_ic} -d $_
    ${unzip}/bin/unzip ${sentiwordnet} -d $_
    ${unzip}/bin/unzip ${omw-1_4} -d $_
  '' + ''
    mkdir -p $NIX_BUILD_TOP/mariadb \
      && export DATADIR=$_

    mkdir -p $NIX_BUILD_TOP/run/mariadb \
      && export SOCKET=$_/mariadbd.sock

    ${mariadb}/bin/mariadb-install-db \
      --datadir=$DATADIR

    ${mariadb}/bin/mariadbd \
      --datadir=$DATADIR \
      --socket=$SOCKET \
      --skip-grant-tables &
  '';
}
