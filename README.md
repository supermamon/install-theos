``bash`` script to install [theos](https://github.com/theos/theos).

## What does this do?

* Installs [theos](https://github.com/theos/theos) and [headers](https://github.com/theos/headers).
* Downloads SDKs (iOS 9.2 only by default)
* (Optional) Downloads [fallback headers](https://github.com/supermamon/iOS-fallback-headers).
* (Optional) Creates [~/.nicrc](https://github.com/theos/theos/wiki/nicrc%285%29)

## Arguments

|Argument        |Description  |Examples|
|----------------|-------------|--------|
|--installdir, -d|Specify the directory where to install. Default is ~/|--installdir /opt/|
|--sdks, -s      |List of SDKS to download. Enclose in quotes if multiple. Default is 9.2. |--sdks "8.1 9.2"|
|--createnic, -n |Create ~/.nicrc file. Pass *Y* to create. Default is *N*.|--createnic Y|
|--nicusername, -u|Default username when creating a tweak.|--nicusername tweakmaker <br />OR<br /> --u "tweakmaker &lt;tweakmaker@mycompany.com&gt;"|
|--nicprefix, -p|Default bundle id prefix.|--nicprefix com.mycompany|
|--fallback, -f|Include [fallback headers](https://github.com/supermamon/iOS-fallback-headers). Default is *N*.|--fallback Y|
|--reinstall, -r|Delete and re-install theos. Default is *N*.|--reinstall Y|
|--install-dependencies, -e|Include dependencies when installing. Default is *Y*.|--install-dependencies N|
|--no-platformcheck, -c|Skip checking OS/platform when installing. Useful when testing on unsupported platforms. Default is *N*.|--no-platformcheck Y|

## Download & Run

If you want to get to work quickly:
````bash
curl -JOLks https://git.io/install-theos && bash install-theos
````

Or if you want to download it first:
````bash
git clone https://github.com/supermamon/install-theos
cd install-theos
chmod +x install
./install [args]
````


<!-- wget https://git.io/install-theos && bash install-theos [args] -->

## Examples

*Default Installation*

This will install theos and its dependencies on the home directory with iOS9.2 SDK
````bash
./install
````

*Custom install directory*
````bash
./install --installdir /var/
````

*Custom SDKS*  
Available SDKs can be found at https://sdks.website/.

````bash
./install --sdks "8.1 9.1"
````

*Delete and re-install theos with 9.3 SDK*

````bash
./install --reinstall Y --sdks 9.3
````

*Create a NIC profile*  

````bash
./install --createnic y --nicusername tweakmaker --nicprefix com.tweakmaker
# OR
./install --createnic y --nicusername "tweakmaker <tm@tweakmaker.net>" --nicprefix net.tweakmaker
````

*Skip dependency download*

````bash
./install --install-dependencies N
````


*All parameters*
````bash
./install --installdir /var/ --sdks "8.1 9.3" --createnic y --nicusername "tweakmaker <tm@tweakmaker.net>" --nicprefix net.tweakmaker --fallback Y
--reinstall Y --install-dependencies Y --no-platformcheck N
#OR

./install -d /var/ -s "8.1 9.3" -n y -u "tweakmaker <tm@tweakmaker.net>" -p net.tweakmaker -f Y -r y -e Y -c N

````

## NEXT STEP

Add the following lines to your ~/.bash_profile or ~/.bashrc

````bash
export THEOS=~/theos

#Optional
export THEOS_DEVICE_IP=<ip of your device>
export THEOS_DEVICE_PORT=22
````

## Tested Platforms
* Windows 7 (Cygwin)
* Windows 10 (Cygwin)
* Linux Mint 17+
* Ubuntu 14.04+

## Todo

* option to create $THEOS variable
* iOS & OSX support

## Changelog

* v2.0.1 :
  - Added error handing on removing previous install
* v2.0.0 :
  - Made `curl` a hard requirement for the script
  - Add `--install-dependencies` option. Default Y.
  - Add `--no-platformcheck` option. Default N.
* v1.2.1 :
  - Updated iPhoneOS9.3 SDK source
* v1.2.0 :
  - Custom iPhoneOS9.3 SDK source
  - More error handling
  - UI changes
* v1.1.0
  - Added Reinstall parameter
  - Additional dependecy checks
  - Check if install folder is writeable.
  - Add ownership change
  - Add wget error handling
  - Progress message formatting
* v1.0.1
  - Updated sdks website
* v1.0.0
  - Merged indivual scripts
* v0.2.0
  - Script for Linux
* v0.1.0
  - Script for Cygwin
