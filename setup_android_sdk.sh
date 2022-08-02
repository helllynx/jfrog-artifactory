#!/bin/bash
set -o errexit

if [[ $EUID -ne 0 ]]; then
   echo 'This script must be run as root' 1>&2
   exit 1
fi

ANDROID_SDK_TOOLS_LINK=https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
ANDROID_SDK_HOME=/opt/android
ANDROID_SDK_ROOT=$ANDROID_SDK_HOME/sdk

function color_echo() {
    echo -e "\e[32m$1\e[0m"
}

color_echo 'Installing common packages...'
apt install -y fail2ban wget curl unzip
apt install -y software-properties-common # contains add-apt-repository

color_echo 'Installing OpenJDK...'
add-apt-repository -y ppa:openjdk-r/ppa
# apt install -y openjdk-8-jdk # Jenkins doesn't support Java 13, 8 will be set as default
apt install -y openjdk-13-jdk
update-java-alternatives --set java-1.8.0-openjdk-amd64

color_echo 'Installing Git...'
add-apt-repository -y ppa:git-core/ppa
apt install -y git


color_echo 'Installing Android SDK...'
wget -O android-sdk-tools.zip $ANDROID_SDK_TOOLS_LINK
mkdir -p $ANDROID_SDK_ROOT
unzip android-sdk-tools.zip -d $ANDROID_SDK_ROOT
chmod -R 777 $ANDROID_SDK_HOME
rm android-sdk-tools.zip
set +o pipefail
yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager --licenses > /dev/null
set -o pipefail
echo "ANDROID_SDK_HOME=$ANDROID_SDK_HOME" >> /etc/environment
echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> /etc/environment
