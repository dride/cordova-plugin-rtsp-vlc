//
//  PybVlcStreamPlayerViewController.m
//  MobileVLCKiteTest
//
//  Created by Yanbing Peng on 9/02/16.
//  Copyright © 2016 Yanbing Peng. All rights reserved.
//

#import "PybVlcStreamPlayerViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface PybVlcStreamPlayerViewController ()
@property(strong, nonatomic) VLCMediaPlayer *mediaPlayer;

@property(strong, nonatomic) UIButton *playButton;
@property(strong, nonatomic) UIButton *closeButton;
@property(strong, nonatomic) UIView *mediaView;
@end

@implementation PybVlcStreamPlayerViewController

// Load with xib :)
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    isHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    return self;
}



- (void)viewDidLoad {
    NSLog(@"[PybVlcStreamPlayerViewController viewDidLoad]");
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    //self.urlString = @"rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov";
    
    //self.urlTextField = [[UITextField alloc] init];
    self.playButton = [[UIButton alloc] init];
    self.closeButton = [[UIButton alloc] init];
    self.mediaView = [[UIView alloc] init];
    self.mediaPlayer = [[VLCMediaPlayer alloc] init];
    
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    //self.playButton.backgroundColor = [UIColor whiteColor];
    self.playButton.layer.cornerRadius = 5.0;
    self.playButton.layer.borderWidth = 1.0;
    self.playButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.playButton setTitle:@"▶︎" forState:UIControlStateNormal];
    
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    //self.closeButton.backgroundColor = [UIColor greenColor];
    self.closeButton.layer.cornerRadius = 5.0;
    self.closeButton.layer.borderWidth = 1.0;
    self.closeButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.closeButton setTitle:@"◼︎" forState:UIControlStateNormal];
    
    self.mediaView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mediaView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.playButton];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.mediaView];
    
    //NSLog(@"topLayoutGuide is nil: %d",(self.topLayoutGuide == nil));
    
    NSLayoutConstraint *playButtonTopConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0];
    NSLayoutConstraint *playButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeftMargin multiplier:1.0 constant:8.0];
    NSLayoutConstraint *playButtonRightConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.closeButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-20.0];
    NSLayoutConstraint *playButtonEqualWidthConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.closeButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *playButtonEqualHeightConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.closeButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *playButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    NSLayoutConstraint *playButtonHorizontalAlignConstraint = [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.closeButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *closeButtonRightConstraint = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:8.0];
    
    NSLayoutConstraint *mediaViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *mediaViewCenterHorizontallyConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *mediaViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0];
    NSLayoutConstraint *mediaViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];

    [self.view addConstraint:playButtonTopConstraint];
    [self.view addConstraint:playButtonLeftConstraint];
    [self.view addConstraint:playButtonRightConstraint];
    [self.view addConstraint:playButtonEqualWidthConstraint];
    [self.view addConstraint:playButtonEqualHeightConstraint];
    [self.view addConstraint:playButtonHeightConstraint];
    [self.view addConstraint:playButtonHorizontalAlignConstraint];
    [self.view addConstraint:playButtonRightConstraint];
    [self.view addConstraint:closeButtonRightConstraint];
    [self.view addConstraint:mediaViewWidthConstraint];
    [self.view addConstraint:mediaViewCenterHorizontallyConstraint];
    [self.view addConstraint:mediaViewTopConstraint];
    [self.view addConstraint:mediaViewBottomConstraint];
    
    self.mediaPlayer.drawable = self.mediaView;
    
    [self.closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton addTarget:self action:@selector(playButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.playOnStart) {
        if(self.mediaPlayer.media == nil){
            NSURL *mediaUrl = [[NSURL alloc] initWithString:self.urlString];
            if(mediaUrl != nil){
                [self.mediaPlayer setMedia:[[VLCMedia alloc] initWithURL:mediaUrl]];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                return;
            }
        }
        [self.mediaPlayer play];
        [self.playButton setTitle:@"||" forState:UIControlStateNormal];
    }
}
- (void)playButtonPressed{
    if ( (self.mediaPlayer != nil) && (self.urlString != nil)){
        if (self.mediaPlayer.isPlaying){
            [self.mediaPlayer pause];
            [self.playButton setTitle:@"▶︎" forState:UIControlStateNormal];
        }
        else{
            if(self.mediaPlayer.media == nil){
                NSURL *mediaUrl = [[NSURL alloc] initWithString:self.urlString];
                if(mediaUrl != nil){
                    [self.mediaPlayer setMedia:[[VLCMedia alloc] initWithURL:mediaUrl]];
                }
                else{
                    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    return;
                }
            }
            [self.mediaPlayer play];
            [self.playButton setTitle:@"||" forState:UIControlStateNormal];
        }
    }
}

- (void)closeButtonPressed{
    //NSLog(@"[closeButtonPressed]");
    if(self.mediaPlayer != nil){
        if(self.mediaPlayer.isPlaying){
            [self.mediaPlayer stop];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
