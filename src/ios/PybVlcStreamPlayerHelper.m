//
//  PybVlcStreamPlayerHelper.m
//  
//
//  Created by Yanbing Peng on 10/02/16.
//
//
#import "PybVlcStreamPlayerHelper.h"
#import "PybVlcStreamPlayerViewController.h"

@interface PybVlcStreamPlayerHelper()
@end

@implementation PybVlcStreamPlayerHelper
-(void) openPlayerForStreamURL:(CDVInvokedUrlCommand *)command{
    CDVPluginResult *pluginResult = nil;
    NSString *urlString  = [command.arguments objectAtIndex:0];
    
    if(urlString != nil){
        PybVlcStreamPlayerViewController *vlcStreamPlayerViewController = [[PybVlcStreamPlayerViewController alloc] init];
        vlcStreamPlayerViewController.urlString = urlString;
		self.overlay = vlcStreamPlayerViewController
        [self.viewController presentViewController:self.overlay animated:YES completion:nil];
		// on the view controller make a reference to this class
    	self.overlay.origem = self;

       // pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Done"];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

-(void) finishOkAndDismiss {
    // End the execution
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                callbackId:self.lastCommand.callbackId];
    
    // dismiss view from stack
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    

}

@end