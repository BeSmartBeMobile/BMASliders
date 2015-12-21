/*
 The MIT License (MIT)
 
 Copyright (c) 2015-present Badoo Trading Limited.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "BMASliderLiveRenderingStyle.h"

@implementation BMASliderLiveRenderingStyle

- (UIImage *)unselectedLineImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(3., 2.), NO, [[UIScreen mainScreen] scale]);

    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0., 0., 3., 2.)];
    [[UIColor colorWithRed:203.0/255.0 green:208.0/255.0 blue:216.0/255.0 alpha:1.0] setFill];
    [rectanglePath fill];

    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return [thumbnail resizableImageWithCapInsets:UIEdgeInsetsMake(0., 1., 0., 1.) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)selectedLineImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(3., 2.), NO, [[UIScreen mainScreen] scale]);

    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0., 0., 3., 2.)];
    [[UIColor colorWithRed:98.0/255.0 green:168.0/255.0 blue:222.0/255.0 alpha:1.0] setFill];
    [rectanglePath fill];

    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return [thumbnail resizableImageWithCapInsets:UIEdgeInsetsMake(0., 1., 0., 1.) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)handlerImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(28., 28.), NO, [[UIScreen mainScreen] scale]);
    UIColor *color = [UIColor whiteColor];
    
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0., 0., 28., 28.)];
    [color setFill];
    [ovalPath fill];
    
    //make a new path with the old bounds and the bigger one (reversed)
    CGMutablePathRef shadowPath = CGPathCreateMutable();
    const CGFloat CORNER_RADIUS = 8.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //add OUTER rect
    UIBezierPath * outerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(CGRectMake(0., 0., 28., 28.), -CORNER_RADIUS, -CORNER_RADIUS) cornerRadius:CORNER_RADIUS];
    CGPathAddPath(shadowPath, NULL, [outerPath CGPath]);
    
    CGPathAddPath(shadowPath, NULL, [ovalPath CGPath]);
    CGPathCloseSubpath(shadowPath);
    
    // Add the visible paths as the clipping path to the context
    CGContextAddPath(context, [ovalPath CGPath]);
    
    CGContextClip(context);
    
    UIColor * shadowColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(2.0f, 2.0f), 6.0f, [shadowColor CGColor]);
    
    // Now fill the rectangle, so the shadow gets drawn
    [shadowColor setFill];
    CGContextSaveGState(context);
    CGContextAddPath(context, shadowPath);
    CGContextEOFillPath(context);
    
    // Release the paths
    CGPathRelease(shadowPath);
    
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnail;
}

@end
