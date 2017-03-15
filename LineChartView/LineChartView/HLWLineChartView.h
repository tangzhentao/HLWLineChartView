//
//  HLWLineChartView.h
//  LineChartView
//
//  Created by tang on 2017/3/15.
//  Copyright © 2017年 tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLWLineChartView : UIView

@property (assign, nonatomic) CGPoint chartOrigin; // 图表原点在视图中的位置，默认为[40, 40]
@property (assign, nonatomic) CGFloat xUnit; // x轴每刻度的点数, 默认为100
@property (assign, nonatomic) CGFloat yUnit; // y轴每刻度的点数, 默认为100

/*数据点 结构如下：
 * @[
 *  @{@"x" : @10, @"y" : @10},
 *  @{@"x" : @20, @"y" : @30},
 * ]
 */
@property (strong, nonatomic) NSMutableArray *dataPoints;

- (void)draw;

@end
