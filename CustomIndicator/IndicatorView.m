//
//  IndicatorView.m
//  CustomIndicator
//
//  Created by Pulkit Rohilla on 09/04/15.
//  Copyright (c) 2015 PulkitRohilla. All rights reserved.
//

#import "IndicatorView.h"

@implementation IndicatorView

IndicatorView *view;
CAAnimationGroup *anims;
CAShapeLayer *shape;
CALayer *backLayer;
UIView *backView;

+(void)addIndicatorOn:(UIViewController *)viewController{
    
    if (view==nil) {
        
        view = [[IndicatorView alloc] initWithFrame:viewController.view.bounds];
        backView = [[UIView alloc] initWithFrame:viewController.view.bounds];

        [view setFrame:CGRectMake(0 ,0 , 50, 50)];
        [backView setFrame:CGRectMake(0, 0, 50, 50)];
        
        view.center = viewController.view.center;
//
//        
//        [backView setBackgroundColor:[UIColor blackColor]];
//        
        [view setAlpha:0.7];
        
        shape = [CAShapeLayer layer];
        
        CGPoint center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:25 startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
        shape.path = path.CGPath;
        
        shape.lineWidth = 3;
        shape.strokeStart = 0;
        shape.strokeEnd = 0.9;

        
        shape.fillColor = [UIColor blackColor].CGColor;
        shape.strokeColor = [UIColor whiteColor].CGColor;
        [shape setOpacity:1];
//        [shape setShadowColor:[UIColor redColor].CGColor];
        [shape setShadowOffset:CGSizeMake(0, 0)];
        [shape setShadowOpacity:1];
        [shape setShadowRadius:5];
        
        [backView.layer addSublayer:shape];
        [view.layer setCornerRadius:10];
        
        UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 25, 25)];
        [closeButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        closeButton.center = center;
        [closeButton addTarget:self action:@selector(removeIndicator) forControlEvents:UIControlEventTouchUpInside];
        
        [self startAnimation];
        
        [view addSubview:backView];
        [view addSubview:closeButton];

        
        [viewController.view addSubview:view];

        
    }
    
}

+(void)startAnimation
{
    int newRadius = 50;
    
    UIBezierPath *newPath = [UIBezierPath bezierPathWithArcCenter:view.center radius:newRadius startAngle:0 endAngle:(2 * M_PI) clockwise:YES];

    CABasicAnimation* pathAnim = [CABasicAnimation animationWithKeyPath: @"path"];
    pathAnim.toValue = (id)newPath.CGPath;
    
    CABasicAnimation* colorAnim = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    colorAnim.toValue = (id)[UIColor redColor].CGColor;
    
    CABasicAnimation* fillColorAnim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnim.toValue = (id)[UIColor whiteColor].CGColor;
    
    CABasicAnimation* widthAnim = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    widthAnim.toValue = (id)[NSNumber numberWithInt:20];
    
    CABasicAnimation* opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.toValue = (id)[NSNumber numberWithFloat:0.0f];
    
    UIBezierPath *newShadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * newRadius, 2.0 * newRadius) cornerRadius:newRadius];
    
    CABasicAnimation* shadowPathAnim = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    shadowPathAnim.toValue = (id) newShadowPath.CGPath;
    
    CABasicAnimation* strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnim.toValue = (id)[NSNumber numberWithInt:1];
    
    CABasicAnimation* strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnim.toValue = (id)[NSNumber numberWithFloat:0.1];
    
    anims = [CAAnimationGroup animation];
    anims.animations = [NSArray arrayWithObjects:colorAnim,shadowPathAnim,strokeStartAnim,strokeEndAnim, nil];
    anims.removedOnCompletion = NO;
    anims.duration = 1.0f;
    anims.autoreverses = true;
//    anims.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anims.repeatCount = INFINITY;

    [shape addAnimation:anims forKey:nil];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 1.3f;
//    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [backView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

+(void)stopAnimation
{
    [view.layer removeAllAnimations];
}

+(void)removeIndicator{
    
    [self stopAnimation];
    [view removeFromSuperview];
    view = nil;
    backView = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
