THEOS_FOLDER_NAME="theos"
THEOS_INSTALL_FOLDER="/opt/"
CREATE_NIC="N"
NIC_USERNAME="My Name <myname@domain.com>"
NIC_PREFIX="com.mycompany"
SETUP_TMP="_theos_setup_"
declare -a SDKS=(7.1 8.1 9.2);

rm -rf $SETUP_TMP
clear

# start name parameters parser
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# Use > 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use > 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to > 0 the /etc/hosts part is not recognized ( may be a bug )
while [[ $# > 1 ]]
do
key="$1"

case $key in
    -d|--installdir)
    THEOS_INSTALL_FOLDER="$2"
    shift # past argument
    ;;
    -n|--createnic)
    CREATE_NIC="$2"
    CREATE_NIC=${CREATE_NIC^^}
    shift # past argument
    ;;
    -u|--nicusername)
    NIC_USERNAME="$2"
    shift # past argument
    ;;
    -p|--nicprefix)
    NIC_PREFIX="$2"
    shift # past argument
    ;;
    -s|--sdks)
    ARG_SDKS="$2"
    declare -a SDKS=($ARG_SDKS);
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
    # unknown option
    ;;
esac
shift # past argument or value
done
# end name parameters parser
echo
echo -e "\e[92mtheos will be installed with the following configuration.\e[39;49m "
echo
echo -e "THEOS_INSTALL_FOLDER = ${THEOS_INSTALL_FOLDER}"
echo -e "CREATE_NIC           = ${CREATE_NIC}"
if [ "$CREATE_NIC" == "Y" ]
then
echo -e "NIC_USERNAME         = ${NIC_USERNAME}"
echo -e "NIC_PREFIX           = ${NIC_PREFIX}"
fi
for i in ${SDKS[@]}; do
  SDKSTR="$SDKSTR${i} "
done
echo -e "SDKS                 = ${SDKSTR}"
echo

read -p $'\e[92mProceed (Y/N)?\e[39;49m ' -n 1 -r;
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo -e "\e[97;41mtheos install aborted.\e[39;49m"
    exit 1
fi
echo
echo -e "\e[30;103m [PRE-SETUP CHECK...]                                    \e[39;49m "
echo
echo ">> Checking parameters..."
if [ -d "$THEOS_INSTALL_FOLDER$THEOS_FOLDER_NAME" ]; then
  echo;
  echo -e "\e[97;41mTHEOS is already installed in $THEOS_INSTALL_FOLDER$THEOS_FOLDER_NAME.\e[39;49m"
  exit 1;
fi

if [ "$CREATE_NIC" == "Y" ]
then

  if [ -e ~/.nicrc ]; then
    echo;
    echo -e "\e[97;41m.nicrc already exists. Back it up and remove.\e[39;49m"
    exit 1;
  fi


  if [ "$NIC_USERNAME" == "My Name <myname@domain.com>" ]
  then
    echo;
    echo -e "\e[97;41mYou need to provide a new username using the --nicusername (-u) parameter.\e[39;49m"
    exit 1
  fi

  if [ "$NIC_PREFIX" == "com.mycompany" ]
  then
    echo;
    echo -e "\e[97;41mYou need to provide a new prefix using the --nicprefix (-p) parameter.\e[39;49m"
    exit 1
  fi

fi
echo "   Done."

echo ">> Checking dependencies..."
DEP_MISSING=0
declare -a deps=(wget git ca-certificates make perl ssh python)
for i in ${deps[@]}; do
  if [[ $(dpkg-query -W -f='${Status}\n' ${i} 2>/dev/null | grep ok) == *"ok"* ]];
  then
    echo -e "   ${i} \e[92mOK\e[39m." ;
  else
    echo -e "   ${i} \e[91mnot installed\e[39m."
    DEP_MISSING=1
  fi
done

if [ "$DEP_MISSING" == "1" ]
then
  echo;
  echo -e "\e[97;41m>> Please run cygwin setup again and install the missing packages.\e[39;49m"
  exit 1
fi

echo "   Done."

echo
echo ">> Ready to install."
echo
echo -e "\e[30;103m [PRE-SETUP CHECK...DONE]                                \e[39;49m ";

echo;
echo -e "\e[30;103m [DOWNLOADING THEOS...]                                  \e[39;49m ";
mkdir -p $SETUP_TMP
cd $SETUP_TMP
echo ">> Cloning git repo..."
git clone --recursive https://github.com/theos/theos.git $THEOS_FOLDER_NAME
echo "   Done."
echo -e "\e[30;103m [DOWNLOADING THEOS...DONE]                              \e[39;49m ";

echo;
echo -e "\e[30;103m [DOWNLOADING SDKS...]                                   \e[39;49m ";
for i in ${SDKS[@]}; do
  echo
  sdk="iPhoneOS${i}.sdk"

  echo -e "  \e[30;103m [DOWNLOADING ${sdk}...]                      \e[39;49m ";
  wget "https://jbdevs.org/sdks/dl/${sdk}.tbz2"

  echo -e "  \e[30;103m [EXTRACTING ${sdk}...]                       \e[39;49m ";
  tar xf ${sdk}.tbz2
  mkdir -p $THEOS_FOLDER_NAME/sdks/
  mv ${sdk} $THEOS_FOLDER_NAME/sdks/
  rm ${sdk}.tbz2

done
echo
echo -e "\e[30;103m [DOWNLOADING SDKS...DONE.]                              \e[39;49m ";

echo;
echo -e "\e[30;103m [DOWNLOADING TOOLCHAIN....]                             \e[39;49m ";
mkdir -p $THEOS_FOLDER_NAME/toolchain/windows
echo ">> Downloading from developer.angelxwind.net..."
wget https://developer.angelxwind.net/Linux/ios-toolchain_clang%2bllvm%2bld64_latest_linux_x86_64.zip
unzip ios-toolchain_clang+llvm+ld64_latest_linux_x86_64.zip -d $THEOS_FOLDER_NAME/toolchain/
echo "   Done."
echo -e "\e[30;103m [DOWNLOADING TOOLCHAIN....DONE.]                        \e[39;49m ";

#echo;
#echo -e "\e[30;103m [DOWNLOADING FALLBACK HEADERS....]                      \e[39;49m ";
#git clone https://github.com/supermamon/iOS-fallback-headers.git $THEOS_FOLDER_NAME/include/_fallback
#echo -e "\e[30;103m [DOWNLOADING FALLBACK HEADERS....DONE.]                 \e[39;49m ";

echo;
echo -e "\e[30;103m [MOVING THEOS TO INSTALL FOLDER...]                     \e[39;49m ";
if [ ! -d "$THEOS_INSTALL_FOLDER" ]; then
  mkdir -p $THEOS_INSTALL_FOLDER
fi
mv $THEOS_FOLDER_NAME $THEOS_INSTALL_FOLDER
echo -e "\e[30;103m [MOVING THEOS TO INSTALL FOLDER...DONE.]                 \e[39;49m ";

if [ "$CREATE_NIC" == "Y" ]
then

  echo -e "\e[30;103m [CREATING .nicrc...]                                    \e[39;49m ";
  echo "username = \"$NIC_USERNAME\"" > .nicrc
  echo "package_prefix = \"$NIC_PREFIX\"" >> .nicrc
  mv -f .nicrc ~/
  echo -e "\e[30;103m [CREATING .nicrc...DONE.]                               \e[39;49m ";

fi

rm -rf $SETUP_TMP
