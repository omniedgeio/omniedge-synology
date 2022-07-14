# omniedge-synology

Synology package for Omniedge based on pre-compiled binary.

Download for your synology Model: 

|Series|Generic Arch|Download Link|
|---|---|---|
|FS,SA,x22,x21 Series,x20(DS220+, DS420+,RS820+, RS820RP+,DS720+, DS920+, DS1520+,DS620slim) |x86_64|[omniedge_0.2.3_amd64](https://github.com/omniedgeio/omniedge-synology/releases/download/v0.2.4/omniedge_0.2.3_amd64.spk)|
|DS220j, DS420j,DS120j |arm64v8|[omniedge_0.2.3_arm64v8](https://github.com/omniedgeio/omniedge-synology/releases/download/v0.2.4/omniedge_0.2.3_arm64v8.spk)|
|DS419slim|armv7|[omniedge_0.2.3_armv7](https://github.com/omniedgeio/omniedge-synology/releases/download/v0.2.4/omniedge_0.2.3_armv7.spk)|


## Release Notes

|Version|Release Date|Notes|
|--|--|--|
|0.2.5|July, 14, 2022|Fix DSM7 & DSM6 running error|
|0.2.4|July, 12, 2022|Add configuration wizard during installation|
|0.2.3|April, 25, 2022|Add refresh token|
|0.2.2|February, 27,2022|Fix machine ID error|
|0.2.1|January, 15, 2022|Integrated with new backend|
|0.2.0 |August,2, 2021|Initial release , new backend API,Optimize workflow,Fix incorrect device mac block the OmniEdge start|
|0.1.0|Apr 8, 2021|Initial release|


## How to use 

1. Sign up your account
2. Generate **Security-key** and get the **Virtual Network ID** from [Dashboard](https://omniedge.io/dashboard)
3. Download and install OmniEdge Synology
4. Fill **Security-key** and **Network ID** during the installation wizard
5. Install for DSM7 `sudo sed -i 's/package/root/g' /var/packages/omniedge/conf/privilege`, for DSM6 `route add -net 100.100.0.0/24 dev networkcardname`


![](omnedge-synology.png)
