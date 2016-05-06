//
//  ViewController.m
//  DBSphereTagCloud
//
//  Created by Xinbao Dong on 14/9/1.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

#import "ViewController.h"
#import "DBSphereView.h"

@interface ViewController ()

@property (nonatomic, retain) DBSphereView *sphereView;

@end

@implementation ViewController

@synthesize sphereView;
            
- (void)viewDidLoad {
    [super viewDidLoad];
    sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 30; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        /** 按钮字体*/
        [btn setTitle:[NSString stringWithFormat:@"我擦%ld",i] forState:UIControlStateNormal];
        /**字体颜色*/
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        /** 修改字体大小*/
        btn.titleLabel.font = [UIFont systemFontOfSize:12.];
        /**修改按钮位置大小*/
        btn.frame = CGRectMake(0, 0, 60, 30);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [sphereView addSubview:btn];
    }
    [sphereView setCloudTags:array];
    sphereView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sphereView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonPressed:(UIButton *)btn
{
    [sphereView timerStop];
     
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [sphereView timerStart];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
