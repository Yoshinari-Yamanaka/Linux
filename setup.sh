#!/bin/bash
readonly Docker_would_be_installed=true 2> /dev/null
readonly Python_would_be_installed=true 2> /dev/null
readonly NodeJS_would_be_installed=true 2> /dev/null
readonly Java_would_be_installed=true 2> /dev/null
readonly Golang_would_be_installed=true 2> /dev/null
readonly Swift_would_be_installed=true 2> /dev/null
readonly AWS_SDK_FOR_CPP_would_be_installed=false 2> /dev/null
readonly PostgreSQL_would_be_installed=true 2> /dev/null
readonly GoogleChrome_would_be_installed=false 2> /dev/null

function check_status ()
{
    if [ $1 -ne 0 ] ; then
        touch ~/failure.txt
        echo "${FUNCNAME[0]} function called" >> ~/failure.txt
        echo "Called from line : ${BASH_LINENO[0]}" >> ~/failure.txt
        echo final status : $1 >> ~/failure.txt
        exit
    fi
}

#######################################################
# build-essential
#######################################################
cd ~
sudo apt update -y && sudo apt install build-essential -y
check_status $?

#######################################################
# OpenSSL
#######################################################
sudo curl https://www.openssl.org/source/openssl-1.1.1.tar.gz -o /usr/local/src/openssl-1.1.1.tar.gz
cd /usr/local/src
sudo tar xvzf openssl-1.1.1.tar.gz
cd openssl-1.1.1/
sudo ./config --prefix=/usr/local/openssl-1.1.1 shared zlib
sudo make depend
sudo make
sudo make test
sudo make install
check_status $?

sudo echo "/usr/local/openssl-1.1.1/lib" > /etc/ld.so.conf.d/openssl-1.1.1.conf
sudo ldconfig
sudo ldconfig -p | grep libssl

#######################################################
# cmake
#######################################################
apt install -y cmake cmake-curses-gui jq tree nfs-common unzip zsh

#######################################################
# git-secrets
#######################################################
cd ~
git clone https://github.com/awslabs/git-secrets.git && cd git-secrets && make install
check_status $?

#######################################################
# Docker
#######################################################
if "${Docker_would_be_installed}" ; then
    cd ~
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
    check_status $?
    echo "service docker start" >> ~/.bashrc && source ~/.bashrc
fi

#######################################################
#  AWS SDK for C++
#######################################################
if "${AWS_SDK_FOR_CPP_would_be_installed}"; then
    cd ~
    apt install -y libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev libpulse-dev cmake

    #aws-c-common
    cd ~
    git clone https://github.com/awslabs/aws-c-common
    cd aws-c-common && mkdir build && cd build
    cmake -DCMAKE_PREFIX_PATH=/usr/local/lib/cmake -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cmake ../
    make && make install

    #aws-checksums
    cd ~
    git clone https://github.com/awslabs/aws-checksums
    cd aws-checksums && mkdir build && cd build
    cmake -DCMAKE_PREFIX_PATH=/usr/local/lib/cmake -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cmake ../
    make && make install

    #aws-c-event-stream
    cd ~
    git clone https://github.com/awslabs/aws-c-event-stream
    cd aws-c-event-stream && mkdir build && cd build
    cmake -DCMAKE_PREFIX_PATH=/usr/local/lib/cmake -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cmake ../
    make && make install

    #aws-sdk-cpp
    cd ~
    git clone https://github.com/aws/aws-sdk-cpp
    cd aws-sdk-cpp && mkdir build && cd build
    cmake -DCMAKE_PREFIX_PATH=/usr/local/lib/cmake -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cmake -DBUILD_ONLY="s3" ../
    make && make install

    check_status $?
    echo "export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:~/aws_sdk_for_cpp" >> ~/.bashrc
fi

#######################################################
# Python3.8.3
#######################################################
if "${Python_would_be_installed}" ; then
    cd ~
    #install "dependencies"
    apt install -y libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev uuid-dev libffi-dev libdb-dev
    #install "Python3.8.3" from "python.org"
    wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tar.xz && tar -xf Python-3.8.3.tar.xz && cd Python-3.8.3 && \
    ./configure --enable-optimizations && make -s -j4 && make altinstall
    check_status $?
    #set "python" Symbolic link
    tmp="$(which python3.8)"
    ln -s ${tmp} "${tmp%/*}/python"
    python --version
    check_status $?
    #enable "venv"
    cd ~
    python -m venv env && \
    echo "source ~/env/bin/activate" >> ~/.bashrc && source ~/.bashrc && \
    ln -s "${tmp%/*}/python" ~/env/bin/python
    python --version
    check_status $?
    #install pip
    cd ~
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.pyy
    pip --version
    check_status $?
    pip install --upgrade pip
    #install Python libraries
    apt install libpq-dev -y
    pip install awscli beautifulsoup4 boto3 coverage django flask flask-cors gunicorn gspread \ 
        numpy openpyxl pandas requests pipdeptree psycopg2 pyarrow pycrypto pyorc pyspark \
        pytest python-dotenv selenium scikit-learn scipy uWSGI xlrd xlwt
fi

#######################################################
# Node.js
#######################################################
if "${NodeJS_would_be_installed}" ; then
    cd ~
    apt install nodejs npm -y && \
    npm install n -g && n stable && \
    apt purge nodejs npm -y && apt autoremove -y
    check_status $?
    npm install -g aws-sdk aws-cdk express express-generator npm-add-dependencies \
        pg typescript @vue/cli @aws-amplify/cli node-fetch
    check_status $?
    echo "export NODE_PATH=$(npm root -g)" >> ~/.bashrc && source ~/.bashrc
fi

#######################################################
# Go lang
#######################################################
if "${Golang_would_be_installed}" ; then
    cd ~
    wget https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz
    echo 'export PATH=${PATH}:/usr/local/go/bin' >> ~/.bashrc
    check_status $?
fi

#######################################################
# Swift
#######################################################

if "${Swift_would_be_installed}" ; then
    cd ~
    sudo apt install clang libicu-dev libcurl4-openssl-dev libssl-dev -y
    wget https://swift.org/builds/swift-5.2.5-release/ubuntu2004/swift-5.2.5-RELEASE/swift-5.2.5-RELEASE-ubuntu20.04.tar.gz
    tar xzvf swift-5.2.5-RELEASE-ubuntu20.04.tar.gz
    mv swift-5.2.5-RELEASE-ubuntu20.04.tar.gz /usr/local/bin/swift
    echo "export PATH=${PATH}:/usr/local/bin/swift/usr/bin/swift" >> ~/.bashrc
fi

#######################################################
# Open JDK
#######################################################
if "${Java_would_be_installed}" ; then
    cd ~
    apt search openjdk-\(\.\)\+-jdk$
    apt install openjdk-11-jdk -y && \
    java --version && javac --version
    check_status $?
fi

#######################################################
#  PostgreSQL
#######################################################
if "${PostgreSQL_would_be_installed}"; then
    cd ~
    #To avoid following Error, reinstall "GPG"
    #gpg: can't connect to the agent: IPC connect call failed
    #Import the repository key from the following website
    apt purge -y gpg && apt install -y ca-certificates gnupg1 && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    check_status $?
    #You may determine the codename of your distribution by running lsb_release -c
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    check_status $?
    #install "PostgreSQL 12"
    apt update -y 
    apt install -y postgresql-12 pgadmin4
    check_status $?
    echo "service postgresql start" >> ~/.bashrc && source ~/.bashrc
fi

#######################################################
# ssl-scan
#######################################################
cd ~
git clone https://github.com/rbsec/sslscan.git && cd sslscan && make static
check_status $?
echo "alias sslscan=~/sslscan/sslscan" >> ~/.bashrc && source ~/.bashrc
cd ~

#######################################################
# Google Chrome
#######################################################
if "${GoogleChrome_would_be_installed}" ; then
    cd ~
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo apt update -y
    sudo apt-get install google-chrome-stable -y
    check_status $?

    cd ~
    google_chrome_version=$(google-chrome --version | tr -d 'Google Chrome ')
    echo ${google_chrome_version}
    chromedriver_version=${google_chrome_version%.*}.xx
    # curl -O https://chromedriver.storage.googleapis.com/${chromedriver_version}/chromedriver_linux64.zip
    # unzip chromedriver_linux64.zip
    # sudo mv chromedriver /usr/local/bin/
    # rm chromedriver_linux64.zip
fi
