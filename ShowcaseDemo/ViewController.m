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
    SCNNode *redBall = [scene.rootNode childNodeWithName:@"red" recursively:NO];
    redBall.physicsBody.damping = 0.0;
    redBall.physicsBody.categoryBitMask = SCNPhysicsCollisionCategoryDefault;
    self.scnView.scene = scene;
    self.scnView.autoenablesDefaultLighting = YES;
    
    
    [redBall.physicsBody applyForce:SCNVector3Make(3, 10, 0) impulse:YES];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(2);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [redBall.physicsBody applyForce:SCNVector3Make(-100, 0, 0) impulse:YES];
//        });
//    });
}

//#pragma mark SCNPhysicsContactDelegate
//- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact{
//    //开始碰撞
//    NSLog(@"%s",__func__);
//}
//- (void)physicsWorld:(SCNPhysicsWorld *)world didUpdateContact:(SCNPhysicsContact *)contact{
//    NSLog(@"%s",__func__);
//    //得到两个碰撞的node
//    SCNNode *nodeA = contact.nodeA;
//    SCNNode *nodeB = contact.nodeB;
//    //  SCNVector3 contactPoint = contact.contactPoint;
//    //碰撞点
//    if(nodeA.physicsBody.categoryBitMask == BitMaskRedBall)                      {
//        // 做一些事情
//    }
//}
//
//- (void)physicsWorld:(SCNPhysicsWorld *)world didEndContact:(SCNPhysicsContact *)contact{
//    //结束碰撞
//    NSLog(@"%s",__func__);
//}
@end
