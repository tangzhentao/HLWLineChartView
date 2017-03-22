//
//  LineChartViewController.m
//  LineChartView
//
//  Created by tang on 2017/3/22.
//  Copyright © 2017年 tang. All rights reserved.
//

#import "LineChartViewController.h"
#import "HLWLineChartView.h"

@interface LineChartViewController ()

@property (strong, nonatomic) HLWLineChartView * lineChartView;

@end

@implementation LineChartViewController

-(HLWLineChartView *)lineChartView
{
    if (!_lineChartView) {
        _lineChartView = [HLWLineChartView new];
    }
    
    return _lineChartView;
}

-(void)setDataPoints:(NSMutableArray *)dataPoints
{
    if (_dataPoints != dataPoints) {
        _dataPoints = dataPoints;
        self.lineChartView.dataPoints = _dataPoints;
    }
}

-(void)setLineColor:(UIColor *)lineColor
{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        self.lineChartView.lineColor = _lineColor;
    }
}

-(void)setNodeColor:(UIColor *)nodeColor
{
    if (_nodeColor != nodeColor) {
        _nodeColor = nodeColor;
        self.lineChartView.nodeColor = _nodeColor;
    }
}

-(void)setHideNodes:(BOOL)hideNodes
{
    _hideNodes = hideNodes;
    self.lineChartView.hideNodes = _hideNodes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    // addd lineChartView
    [self addLineChartView];
    
    [self.lineChartView draw];
}

- (void)addLineChartView
{
    CGRect frame = self.view.bounds;
    NSLog(@"frame: %@", NSStringFromCGRect(frame));
    frame.origin = CGPointMake(0, 64);
    frame.size = CGSizeMake(frame.size.width, frame.size.height - 64);
    NSLog(@"frame: %@", NSStringFromCGRect(frame));
    
    self.lineChartView.frame = frame;
    self.lineChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
