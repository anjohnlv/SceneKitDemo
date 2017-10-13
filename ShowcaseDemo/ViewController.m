//
//  ViewController.m
//  ShowcaseDemo
//
//  Created by anjohnlv on 2017/10/9.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()<SCNPhysicsContactDelegate>
@property (strong, nonatomic) IBOutlet SCNView *scnView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/showcase.scn"];
    self.scnView.scene = scene;
    self.scnView.autoenablesDefaultLighting = YES;
}
@end
