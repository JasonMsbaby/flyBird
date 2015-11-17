//
//  GameController.m
//  flyBird
//
//  Created by Jason_Msbaby on 15/10/24.
//  Copyright © 2015年 张杰. All rights reserved.
//

#import "GameController.h"

@interface GameController ()
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,strong) UIImageView *bird;
@property(nonatomic,strong) UIImageView *top;
@property(nonatomic,strong) UIImageView *bottom;
@property(nonatomic,strong) UIImageView *top2;
@property(nonatomic,strong) UIImageView *bottom2;
@property(nonatomic,strong) UIImageView *bottomImg;
@property(nonatomic,strong) UIImageView *bgImg;
@property(nonatomic,strong) UILabel *score;


@property(nonatomic,strong) NSTimer *timer;

@end

@implementation GameController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initSubViews];
}
#pragma mark - init
/**
 *  初始化数据
 */
- (void)initData{
    self.width = self.view.bounds.size.width;
    self.height = self.view.bounds.size.height;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}
/**
 *  初始化子视图
 */
- (void)initSubViews{
    [self initBg];
    [self initScore];
    [self initZZ];
    [self initbird];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tap];
}
//初始化小鸟
- (void)initbird{
    self.bird = [[UIImageView alloc]initWithFrame:CGRectMake(50, 300, 35, 30)];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        NSString *name = [NSString stringWithFormat:@"bird%d",i];
        [arr addObject:[UIImage imageNamed:name]];
    }
    self.bird.animationImages = arr;
    self.bird.animationRepeatCount = 0;
    self.bird.animationDuration = 0.5;
    [self.bird startAnimating];
    [self.bgImg addSubview:self.bird];
}
//初始化背景
- (void)initBg{
    UIImage *bg = [UIImage imageNamed:@"02"];
    self.bgImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.bgImg.image = bg;
    [self.view addSubview:self.bgImg];
    UIImage *bottom = [UIImage imageNamed:@"03"];
    self.bottomImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height - 150, self.width+50, 150)];
    self.bottomImg.image = bottom;
    [self.bgImg addSubview:self.bottomImg];
}
//初始化柱子
- (void)initZZ{
    int random = arc4random()%10+1;
    CGFloat height = (self.height - 150 - 100)/10*random;
    self.top = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"04"]];
    self.bottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"05"]];
    self.top.frame =CGRectMake(self.width +50, 0, 50, height);
    self.bottom.frame = CGRectMake(self.width +50, self.top.bounds.size.height+100, 50, self.height - 100 - 150 - self.top.bounds.size.height);
    [self.bgImg addSubview:self.top];
    [self.bgImg addSubview:self.bottom];
    
    
    random = arc4random()%10+1;
    height = (self.height - 150 - 100)/10*random;
    self.top2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"04"]];
    self.bottom2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"05"]];
    self.top2.frame =CGRectMake(self.width + 300, 0, 50, height);
    self.bottom2.frame = CGRectMake(self.width + 300, self.top2.bounds.size.height+100, 50, self.height - 100 - 150 - self.top2.bounds.size.height);
    [self.bgImg addSubview:self.top2];
    [self.bgImg addSubview:self.bottom2];
}
#pragma mark - action
- (void)timerAction:(NSTimer*)timer{
    [self birdDown];
    [self bgAnimation];
    [self zzAnimation];
    
}
//底部背景动画
- (void)bgAnimation{
    CGRect fram = self.bottomImg.frame;
    if (fram.origin.x < -50) {
        fram.origin.x = 0;
    }
    fram.origin.x-=2;
    self.bottomImg.frame = fram;
    
    
}
//初始化计分
- (void)initScore{
    self.score = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 150)];
    self.score.font = [UIFont systemFontOfSize:400];
    self.score.textAlignment = NSTextAlignmentCenter;
    self.score.alpha = 0.5;
    self.score.text = @"0";
    [self.bgImg addSubview:self.score];
}
//柱子动画
- (void)zzAnimation{
    if (self.top.frame.origin.x == -50) {
        int random = arc4random()%10+1;
        CGFloat height = (self.height - 150 - 100)/10*random;
        self.top.frame =CGRectMake(self.width +50, 0, 50, height);
        self.bottom.frame = CGRectMake(self.width +50, height+100, 50, self.height - 100 - 150 - height);
    }
    if (self.top2.frame.origin.x == -50) {
        int random = arc4random()%10+1;
        CGFloat height = (self.height - 150 - 100)/10*random;
        self.top2.frame =CGRectMake(self.width +50, 0, 50, height);
        self.bottom2.frame = CGRectMake(self.width +50, height+100, 50, self.height - 100 - 150 - height);
    }
    
    [self isContinue];
    
    [UIImageView animateWithDuration:0.1 animations:^{
        CGRect frameTop = self.top.frame;
        frameTop.origin.x -= 5;
        self.top.frame = frameTop;
        CGRect frameBottom = self.bottom.frame;
        frameBottom.origin.x -= 5;
        self.bottom.frame = frameBottom;
        
        CGRect frameTop2 = self.top2.frame;
        frameTop2.origin.x -= 5;
        self.top2.frame = frameTop2;
        CGRect frameBottom2 = self.bottom2.frame;
        frameBottom2.origin.x -= 5;
        self.bottom2.frame = frameBottom2;
    }];
}

//条件判断
- (void)isContinue{
    CGFloat current = self.bird.frame.origin.y;
    static BOOL flag1 = YES;
    static BOOL flag2 = YES;
    if (self.top.frame.origin.x <= 50 && self.top.frame.origin.x > 0) {
        NSLog(@"%.2f",current);
        NSLog(@"%.2f -- %.2f",self.top.frame.size.height,self.bottom.frame.origin.y);
        if (!(current > self.top.frame.size.height && current+20 < self.bottom.frame.origin.y) ) {
            [self.timer invalidate];
        }
        if (flag1 == YES) {
            int score = [self.score.text intValue];
            NSString *txt_score = [NSString stringWithFormat:@"%d",++score];
            self.score.text = txt_score;
            flag1 = NO;
        }
    }else{
        flag1 = YES;
    }
    
    
    
    if (self.top2.frame.origin.x <= 50 && self.top2.frame.origin.x > 0) {
        if (!(current > self.top2.frame.size.height && current+20 < self.bottom.frame.origin.y)) {
            [self.timer invalidate];
        }
        if (flag2 == YES) {
            int score = [self.score.text intValue];
            NSString *txt_score = [NSString stringWithFormat:@"%d",++score];
            self.score.text = txt_score;
            flag2 = NO;
        }
    }else{
        flag2 = YES;
    }
}
//小鸟自动下落
- (void)birdDown{
    CGRect frame = self.bird.frame;
    frame.origin.y += 10;
    [UIImageView animateWithDuration:0.2 animations:^{
        self.bird.frame = frame;
    }];
}
//小鸟上升
- (void)birdUp{
    CGRect frame = self.bird.frame;
    frame.origin.y -= 50;
    [UIImageView animateWithDuration:0.2 animations:^{
        self.bird.frame = frame;
    }];
}
//轻拍手势
- (void)tapGesture:(UITapGestureRecognizer*)tap{
    [self birdUp];
}

#pragma mark - delegate

#pragma mark - other

@end
