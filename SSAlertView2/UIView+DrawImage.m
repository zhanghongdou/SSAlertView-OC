//
//  UIView+DrawImage.m
//  SSAlertView
//
//  Created by 爱利是 on 16/8/3.
//  Copyright © 2016年 爱利是. All rights reserved.
//

#import "UIView+DrawImage.h"
#define drawRectImageWidth 60
#define SUCCESS_COLOR [UIColor colorWithRed:126/255.0 green:216/255.0 blue:33/255.0 alpha:1]
#define WARNING_COLOR [UIColor colorWithRed:245/255.0 green:166/255.0 blue:35/255.0 alpha:1]
#define ERROR_COLOR [UIColor colorWithRed:208/255.0 green:2/255.0 blue:27/255.0 alpha:1]
@implementation UIView (DrawImage)
//正确之绘图
-(void)ss_drawCheckMark
{
    [self cleanAllSublayer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth / 2) radius:drawRectImageWidth / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineCapRound;
    [bezierPath moveToPoint:CGPointMake(drawRectImageWidth / 4, drawRectImageWidth / 2)];
    [bezierPath addLineToPoint:CGPointMake(drawRectImageWidth / 4 + 10, drawRectImageWidth / 2 + 10)];
    [bezierPath addLineToPoint:CGPointMake(drawRectImageWidth / 4 * 3, drawRectImageWidth / 4)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = SUCCESS_COLOR.CGColor;
    layer.lineWidth = 5;
    layer.path = bezierPath.CGPath;
    [self.layer addSublayer:layer];
}
//警告之绘图
-(void)ss_drawWarning
{
    [self cleanAllSublayer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth / 2) radius:drawRectImageWidth / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineCapRound;
    [bezierPath moveToPoint:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth / 6)];
    [bezierPath addLineToPoint:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth / 6 * 3.8)];
    [bezierPath moveToPoint:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth / 6 * 4.5)];
    [bezierPath addArcWithCenter:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth / 6 * 4.5) radius:2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = WARNING_COLOR.CGColor;
    layer.lineWidth = 5;
    layer.path = bezierPath.CGPath;
    [self.layer addSublayer:layer];
}
//错误之绘图
-(void)ss_drawError
{
    [self cleanAllSublayer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(drawRectImageWidth / 2, drawRectImageWidth  / 2) radius:drawRectImageWidth / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [bezierPath moveToPoint:CGPointMake(drawRectImageWidth / 4, drawRectImageWidth / 4)];
    [bezierPath addLineToPoint:CGPointMake(drawRectImageWidth / 4 * 3, drawRectImageWidth / 4 * 3)];
    [bezierPath moveToPoint:CGPointMake(drawRectImageWidth / 4 * 3, drawRectImageWidth / 4)];
    [bezierPath addLineToPoint:CGPointMake(drawRectImageWidth / 4, drawRectImageWidth / 4 * 3)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = ERROR_COLOR.CGColor;
    layer.lineWidth = 5;
    layer.path = bezierPath.CGPath;
    [self.layer addSublayer:layer];
}

//View复用的时候删除上面附加的字layer
-(void)cleanAllSublayer
{
    for (CAShapeLayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
