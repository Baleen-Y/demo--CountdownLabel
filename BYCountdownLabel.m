//
//  BYCountdownLabel.m
//  限时抢购
//
//  Created by Baleen.Y on 10/22/16.
//  Copyright © 2016 Baleen.Y. All rights reserved.
//

#import "BYCountdownLabel.h"

@interface BYCountdownLabel ()

/**时间定时器,用weak可以在定时器销毁之后指针自动置为nil*/
@property (nonatomic, weak) NSTimer *timer;
/**天数*/
@property (nonatomic, assign) NSUInteger day;
/**小时数*/
@property (nonatomic, assign) NSUInteger hour;
/**分钟数*/
@property (nonatomic, assign) NSUInteger minute;
/**秒数*/
@property (nonatomic, assign) NSUInteger second;

@end
@implementation BYCountdownLabel

- (void)setupCountDownWithTargetTime:(NSDate *)targetTime {
    
    // 计算目标时间和当前服务器时间的时间差
    NSTimeInterval interval = [targetTime timeIntervalSinceDate:[NSDate date]];
    // 根据时间差的秒数计算天,小时,分钟,秒(暂时不考虑月和年,月和年的倒计时用的很少)
    [self calculateTime:(NSInteger)interval];
    
}

/**计算时间方法*/
- (void)calculateTime:(NSInteger)interval {
    
    // 天
    self.day = interval/86400; // 一天 == 86400 == 24*60*60秒
    // 小时
    self.hour = interval%86400/3600;
    // 分钟
    self.minute = interval%3600/60;
    // 秒
    self.second = interval%60;
    // 赋值到label上
    self.text = [NSString stringWithFormat:@"%02zd天%02zd:%02zd:%02zd",
                 self.day, self.hour, self.minute, self.second];
    // 一秒钟后调用减一秒方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDecrease) userInfo:nil repeats:YES];
    
}

/**时间减一秒方法*/
- (void)timeDecrease {
    
    // 减一秒
    self.second--;
    // 判断秒数
    if (self.second == -1) {
        self.second = 59;
        // 分钟减一
        self.minute--;
    }
    // 判断分钟数
    if (self.minute == -1) {
        self.minute = 59;
        // 小时减1
        self.hour--;
    }
    // 判断小时数
    if (self.hour == -1) {
        self.hour = 23;
        // 天数减1
        self.day--;
    }
    // 判断是否没时间了
    if (self.day == 0 &&
        self.hour == 0 &&
        self.minute == 0 &&
        self.second == 0) {
        [self.timer invalidate];
    }
    // 赋值
    self.text = [NSString stringWithFormat:@"%02zd天%02zd:%02zd:%02zd",
                 self.day, self.hour, self.minute, self.second];
    
}

@end
