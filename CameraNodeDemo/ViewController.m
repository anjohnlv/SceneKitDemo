//
//  ViewController.m
//  CameraNodeDemo
//
//  Created by anjohnlv on 2017/9/25.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import "ToolsTableViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()<ToolsDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet SCNView *scnView;

@property(nonatomic, strong)SCNNode *cameraNode,*shipNode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeScene];
    [self makeToolsView];
}

#pragma mark - 初始化Scene
-(void)makeScene {
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    //创建相机
    _cameraNode = [SCNNode node];
    _cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:_cameraNode];
    _cameraNode.position = SCNVector3Make(0, 0, 15);
    //设置光线
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];

    _scnView.scene = scene;
    _scnView.allowsCameraControl = YES;
    _scnView.backgroundColor = [UIColor lightGrayColor];
    
    _shipNode = [scene.rootNode childNodeWithName:@"ship" recursively:YES];
}

#pragma mark - 创建工具栏
-(void)makeToolsView {
    ToolsTableViewController *viewController = (ToolsTableViewController *)self.childViewControllers[0];
    viewController.delegate = self;
}

#pragma mark - Position
-(void)positionXDidChanged:(CGFloat)value {
    SCNVector3 position = _cameraNode.position;
    position.x = value;
    _cameraNode.position = position;
    [self updateProperty:[self stringWithVector3:position]];
}
-(void)positionYDidChanged:(CGFloat)value {
    SCNVector3 position = _cameraNode.position;
    position.y = value;
    _cameraNode.position = position;
    [self updateProperty:[self stringWithVector3:position]];
}
-(void)positionZDidChanged:(CGFloat)value {
    SCNVector3 position = _cameraNode.position;
    position.z = value;
    _cameraNode.position = position;
    [self updateProperty:[self stringWithVector3:position]];
}

#pragma mark - Euler Angles
-(void)eulerAnglesXDidChanged:(CGFloat)value {
    SCNVector3 eulerAngles = _cameraNode.eulerAngles;
    eulerAngles.x = value;
    _cameraNode.eulerAngles = eulerAngles;
    [self updateProperty:[self stringWithVector3:eulerAngles]];
}

-(void)eulerAnglesYDidChanged:(CGFloat)value {
    SCNVector3 eulerAngles = _cameraNode.eulerAngles;
    eulerAngles.y = value;
    _cameraNode.eulerAngles = eulerAngles;
    [self updateProperty:[self stringWithVector3:eulerAngles]];
}

-(void)eulerAnglesZDidChanged:(CGFloat)value {
    SCNVector3 eulerAngles = _cameraNode.eulerAngles;
    eulerAngles.z = value;
    _cameraNode.eulerAngles = eulerAngles;
    [self updateProperty:[self stringWithVector3:eulerAngles]];
}

#pragma mark - Scale
-(void)scaleXDidChanged:(CGFloat)value {
    SCNVector3 scale = _cameraNode.scale;
    scale.x = value;
    _cameraNode.scale = scale;
    [self updateProperty:[self stringWithVector3:scale]];
}

-(void)scaleYDidChanged:(CGFloat)value {
    SCNVector3 scale = _cameraNode.scale;
    scale.y = value;
    _cameraNode.scale = scale;
    [self updateProperty:[self stringWithVector3:scale]];
}

-(void)scaleZDidChanged:(CGFloat)value {
    SCNVector3 scale = _cameraNode.scale;
    scale.z = value;
    _cameraNode.scale = scale;
    [self updateProperty:[self stringWithVector3:scale]];
}

#pragma mark - Rotation
-(void)rotationXDidChanged:(CGFloat)value {
    SCNVector4 rotation = _shipNode.rotation;
    rotation.x = value;
    _shipNode.rotation = rotation;
    [self updateProperty:[self stringWithVector4:rotation]];
}

-(void)rotationYDidChanged:(CGFloat)value {
    SCNVector4 rotation = _shipNode.rotation;
    rotation.y = value;
    _shipNode.rotation = rotation;
    [self updateProperty:[self stringWithVector4:rotation]];
}

-(void)rotationZDidChanged:(CGFloat)value {
    SCNVector4 rotation = _shipNode.rotation;
    rotation.z = value;
    _shipNode.rotation = rotation;
    [self updateProperty:[self stringWithVector4:rotation]];
}

-(void)rotationWDidChanged:(CGFloat)value {
    SCNVector4 rotation = _shipNode.rotation;
    rotation.w = value;
    _shipNode.rotation = rotation;
    [self updateProperty:[self stringWithVector4:rotation]];
}

#pragma mark - Z
-(void)zFarDidChanged:(CGFloat)value {
    _cameraNode.camera.zFar = value;
    [self updateProperty:@(value).stringValue];
}

-(void)zNearDidChanged:(CGFloat)value {
    _cameraNode.camera.zNear = value;
    [self updateProperty:@(value).stringValue];
}

-(NSString *)stringWithVector3:(SCNVector3)vector3 {
    NSString *string = [NSString stringWithFormat:@"x:%f\ny:%f\nz:%f",vector3.x,vector3.y,vector3.z];
    return string;
}

-(NSString *)stringWithVector4:(SCNVector4)vector4 {
    NSString *string = [NSString stringWithFormat:@"x:%f\ny:%f\nz:%f\nw:%f",vector4.x,vector4.y,vector4.z,vector4.w];
    return string;
}

-(void)updateProperty:(NSString *)string {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideProperty) object:nil];
    _label.alpha = 1.f;
    [_label setText:string];
    [self performSelector:@selector(hideProperty) withObject:nil afterDelay:1];
}

-(void)hideProperty {
    [UIView animateWithDuration:2.0 animations:^(void){
        _label.alpha = 0.f;
    }];
}

@end
