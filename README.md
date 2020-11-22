# React Native BePaid
React Native module for BePaid payment system

Develop enviroment: MacOS Catalina, WebStorm 2020.2.3, Android Studio 4.0, XCode 12

### Android
Native Android module is written with Kotlin. To implement features from native library just add new payment methods in
BepaidActivity.kt and pass params to it through intent in BepaidModule.kt. You can add additional setup methods to
BepaidModule.kt and declare it in src/index.tsx to create TS definition of Kotlin method.

### Start test project
    yarn && yarn bootstrap
