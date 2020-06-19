
[![Platform](https://img.shields.io/badge/platform-macOS%2010.15%2B-orange.svg)](https://github.com/HsiangHo/WWDC-Ticket-Pass)
[![Language](https://img.shields.io/badge/language-swift%205.2-red.svg)](https://github.com/HsiangHo/WWDC-Ticket-Pass)

### Design and generate your own WWDC20 ticket pass and add it to your wallet.

<img src="Docs/Wallet.png" width="380px">

## Demo

I've generated a demo pkpass file (Demo.pkpass) and you can Airdrop it to your iPhone, it will be directly added to Wallet.

## Requirements

- Paid Apple Developer Account (To sign your pkpass file)
- Pass Type Identifier and Certificate
- Team Identifier

#### How to request Pass Type Identifier and Certificate  
<img src="Docs/PassTypeID.png" width="380px">  

#### How to get Team Identifier  
<img src="Docs/TeamID.png" width="380px">

## Generate Pass
#### Using Generator (macOS 10.15+)
<img src="Docs/Generator.png" width="380px">
<img src="Docs/Generate.png" width="380px">
<img src="Docs/Sign.png" width="380px">

#### Manual
Re-edit the json file in Demo.pass folder  
<img src="Docs/Json.png" width="380px">  
Sign to generate pkpass file using signpass  
```
./signpass -p ./Demo.pass
```
<img src="Docs/Manual.png" width="380px">

## Airdrop to Wallet
<img src="Docs/Airdrop.png" width="380px">

