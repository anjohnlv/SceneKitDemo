//
//  ToolsTableViewController.m
//  CameraNodeDemo
//
//  Created by anjohnlv on 2017/9/25.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ToolsTableViewController.h"

@interface ToolsTableViewController ()
//Z
- (IBAction)zFarDidChanged:(UISlider *)sender;
- (IBAction)zNearDidChanged:(UISlider *)sender;


//Rotation
- (IBAction)rotationXDidChanged:(UISlider *)sender;
- (IBAction)rotationYDidChanged:(UISlider *)sender;
- (IBAction)rotationZDidChanged:(UISlider *)sender;
- (IBAction)rotationWDidChanged:(UISlider *)sender;


//Scale
- (IBAction)scaleXDidChanged:(UISlider *)sender;
- (IBAction)scaleYDidChanged:(UISlider *)sender;
- (IBAction)scaleZDidChanged:(UISlider *)sender;


//Euler Angles
- (IBAction)eulerAnglesXDidChanged:(UISlider *)sender;
- (IBAction)eulerAnglesYDidChanged:(UISlider *)sender;
- (IBAction)eulerAnglesZDidChanged:(UISlider *)sender;

//Position
- (IBAction)positionXDidChanged:(UISlider *)sender;
- (IBAction)positionYDidChanged:(UISlider *)sender;
- (IBAction)positionZDidChanged:(UISlider *)sender;

@end

@implementation ToolsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)positionXDidChanged:(UISlider *)sender {
    [_delegate positionXDidChanged:sender.value];
}

- (IBAction)positionYDidChanged:(UISlider *)sender{
    [_delegate positionYDidChanged:sender.value];
}

- (IBAction)positionZDidChanged:(UISlider *)sender{
    [_delegate positionZDidChanged:sender.value];
}

- (IBAction)eulerAnglesXDidChanged:(UISlider *)sender {
    [_delegate eulerAnglesXDidChanged:sender.value];
}

- (IBAction)eulerAnglesYDidChanged:(UISlider *)sender {
    [_delegate eulerAnglesYDidChanged:sender.value];
}

- (IBAction)eulerAnglesZDidChanged:(UISlider *)sender {
    [_delegate eulerAnglesZDidChanged:sender.value];
}

- (IBAction)scaleXDidChanged:(UISlider *)sender {
    [_delegate scaleXDidChanged:sender.value];
}

- (IBAction)scaleYDidChanged:(UISlider *)sender {
    [_delegate scaleYDidChanged:sender.value];
}

- (IBAction)scaleZDidChanged:(UISlider *)sender {
    [_delegate scaleZDidChanged:sender.value];
}

- (IBAction)rotationXDidChanged:(UISlider *)sender {
    [_delegate rotationXDidChanged:sender.value];
}

- (IBAction)rotationYDidChanged:(UISlider *)sender {
    [_delegate rotationYDidChanged:sender.value];
}

- (IBAction)rotationZDidChanged:(UISlider *)sender {
    [_delegate rotationZDidChanged:sender.value];
}

- (IBAction)rotationWDidChanged:(UISlider *)sender {
    [_delegate rotationWDidChanged:sender.value];
}

- (IBAction)zFarDidChanged:(UISlider *)sender {
    [_delegate zFarDidChanged:sender.value];
}

- (IBAction)zNearDidChanged:(UISlider *)sender {
    [_delegate zNearDidChanged:sender.value];
}
@end
