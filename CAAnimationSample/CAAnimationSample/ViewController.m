//
//  ViewController.m
//  CAAnimationSample
//
//  Created by 黄嘉宏 on 16/4/18.
//  Copyright (c) 2016年 黄嘉宏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)CALayer * mainLayer;

@property (nonatomic,strong)CABasicAnimation *animationMove;

@property (nonatomic,strong)CABasicAnimation *animationRotation;

@property (nonatomic,strong)CABasicAnimation *animationScale;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CALayerTest];
    
//    //设置一个基础动画(平移)
//    [self setCABaseAnimation];
//    
//    //设置一个基础动画(旋转)
//    [self setCABaseAnimation2];
//    
//    //设置一个基础动画(大小改变的动画)
//    [self setCABaseAnimation3];
//    
//    //设定动画组
//    [self setGroupAnimation];
    
    //制作路径动画
    [self setAnimationKeyPath];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 制作一个CALayer
-(void)CALayerTest{
    
    self.mainLayer = [[CALayer alloc]init];
    
    self.mainLayer.frame = CGRectMake(150, 30, 50, 50);
    
    self.mainLayer.backgroundColor = [UIColor redColor].CGColor;
    
    self.mainLayer.cornerRadius = 25.0;
    
    //使用主view的layer去添加新的layer图层
    [self.view.layer addSublayer:self.mainLayer];
}

#pragma mark - 设置一个基础动画
-(void)setCABaseAnimation{
    
    //制作一个移动的动画
    self.animationMove = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //设定动画的起始点和终结点(获取layer图层的当前位置)
    CGPoint beginPoint = self.mainLayer.position;
    
    //设置他的起始点(起始点的类型为NSValue，需要让CGPoint转换到对应的类型中)
    self.animationMove.fromValue = [NSValue valueWithCGPoint:beginPoint];
    
    //让图层往右移动200的逻辑点
    beginPoint.x = beginPoint.x + 200;
    
    self.animationMove.toValue = [NSValue valueWithCGPoint:beginPoint];
    
    //设定动画的时间
    self.animationMove.duration = 3;
    
    //把动画加载到图层上
//    [self.mainLayer addAnimation:self.animationMove forKey:@""];
    
}

#pragma makr - 制作旋转动画
-(void)setCABaseAnimation2{
    
    self.animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    self.animationRotation.fromValue = [NSNumber numberWithFloat:0.0];
    
    //M_PI 为3.14的准确值
    self.animationRotation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    
    self.animationRotation.duration = 3;
    
//    [self.mainLayer addAnimation:self.animationRotation forKey:@""];
}

#pragma mark - 制作修改图层大小的动画
-(void)setCABaseAnimation3{
    
    self.animationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    self.animationScale.fromValue = [NSNumber numberWithFloat:1.0];
    
    self.animationScale.toValue = [NSNumber numberWithFloat:2.5];
    
    self.animationScale.duration = 3;
    
    //设置动画效果结束后停留在效果结束的位置上(默认为NO)
    self.animationScale.autoreverses = NO;
    
    //必须使用该属性，fileMode才可以有效果
    self.animationScale.removedOnCompletion = NO;
    
    self.animationScale.fillMode = kCAFillModeForwards;
    
//    [self.mainLayer addAnimation:self.animationScale forKey:@""];
    
    
}

#pragma mark - 制作动画组合
-(void)setGroupAnimation{
    //取出动画组合的单例
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    //添加动画数组
    group.animations = [NSArray arrayWithObjects:self.animationMove,self.animationRotation,self.animationScale, nil];
    
    group.duration = 3;
    
    //不停的循环动画
    group.repeatCount = NSNotFound;
    
    //使图片原路返回
    group.autoreverses = YES;
    
    group.removedOnCompletion = NO;
    
    group.fillMode = kCAFillModeForwards;
    
    //添加动画组合
    [self.mainLayer addAnimation:group forKey:@""];
    
}

#pragma mark - 制作下落球体的路径
-(void)setAnimationKeyPath{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    //动画类型
    animation.keyPath = @"position";
    
    //总时间
    animation.duration = 1;
    
    //主要关键点路径数组
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    
    //设定速率变化
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    
    //每个动画所占用的时间
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    
    //最终图层停留的位置
    self.mainLayer.position = CGPointMake(150, 268);
    
    [self.mainLayer addAnimation:animation forKey:@""];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
