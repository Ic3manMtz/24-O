Install latex

1. cd /tmp # working directory of your choice
2. wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
3. zcat < install-tl-unx.tar.gz | tar xf - # note final - on that command line
4. cd install-tl-*
5. sudo perl ./install-tl --no-interaction
6. export PATH="/usr/local/texlive/2024/bin/x86_64-linux/:$PATH"

sudo apt update
sudo apt install texlive-full
tlmgr update --self --all

sudo apt update
sudo apt install octave