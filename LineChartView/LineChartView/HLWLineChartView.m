//
//  HLWLineChartView.m
//  LineChartView
//
//  Created by tang on 2017/3/15.
//  Copyright © 2017年 tang. All rights reserved.
//

#import "HLWLineChartView.h"

@interface HLWLineChartView () <CAAnimationDelegate>
{
    CGPoint _chartOrigin; // 图表原点在视图中的位置，默认为[40, 40]
}

@property (assign, nonatomic) CGPoint xAxisEnd; // x轴终点
@property (assign, nonatomic) CGPoint yAxisEnd; // y轴终点
@property (assign, nonatomic) CGFloat scaleLineLength; // 刻度线长度，默认为10

@property (strong, nonatomic) CAShapeLayer *nodesLayer; //
@property (strong, nonatomic) CAShapeLayer *linesLayer; //



@end

@implementation HLWLineChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
}

-(CGPoint)chartOrigin
{
    if (CGPointEqualToPoint(_chartOrigin, CGPointZero)) {
        _chartOrigin = CGPointMake(40, 40);
    }
    
    return _chartOrigin;
}

- (void)setChartOrigin:(CGPoint)chartOrigin
{
    _chartOrigin = chartOrigin;
}

-(CGPoint)xAxisEnd
{
    if (CGPointEqualToPoint(_xAxisEnd, CGPointZero)) {
        _xAxisEnd = CGPointMake(CGRectGetWidth(self.frame) - 40, _chartOrigin.y);
    }
    
    return _xAxisEnd;
}

-(CGPoint)yAxisEnd
{
    if (CGPointEqualToPoint(_yAxisEnd, CGPointZero)) {
        _yAxisEnd = CGPointMake(_chartOrigin.x, CGRectGetHeight(self.frame) - 40);
    }
    
    return _yAxisEnd;
}

#pragma mark - ---------- 
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self drawLines];
}

- (void)draw
{
    [self drawNodes];
}

- (void)drawNodes
{
    // 根据点集画线
    UIBezierPath * linePath = [[UIBezierPath alloc] init];
    NSUInteger numPoints = self.dataPoints.count;
    
    // 根据点集画节点
    for (int i = 1; i < numPoints; i++) {
        NSDictionary *pointInfo = self.dataPoints[i];
        CGPoint point = CGPointMake([pointInfo[@"x"] floatValue] + self.chartOrigin.x, [pointInfo[@"y"] floatValue] + self.chartOrigin.y);
//        CGPoint point = CGPointMake([pointInfo[@"x"] floatValue], [pointInfo[@"y"] floatValue]);

        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:point radius:2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        [linePath appendPath:path];
        
    }
    
    _nodesLayer = [CAShapeLayer layer];
    CGAffineTransform t = CGAffineTransformMakeScale(1, -1);
    _nodesLayer.affineTransform = CGAffineTransformTranslate(t, 0, -CGRectGetHeight(self.frame));
    _nodesLayer.path = linePath.CGPath;
    // 线的颜色
    _nodesLayer.strokeColor = [UIColor orangeColor].CGColor;
    _nodesLayer.fillColor = [[UIColor clearColor] CGColor];
    _nodesLayer.lineCap = kCALineCapRound;
    _nodesLayer.lineJoin = kCALineJoinRound;
    // 节点的图层显示在线段图层的上面
    _nodesLayer.zPosition = 1;

    //直接添加导视图上
    [self.layer addSublayer: _nodesLayer];
    
    _nodesLayer.lineWidth = 4;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4.0;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = self;
    [_nodesLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)drawLines
{
    // 根据点集画线
    UIBezierPath * linePath = [[UIBezierPath alloc] init];
    NSUInteger numPoints = self.dataPoints.count;
    for (int i = 0; i < numPoints; i++) {
        NSDictionary *pointInfo = self.dataPoints[i];
        CGPoint point = CGPointMake([pointInfo[@"x"] floatValue] + _chartOrigin.x, [pointInfo[@"y"] floatValue] + _chartOrigin.y);
        // 起点
        if (0 == i) {
            [linePath moveToPoint:point];
        } else {
            [linePath addLineToPoint:point];
        }
    }
    
    _linesLayer = [CAShapeLayer layer];
    CGAffineTransform t = CGAffineTransformMakeScale(1, -1);
    _linesLayer.affineTransform = CGAffineTransformTranslate(t, 0, -CGRectGetHeight(self.frame));
    _linesLayer.path = linePath.CGPath;
    //线的颜色
    _linesLayer.strokeColor = [UIColor greenColor].CGColor;
    _linesLayer.fillColor = [[UIColor clearColor] CGColor];
    _linesLayer.lineCap = kCALineCapRound;
    _linesLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer: _linesLayer];//直接添加导视图上
    
    _linesLayer.lineWidth = 2;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4.0;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
//    pathAnimation.delegate = self;
    [_linesLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 保存当前图形上下文
    CGContextSaveGState(context);
    
    // 翻转坐标系
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -CGRectGetHeight(rect));
    
    // 画坐标系
    [self drawCoordinate];
    
    // 恢复原来的图形上下文
    CGContextRestoreGState(context);
    
}

// 画坐标系
- (void)drawCoordinate
{
    // x 轴
    UIBezierPath *xAxisPahth = [UIBezierPath bezierPath];
    [xAxisPahth moveToPoint:self.chartOrigin];
    [xAxisPahth addLineToPoint:self.xAxisEnd];
    [xAxisPahth stroke];
    // x 轴箭头
    [self drawArrowWithPoint:self.xAxisEnd];
    // y 轴
    UIBezierPath *yAxisPahth = [UIBezierPath bezierPath];
    [yAxisPahth moveToPoint:self.chartOrigin];
    [yAxisPahth addLineToPoint:self.yAxisEnd];
    [yAxisPahth stroke];
    // y 轴箭头
    [self drawArrowWithPoint:self.yAxisEnd];
}

- (void)drawArrowWithPoint:(CGPoint)point
{
    // 定义三角形的三个点
    CGPoint p1 = point;
    CGPoint p2 = point;
    CGPoint p3 = point;
    
    if (point.x > point.y) {
        // x 轴
        p1.y += 3;
        p2.y -= 3;
        p3.x += 8;
    } else {
        // y 轴
        p1.x += 3;
        p2.x -= 3;
        p3.y += 8;
    }
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:p1];
    [arrowPath addLineToPoint:p2];
    [arrowPath addLineToPoint:p3];
    [arrowPath closePath];
    [arrowPath fill];
}

@end
