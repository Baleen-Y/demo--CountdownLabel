//
//  BYCountdownLabel.h
//  限时抢购
//
//  Created by Baleen.Y on 10/22/16.
//  Copyright © 2016 Baleen.Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYCountdownLabel : UILabel

/**根据目标时间计算跟服务器的差值*/
- (void)setupCountDownWithTargetTime:(NSDate *)targetTime;

@end
