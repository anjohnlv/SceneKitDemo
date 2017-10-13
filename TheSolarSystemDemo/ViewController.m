//
//  ViewController.m
//  TheSolarSystemDemo
//
//  Created by anjohnlv on 2017/9/21.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建场景
    SCNView *universeView = [self makeScene];
    //创建太阳
    SCNNode *sunNode = [self makeSun];
    [universeView.scene.rootNode addChildNode:sunNode];
    //太阳自转
    [self rotation:sunNode];
    //创建地球
    SCNNode *earthNode = [self makeEarth];
    //地球自转
    [self rotation:earthNode];
    //地球公转
    [sunNode addChildNode:earthNode];
    //添加月亮
    SCNNode *moonNode = [self makeMoon];
    //月亮自转
    [self rotation:moonNode];
    //月亮公转
    [earthNode addChildNode:moonNode];
}

#pragma mark - 初始化Scene
-(SCNView *)makeScene {
    //创建SCNView
    SCNView *universeView = [[SCNView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:universeView];
    [universeView setBackgroundColor:[UIColor darkGrayColor]];
    //创建SCNScene
    SCNScene *scene = [SCNScene new];
    universeView.scene = scene;
    //创建cameraNode（用于调整镜头，必须添加camera，否则添加的node总是会适应scene的大小，无法观测调整大小效果）
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    cameraNode.position = SCNVector3Make(0, 0,250);
    cameraNode.camera.zFar = 2000;
    return universeView;
}

#pragma mark - 初始化Sun
-(SCNNode *)makeSun {
    //创建太阳
    SCNNode *sunNode = [SCNNode new];
    SCNSphere *sphere = [SCNSphere sphereWithRadius:40];
    sphere.firstMaterial.diffuse.contents = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.8];
    sunNode.geometry = sphere;
    //把太阳设置为发光源
    sunNode.geometry.firstMaterial.lightingModelName = SCNLightingModelConstant;
    SCNNode *omniLightNode = [SCNNode node];
    omniLightNode.light = [SCNLight light];
    omniLightNode.light.type = SCNLightTypeOmni;
    omniLightNode.light.color = [UIColor whiteColor];
    [sunNode addChildNode:omniLightNode];
    //给他一个Title
    SCNNode *textNode = [SCNNode new];
    SCNText *text = [SCNText textWithString:@"太阳" extrusionDepth:2];
    text.font = [UIFont systemFontOfSize:32];
    text.firstMaterial.diffuse.contents = [UIColor whiteColor];
    textNode.geometry = text;
    [sunNode addChildNode:textNode];
    [self recenterText:textNode];
    return sunNode;
}

#pragma mark - 初始化Earth
-(SCNNode *)makeEarth {
    SCNNode *earthNode = [SCNNode new];
    SCNSphere *sphere = [SCNSphere sphereWithRadius:10];
    sphere.firstMaterial.diffuse.contents = [UIColor colorWithRed:0.0 green:0 blue:1 alpha:0.8];
    earthNode.geometry = sphere;
    SCNNode *textNode = [SCNNode new];
    SCNText *text = [SCNText textWithString:@"地球" extrusionDepth:2];
    text.font = [UIFont systemFontOfSize:8];
    text.firstMaterial.diffuse.contents = [UIColor whiteColor];
    textNode.geometry = text;
    [earthNode addChildNode:textNode];
    [self recenterText:textNode];
    //设置距原点的距离
    earthNode.position = SCNVector3Make(120, 0, 0);
    return earthNode;
}

#pragma mark - 初始化Moon
-(SCNNode *)makeMoon {
    SCNNode *monnNode = [SCNNode new];
    SCNSphere *sphere = [SCNSphere sphereWithRadius:5];
    sphere.firstMaterial.diffuse.contents = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.8];
    monnNode.geometry = sphere;
    SCNNode *textNode = [SCNNode new];
    SCNText *text = [SCNText textWithString:@"月亮" extrusionDepth:2];
    text.font = [UIFont systemFontOfSize:4];
    text.firstMaterial.diffuse.contents = [UIColor whiteColor];
    textNode.geometry = text;
    [monnNode addChildNode:textNode];
    [self recenterText:textNode];
    monnNode.position = SCNVector3Make(20, 0, 0);
    return monnNode;
}

#pragma mark - 自转
-(void)rotation:(SCNNode *)node {
    SCNAction *customAction = [SCNAction rotateByX:0 y:1 z:0 duration:1];
    SCNAction *repeatAction = [SCNAction repeatActionForever:customAction];
    [node runAction:repeatAction];
}

- (void)recenterText:(SCNNode *)node {
    SCNText *sceneText = (SCNText *)node.geometry;
    SCNVector3 min = SCNVector3Zero;
    SCNVector3 max = SCNVector3Zero;
    [sceneText getBoundingBoxMin:&min max:&max];
    sceneText.alignmentMode = kCAAlignmentCenter;
    CGFloat textHeight = max.y - min.y;
    CGFloat textWidth = max.x - min.x;
    SCNVector3 position = SCNVector3Make(-textWidth / 2 , -textHeight /3*2 , 0);
    node.position = position;
}

@end

