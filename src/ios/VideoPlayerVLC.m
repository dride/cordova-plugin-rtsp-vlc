//
//  VideoPlayerVLC.m
//  
//
//  Created by Yanbing Peng on 10/02/16.
//
//
#import "VideoPlayerVLC.h"


@implementation VideoPlayerVLC
-(void) play:(CDVInvokedUrlCommand *)command{
    
    self.lastCommand = command;
    
    
    CDVPluginResult *pluginResult = nil;
    NSString *urlString  = [command.arguments objectAtIndex:0];
    
    if(urlString != nil){
        // we use that to respond to the plugin when it finishes
        self.lastCommand = command;
        
        self.overlay = [[VideoPlayerVLCViewController alloc] init];
        self.overlay.urlString = urlString;
        
        // on the view controller make a reference to this class
        self.overlay.origem = self;
        
        [self.viewController presentViewController:self.overlay animated:YES completion:nil];

    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    }

}

-(void) finishOkAndDismiss{
    
    // End the execution
    CDVPluginResult *pluginResult = nil;
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onDestroyVlc"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self.lastCommand.callbackId];
    
    // dismiss view from stack
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    

}

@end
