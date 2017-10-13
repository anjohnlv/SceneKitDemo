//
//  ViewController.m
//  HelloSceneKit
//
//  Created by anjohnlv on 2017/9/21.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property(strong,nonatomic)SCNView *scnView;
@property(strong,nonatomic)SCNNode *node;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeScene];
    [self makeSun];
    [self rotation];
}

#pragma mark - 初始化Scene
-(void)makeScene {
    _scnView = [[SCNView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:_scnView];
    _scnView.center = self.view.center;
    [_scnView setBackgroundColor:[UIColor lightGrayColor]];
    //设置场景
    SCNScene *scene = [SCNScene new];
    _scnView.scene = scene;
}

#pragma mark - 初始化Node
-(void)makeSun {
    //创建节点
    _node = [SCNNode new];
    [_scnView.scene.rootNode addChildNode:_node];
    //设置节点形状
    SCNText *text = [SCNText textWithString:@"Hello World" extrusionDepth:0.5];//extrusionDepth厚度
    text.font = [UIFont systemFontOfSize:1];
    _node.geometry = text;
    //初始化光线（不是在目标上直接设置而是新建节点来作为光源）
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [_scnView.scene.rootNode addChildNode:lightNode];
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [_scnView.scene.rootNode addChildNode:ambientLightNode];
    //初始化虚拟相机（主要是调整镜头）
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [_scnView.scene.rootNode addChildNode:cameraNode];
    _scnView.allowsCameraControl = YES;
    cameraNode.position = SCNVector3Make(0, 1, 12);
}

#pragma mark - 旋转
-(void)rotation {
    SCNAction *customAction = [SCNAction rotateByX:0 y:1 z:0 duration:1];//沿y轴旋转
    SCNAction *repeatAction = [SCNAction repeatActionForever:customAction];
    [_node runAction:repeatAction];
}

@end
