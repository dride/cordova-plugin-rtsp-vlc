# com.pengyanb.vlcstreamplayer
PhoneGap/Cordova VLC Stream Player Plugin

### Supported Platform
iOS **7.0** up

Android

### Installation
```
phonegap plugin add https://github.com/pengyanb/com.pengyanb.vlcstreamplayer.git
```

#### Extra setup step for iOS

* Integrate MobileVLCKit.framework to your iOS project via [CocoaPods](https://cocoapods.org/)

OR obtain and build MobileVLCKit.framework from [VideoLan](https://wiki.videolan.org/VLCKit/), then add to your project as **Linked Frameworks and Libraries**

OR download the built version directly from [here](), then add to your project as **Linked Frameworks and Libraries**

* Make sure all the framework is include to your project correctly:

![frameworks]
(https://raw.githubusercontent.com/pengyanb/PhonegapVlcStreamPlayerDemo/master/images/Screen%20Shot%202016-02-11%20at%2010.25.40.png)

**libbz2.dylib, libiconv.dylib, libstdc++.dylib, libz.dylib** can be found by go to **Build Phases** -> **Link Binary with Libraries** -> **+** -> **Add other**, then press **Command** key + **shift** + **G**, type **/usr/lib** 

* Go to **Build Settings** -> **Build Options** -> **Enable Bitcode** -> set to **NO**

![Enable Bitcode](https://raw.githubusercontent.com/pengyanb/PhonegapVlcStreamPlayerDemo/master/images/Screen%20Shot%202016-02-11%20at%2010.40.05.png)

* Under **Build Settings** -> **Apple LLVM 7.0 - Language - C++**

    set **C++ Language Dialect** to **C++11[-std=c++11]**
    
    set **C++ Standard Library** to **libstdc++(GNU C++ Standard Library)**

![C++](https://raw.githubusercontent.com/pengyanb/PhonegapVlcStreamPlayerDemo/master/images/Screen%20Shot%202016-02-11%20at%2010.40.32.png)
 
 
### Usage
 ```
 window.PYB.vlcStreamPlayer.openPlayerForStreamURL(successHandler, errorHandler, urlString);
 ```
 
 For Instance:
 ```
 window.PYB.vlcStreamPlayer.openPlayerForStreamURL(function(){}, function(){}, "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov");
 ```
 
### Demo
[PhoneGap VLC Stream Player Demo] (https://github.com/pengyanb/PhonegapVlcStreamPlayerDemo) 


