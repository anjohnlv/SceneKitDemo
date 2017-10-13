//
//  ViewController.m
//  RobotDemo
//
//  Created by anjohnlv on 2017/10/11.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) IBOutlet UIButton *walkButton;
@property (strong, nonatomic) IBOutlet SCNView *scnView;
@property (strong, nonatomic) SCNNode *robot,*camera;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/showcase.scn"];
    self.scnView.scene = scene;
    self.scnView.autoenablesDefaultLighting = YES;
    self.robot = [scene.rootNode childNodeWithName:@"robot" recursively:NO];
    self.camera = [scene.rootNode childNodeWithName:@"camera" recursively:NO];
}

#pragma mark - action
-(IBAction)leftHand {
    SCNNode *leftHand = [_robot childNodeWithName:@"leftShoulder" recursively:NO];
    [self raiseHand:leftHand];
}

-(IBAction)rightHand {
    SCNNode *rightHand = [_robot childNodeWithName:@"rightShoulder" recursively:NO];
    [self raiseHand:rightHand];
}

-(IBAction)walk:(UIButton *)sender {
    [self goForward:sender follow:NO];
}

-(IBAction)follow:(UIButton *)sender {
    [self goForward:sender follow:YES];
}

-(IBAction)nod {
    SCNNode *head = [_robot childNodeWithName:@"head" recursively:NO];
    SCNAction *raiseAction = [SCNAction rotateToX:0.3 y:0 z:0 duration:0.3];
    SCNAction *putAction = [SCNAction rotateToX:0 y:0 z:0 duration:0.3];
    SCNAction *sequenceAction = [SCNAction sequence:@[raiseAction,putAction]];
    SCNAction *repeatAction = [SCNAction repeatAction:sequenceAction count:2];
    repeatAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    [head runAction:repeatAction];
}

-(IBAction)shakeHead {
    SCNNode *head = [_robot childNodeWithName:@"head" recursively:NO];
    SCNAction *leftAction = [SCNAction rotateToX:0 y:-0.3 z:0 duration:0.5];
    SCNAction *rightAction = [SCNAction rotateToX:0 y:0.3 z:0 duration:0.5];
    SCNAction *sequenceAction = [SCNAction sequence:@[leftAction,rightAction]];
    SCNAction *repeatAction = [SCNAction repeatAction:sequenceAction count:2];
    SCNAction *centerAction = [SCNAction rotateToX:0 y:0 z:0 duration:0.5];
    SCNAction *sequenceAction2 = [SCNAction sequence:@[repeatAction,centerAction]];
    sequenceAction2.timingMode = SCNActionTimingModeEaseInEaseOut;
    [head runAction:sequenceAction2];
}

-(void)raiseHand:(SCNNode *)hand {
    SCNAction *raiseAction = [SCNAction rotateToX:-2.5 y:0 z:0 duration:0.5];
    SCNAction *putAction = [SCNAction rotateToX:0 y:0 z:0 duration:0.5];
    SCNAction *sequenceAction = [SCNAction sequence:@[raiseAction,putAction]];
    [hand runAction:sequenceAction];
}

-(void)takeStep:(SCNNode *)foot{
    SCNAction *raiseAction = [SCNAction rotateToX:0.5 y:0 z:0 duration:0.5];
    SCNAction *putAction = [SCNAction rotateToX:0 y:0 z:0 duration:0.5];
    SCNAction *sequenceAction = [SCNAction sequence:@[raiseAction,putAction]];
    SCNAction *repeatAction = [SCNAction repeatActionForever:sequenceAction];
    [foot runAction:repeatAction];
}

-(void)goForward:(UIButton *)sender follow:(BOOL)follow {
    BOOL go = ![[[sender titleLabel]text]isEqualToString:@"停"];
    [sender setTitle:go?@"停":follow?@"跟随":@"走" forState:UIControlStateNormal];
    SCNNode *leftFoot = [_robot childNodeWithName:@"leftHip" recursively:NO];
    SCNNode *rightFoot = [_robot childNodeWithName:@"rightHip" recursively:NO];
    if (go) {
        [self takeStep:leftFoot];
        [self performSelector:@selector(takeStep:) withObject:rightFoot afterDelay:0.5];
        [self move:_robot];
        if (follow) {
            [self move:_camera];
        }
    }else{
        [self standUp:leftFoot];
        [self standUp:rightFoot];
        [_robot removeAllActions];
        if (follow) {
            [_camera removeAllActions];
        }
    }
    [(follow?self.walkButton:self.followButton) setEnabled:!go];
}

-(void)move:(SCNNode *)node {
    SCNAction *moveAction = [SCNAction moveByX:0 y:0 z:1 duration:0.5];
    SCNAction *repeatAction = [SCNAction repeatActionForever:moveAction];
    [node runAction:repeatAction];
}

-(void)standUp:(SCNNode *)foot {
    [foot removeAllActions];
    SCNAction *standAction = [SCNAction rotateToX:0 y:0 z:0 duration:0.5];
    [foot runAction:standAction];
}

@end
