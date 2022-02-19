# omniedge-synology

Synology package for Omniedge based on pre-compiled binary.

Download for your synology Model: 

|Series|Generic Arch|Download Link|
|---|---|---|
|FS,SA,x22,x21 Series,x20(DS220+, DS420+,RS820+, RS820RP+,DS720+, DS920+, DS1520+,DS620slim) |x86_64|[omniedge_0.2.1_amd64](https://github.com/omniedgeio/omniedge-synology/releases/download/v0.2.1/omniedge_0.2.1_amd64.spk)|
|DS220j, DS420j,DS120j |arm64v8|[omniedge_0.2.1_arm64v8](https://github.com/omniedgeio/omniedge-synology/releases/download/v0.2.1/omniedge_0.2.1_arm64v8.spk)|
|DS419slim|armv7|[omniedge_0.2.1_armv7](https://github.com/omniedgeio/omniedge-synology/releases/download/v0.2.1/omniedge_0.2.1_armv7.spk)|


## Release Notes

|Version|Release Date|Notes|
|---|---|---|
|0.2.1|January, 15, 2022|Integrated with new backend|
|0.1.0|Apr 8, 2021|Initial release|


## How to use 

+ Sign up your account: [Sign up](https://omniedge.io/register)

+ Download and install omnidge cli by running the following command:

``` bash
curl https://omniedge.io/install/omniedge-install.sh | bash
```

+ Login By Password:

``` bash
omniedge login -u yourname@youremail.com -f your_auth_file_path
```
+ Login By Secret-Key, You can generate secret-key on omniedge web

```bash
omniedge login -s yoursecuritykey -f your_auth_file_path
```

+ Join Your Network,you can just call omniedge join, it will automatically prompt the available network for you to choose. And you can also add one parameter -n to specify the network id manually. And then, enjoy the omniedge network.

```bash
sudo omniedge join -f your_auth_file_path
```
and select your virtual network or

``` bash
sudo omniedge join -n 'virtual-network-id'
```
with a speicified virtual network.

+ Wait a second and a secure VPN will be established
