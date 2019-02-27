//
//  VideoPlayerVLC.m
//  
//
//  Created by Yanbing Peng on 10/02/16.
//  Edited by Yossi Neiman
//
//
#import "VideoPlayerVLC.h"


@implementation VideoPlayerVLC

static VideoPlayerVLC* instance = nil;
static CDVInvokedUrlCommand* commandGlob = nil;

+ (id) getInstance{
    return instance;
}

-(void) play:(CDVInvokedUrlCommand *) command {

    instance = self;
    commandGlob = command;
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
            
            
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
            [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"url-invalid"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    }
    
    
}

-(void) stopInner{
    
    CDVPluginResult *pluginResult = nil;
    if (self.player != nil) {
        @try {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onDestroyVlc"];
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not-playing"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId: commandGlob.callbackId];
}

-(void) stop:(CDVInvokedUrlCommand *) command {
    
    CDVPluginResult *pluginResult = nil;
    if (self.player != nil) {
        @try {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onDestroyVlc"];
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not-playing"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId: commandGlob.callbackId];
}

@end
