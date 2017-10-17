//
//  ViewController.m
//  BowlingDemo
//
//  Created by anjohnlv on 2017/10/17.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIProgressView *powerProgressView;
@property (strong, nonatomic) IBOutlet SCNView *scnView;
@property (strong, nonatomic) SCNNode *bowlingBall;
@property (strong, nonatomic) IBOutlet UISlider *anglesSlider;
@property (strong, nonatomic) IBOutlet UISlider *rotatesSlider;
@property (nonatomic)CGFloat power;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCNScene *scene = [SCNScene sceneNamed:@"SceneKit Scene.scn"];
    self.scnView.scene = scene;
    self.scnView.autoenablesDefaultLighting = YES;
    _bowlingBall = [scene.rootNode childNodeWithName:@"bowling" recursively:NO];
    //为了观察球是滚动还是滑动，随便给球贴个图
    _bowlingBall.geometry.firstMaterial.diffuse.contents = [UIImage imageNamed:@"image"];
    [self powerChanging];
}

-(IBAction)positionDidChanged:(UISlider *)sender {
    SCNVector3 position = _bowlingBall.position;
    position.x = sender.value;
    _bowlingBall.position = position;
}

-(IBAction)throwing {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(powerChanging) object:nil];
    SCNVector3 force = SCNVector3Make(_anglesSlider.value*5, 0, -(15+_power*10));
    SCNVector3 postion = SCNVector3Make(_rotatesSlider.value, 0, 0);
    [_bowlingBall.physicsBody applyForce:force atPosition:postion impulse:YES];
}

-(void)powerChanging {
    if (self.powerProgressView.tag==1) {//递增
        _power += 0.1;
        if (_power>=1) {
            self.powerProgressView.tag=-1;
        }
    }else{//递减
        _power -= 0.1;
        if (_power<=0) {
            self.powerProgressView.tag=1;
        }
    }
    [self.powerProgressView setProgress:_power animated:YES];
    [self performSelector:@selector(powerChanging) withObject:nil afterDelay:0.1];
}

@end
