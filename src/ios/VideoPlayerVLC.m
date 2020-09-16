//
//  VideoPlayerVLC.m
//  
//
//  Created by Yanbing Peng on 10/02/16.
//
//
#import "VideoPlayerVLC.h"
#import <MobileVLCKit/MobileVLCKit.h>
#import <UIKit/UIKit.h>



@implementation VideoPlayerVLC
-(void) play:(CDVInvokedUrlCommand *)command{
    
    self.lastCommand = command;
    
    
    CDVPluginResult *pluginResult = nil;
    NSString *urlString  = [command.arguments objectAtIndex:0];
    
    if(urlString != nil){
        // we use that to respond to the plugin when it finishes
        self.lastCommand = command;
        
        self.overlay = [[VideoPlayerVLCViewController alloc] init];
        if(self.mediaPlayer == nil) {
            self.mediaPlayer = [[VLCMediaPlayer alloc] initWithOptions:@[@"--network-caching=2000 --clock-jitter=0 -- clock-synchro=0"]];
        }
        self.overlay.urlString = urlString;
        
        // on the view controller make a reference to this class
        self.overlay.origem = self;
        
        // set modal fullscreen on ios 13+
        if(@available(iOS 13.0, *)) {
            [self.overlay setModalPresentationStyle: UIModalPresentationFullScreen];
        }
        
        [self.viewController presentViewController:self.overlay animated:YES completion:nil];

    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    }

}

-(void) close:(CDVInvokedUrlCommand *)command{

    self.lastCommand = command;
    [self finishOkAndDismiss];

}

-(void) finishOkAndDismiss{
    
    if(self.mediaPlayer != nil){
        if(self.mediaPlayer.isPlaying){
            [self.mediaPlayer stop];
        }
    }
    
    // End the execution
    CDVPluginResult *pluginResult = nil;
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onDestroyVlc"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self.lastCommand.callbackId];
    
    // dismiss view from stack
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    

}

@end
