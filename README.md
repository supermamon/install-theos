``bash`` script to install [theos](https://github.com/theos/theos). See Supported Systems section for tested operating systems.

## Arguments

|Argument        |Description  |Examples|
|----------------|-------------|--------|
|--installdir, -d|Specify the directory where to install. Default is /opt/|--installdir /var/|
|--sdks, -s      |List of SDKS to download. Enclose in quotes if multiple.|--sdks "8.1 9.2"|
|--createnic, -n |Create ~/.nicrc file. Pass *Y* to create. Default is *N*.|--createnic Y|
|--nicusername, -u|Default username when creating a tweak.|--nicusername tweakmaker <br />OR<br /> --u "tweakmaker &lt;tweakmaker@mycompany.com&gt;"|
|--nicprefix, -p|Default bundle id prefix.|--nicprefix com.mycompany|
|--fallback, -f|Include [fallback headers](https://github.com/supermamon/iOS-fallback-headers). Default is N.|--fallback Y|

## Download & Run

````bash
git clone https://github.com/supermamon/install-theos
cd install-theos
chmod +x install.sh
./install.sh <args>

````

## Examples

*Custom install directory*
````bash
./install.sh --installdir /var/
````

*Custom SDKS*  
Available SDKs can be found at https://sdks.website/.

````bash
./install.sh --sdks "8.1 9.1"
````

*Create a NIC profile*  

````bash
./install.sh --createnic y --nicusername tweakmaker --nicprefix com.tweakmaker
# OR
./install.sh --createnic y --nicusername "tweakmaker <tm@tweakmaker.net>" --nicprefix net.tweakmaker
````

*All parameters*
````bash
./install.sh --installdir /var/ --sdks "8.1 9.3" --createnic y --nicusername "tweakmaker <tm@tweakmaker.net>" --nicprefix net.tweakmaker --fallback Y

#OR

./install.sh -d /var/ -s "8.1 9.3" -n y -u "tweakmaker <tm@tweakmaker.net>" -p net.tweakmaker -f Y

````

## NEXT STEP

Add the following lines to your ~/.bash_profile or ~/.bashrc

````bash
export THEOS=/opt/theos

#Optional
export THEOS_DEVICE_IP=<ip of your device>
export THEOS_DEVICE_PORT=22
````

## Supported Systems
* Windows 7 (Cygwin)
* Windows 10 (Cygwin)
* Linux Mint 17.3 "Rosa"
* Linux Mint 18 "Sara"
* Ubuntu 14.04.2 LTS


## TODO

* option to create $THEOS variable
* OSX support
