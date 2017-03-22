//
//  LineChartViewController.h
//  LineChartView
//
//  Created by tang on 2017/3/22.
//  Copyright © 2017年 tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *dataPoints;
@property (assign, nonatomic) BOOL hideNodes;

@property (strong, nonatomic) UIColor *lineColor; // 线的颜色
@property (strong, nonatomic) UIColor *nodeColor; // 节点的颜色


@end
