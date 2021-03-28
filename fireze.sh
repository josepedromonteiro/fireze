#!/bin/bash

RED='\033[0;31m'
COLOR_PURPLE='\e[0;35m' 
COLOR_GREEN='\e[0;32m'
COLOR_RED='\e[0;31m'
COLOR_YELLOW='\e[1;33m'
COLOR_CYAN='\e[0;36m'
NC='\033[0m' # No Color
DIM='\e[2m'
UNDERLINE='\e[4m'
USER_NAME=$(whoami)
PROFILE_FOLDER="/Users/$USER_NAME/Library/Application Support/Firefox/Profiles"
PROFILE_FILE=''

installFirefox(){
  which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi
brew install --cask firefox
}

if [ ! -d "/Applications/Firefox.app" ]; then
printf "${RED}Firefox not installed${NC}\n"
printf "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) installFirefox; break;;
        No ) exit;;
    esac
done
fi
PROFILE_FILE=$(find "${PROFILE_FOLDER}" -name '*.default-*')
printf "\n${DIM}Profile folder: ${UNDERLINE}${PROFILE_FILE}${NC}\n\n"
mkdir -p "${PROFILE_FILE}/chrome"
cp -a ./chrome/. "${PROFILE_FILE}/chrome"
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "${PROFILE_FILE}/prefs.js"
echo 'user_pref("layout.css.backdrop-filter.enabled", true);' >> "${PROFILE_FILE}/prefs.js"
printf "💅 ${COLOR_YELLOW} Fireze ${COLOR_GREEN} successfully ${COLOR_CYAN} installed! ${NC} 💅\n\n"
printf "🦊 ${COLOR_PURPLE}Firefox${NC} needs to be resarted, do you want to do it now?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

pkill -f firefox
printf "⌛ Opening firefox...\n"
sleep 2
open /Applications/Firefox.app


#rm -r ${PROFILE_FOLDER}/chrome; mkdir ${PROFILE_FOLDER}/chrome
