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

@property(strong, nonatomic) UIButton *closeButton;
@property(strong, nonatomic) UIButton *playButton;
@property(strong, nonatomic) UIView *mediaView;
@end

@implementation PybVlcStreamPlayerViewController

-(id)init{
    if (self = [super init]){
        self.playOnStart = YES;
    }
    return  self;
}

- (void)viewDidLoad {
    NSLog(@"[PybVlcStreamPlayerViewController viewDidLoad]");
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor blackColor];
    
    

    self.playButton = [[UIButton alloc] init];
    self.closeButton = [[UIButton alloc] init];
    self.mediaView = [[UIView alloc] init];
    self.mediaPlayer = [[VLCMediaPlayer alloc] init];
    
    
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.closeButton setTitle:@"×" forState:UIControlStateNormal];
    [self.closeButton setFont:[UIFont systemFontOfSize:20]];
    
    self.mediaView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mediaView.backgroundColor = [UIColor blackColor];
    
    
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.mediaView];
    

    NSLayoutConstraint *closeButtonTopConstraint = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *closeButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeftMargin multiplier:1.0 constant:0.0];

    NSLayoutConstraint *closeButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];

    
    NSLayoutConstraint *mediaViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *mediaViewCenterHorizontallyConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *mediaViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.closeButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0];
    NSLayoutConstraint *mediaViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [self.view addConstraint:closeButtonTopConstraint];
    [self.view addConstraint:closeButtonLeftConstraint];
    [self.view addConstraint:closeButtonHeightConstraint];
    [self.view addConstraint:mediaViewWidthConstraint];
    [self.view addConstraint:mediaViewCenterHorizontallyConstraint];
    [self.view addConstraint:mediaViewTopConstraint];
    [self.view addConstraint:mediaViewBottomConstraint];
    
    self.mediaPlayer.drawable = self.mediaView;
    
    [self.closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
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
    }
}


- (void)closeButtonPressed{
    if(self.mediaPlayer != nil){
        if(self.mediaPlayer.isPlaying){
            [self.mediaPlayer stop];
        }
    }
	[self.origem finishOkAndDismiss];
}

@end

