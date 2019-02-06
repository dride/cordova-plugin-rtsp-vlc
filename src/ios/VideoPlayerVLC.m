//
//  VideoPlayerVLC.m
//  
//
//  Created by Yanbing Peng on 10/02/16.
//
//
#import "VideoPlayerVLC.h"


@implementation VideoPlayerVLC

-(void) play:(CDVInvokedUrlCommand *) command {

    if (self.player != nil){
        self.player = nil;
    }
    
    CDVPluginResult *pluginResult = nil;
    NSString *urlString  = [command.arguments objectAtIndex:0];
    
    if (urlString != nil) {
        @try {
            if (self.player == nil) {
                self.player = [[VideoPlayerVLCViewController alloc] init];
            }
            
            self.player.urlString = urlString;
            
            [self.viewController addChildViewController:self.player];
            [self.webView.superview insertSubview:self.player.view aboveSubview:self.webView];
            
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
            [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"url-invalid"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

-(void) stop:(CDVInvokedUrlCommand *) command {
    
    CDVPluginResult *pluginResult = nil;
    if (self.player != nil) {
        @try {

            [self.player stop];

            // dismiss view from stack
            [self.player.view removeFromSuperview];
            [self.player removeFromParentViewController];

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not-playing"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

@end
