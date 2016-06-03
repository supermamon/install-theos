``bash`` script to install [theos](https://github.com/theos/theos).

## Arguments

|Argument        |Description  |Examples|
|----------------|-------------|--------|
|--installdir, -d|Specify the directory where to install. Default is /opt/|--installdir /var/|
|--sdks, -s      |List of SDKS to download. Enclose in quotes if multiple.|--sdks "8.1 9.2"|
|--createnic, -n |Create ~/.nicrc file. Pass *Y* to create. Default is *N*.|--createnic Y|
|--nicusername, -u|Default username when creating a tweak.|--nicusername tweakmaker <br />OR<br /> --u "tweakmaker &lt;tweakmaker@mycompany.com&gt;"|
|--nicprefix, -p|Default bundle id prefix.|--nicprefix com.mycompany|

## Download

````bash
git clone https://github.com/supermamon/install-theos
cd install-theos
````
## Run
````bash
chmod +x <platform>.sh
./<platform>.sh <args>

# Example:
chmod +x cygwin.sh
./cygwin.sh
````

## Examples

*Custom install directory*
````bash
./cygwin.sh --installdir /var/
````

*Custom SDKS*  
Available SDKs can be found at https://jbdevs.org/sdks/.

````bash
./linux.sh --sdks "8.1 9.1"
````

*Create a NIC profile*  

````bash
./cygwin.sh --createnic y --nicusername tweakmaker --nicprefix com.tweakmaker
# OR
./linux.sh --createnic y --nicusername "tweakmaker <tm@tweakmaker.net>" --nicprefix net.tweakmaker
````

*All parameters*
````bash
./linux.sh --installdir /var/ --sdks "8.1 9.3" --createnic y --nicusername "tweakmaker <tm@tweakmaker.net>" --nicprefix net.tweakmaker

#OR

./cygwin.sh -d /var/ -s "8.1 9.3" --n y --u "tweakmaker <tm@tweakmaker.net>" --p net.tweakmaker

````

## NEXT STEP

Add the following lines to your ~/.bash_profile or ~/.bashrc

````bash
export THEOS=/opt/theos

#Optional
export THEOS_DEVICE_IP=<ip of your device>
export THEOS_DEVICE_PORT=22
````


## TODO

* create $THEOS variable
* OSX script
* Unified script
