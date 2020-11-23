# React Native BePaid
React Native module for BePaid payment system

Develop enviroment: MacOS Catalina, WebStorm 2020.2.3, Android Studio 4.0, XCode 12

### Android
Native Android module was written in Kotlin. To implement features from native library just add new payment methods in
BepaidActivity.kt and pass params to it through intent in BepaidModule.kt. You can add additional setup methods to
BepaidModule.kt and declare it in src/index.tsx to create TS definition of Kotlin method.

### iOS
Native iOS module was written in Swift. Do not forget to create bridging header to use this library!
To implement from native library just add new payment methods in BepaidViewController.swift and pass params to it throught
NSObject in Bepaid.swift. You can add additional setup methods to Bepaid.kt and declare it in src/index.tsx
to create TS definition of Kotlin method.
##### Important:
There is a bug with localization: NSLocalizedString dont work in begateway with RN Bridge, so if you want to change language -
just copy necessary locale to Danish locale in begateway module.

### Start test project
    yarn && yarn bootstrap

    //start ios
    cd example && yarn ios
    //start android
    cd example && yarn android
