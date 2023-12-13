interface Window {
    VideoPlayerVLC: VideoPlayerVLC;
}

interface VideoPlayerVLC {
    play: (uri: string, success: (result: any) => void, failure: (result: any) => void) => void

    stop: (success: (result: any) => void, failure: (result: any) => void) => void
}
