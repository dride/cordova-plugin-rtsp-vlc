# PhoneGap/Cordova RTSP player using VLC

### Supported Platform
Android
iOS

Android

### Installation

```
cordova plugin add https://github.com/dride/cordova-plugin-rtsp-vlc
```

### Usage

```
window.VideoPlayerVLC.play(
         url,
	 done => {},
	 error => {}
);
```

Example:

```
window.VideoPlayerVLC.play(
         "rtsp://192.168.42.1/live.mov",
	 done => {},
	 error => {}
);
```


References:

https://github.com/disono/libVLC-Player by [@disono](https://github.com/disono)

https://github.com/pengyanb/com.pengyanb.vlcstreamplayer by [@pengyanb](https://github.com/pengyanb)
