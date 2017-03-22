//
//  ViewController.m
//  LineChartView
//
//  Created by tang on 2017/3/15.
//  Copyright © 2017年 tang. All rights reserved.
//

#import "ViewController.h"
#import "HLWLineChartView.h"

@interface ViewController ()

@property (strong, nonatomic) HLWLineChartView * lineChartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // addd lineChartView
    [self addLineChartView];
    _lineChartView.backgroundColor = [UIColor grayColor];
    
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:@{@"x" : @0, @"y" : @0}];
    [points addObject:@{@"x" : @40, @"y" : @20}];
    [points addObject:@{@"x" : @80, @"y" : @60}];
    [points addObject:@{@"x" : @120, @"y" : @120}];
    [points addObject:@{@"x" : @200, @"y" : @120}];
    
    _lineChartView.dataPoints = points;
    [_lineChartView draw];
    
}

- (void)addLineChartView
{
    CGRect frame = self.view.bounds;
    NSLog(@"frame: %@", NSStringFromCGRect(frame));
    frame.origin = CGPointMake(0, 64);
    frame.size = CGSizeMake(frame.size.width, frame.size.height - 64);
    NSLog(@"frame: %@", NSStringFromCGRect(frame));

    _lineChartView = [[HLWLineChartView alloc] initWithFrame:frame];
    _lineChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_lineChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
