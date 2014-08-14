//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//


//#import "CUIThemeGradientDrawing.h"
#import "CUIPSDGradientEvaluator.h"
#import "CUIColor.h"

@interface CUIThemeGradient : NSObject// <CUIThemeGradientDrawing>
{
    CUIPSDGradientEvaluator *gradientEvaluator;
    CGFunctionRef colorShader;
    CGColorSpaceRef colorSpace;
}

- (id)interpolatedColorAtLocation:(CGFloat)arg1;
- (void)drawFromPoint:(CGPoint)arg1 toPoint:(CGPoint)arg2 options:(NSUInteger)arg3 withContext:(CGContextRef)arg4;
- (void)drawInRect:(CGRect)arg1 relativeCenterPosition:(CGPoint)arg2 withContext:(CGContextRef)arg3;
- (void)drawFromPoint:(CGPoint)arg1 toPoint:(CGPoint)arg2 options:(NSUInteger)arg3;
- (void)drawInRect:(CGRect)arg1 angle:(CGFloat)arg2;
- (void)drawInRect:(CGRect)arg1 angle:(CGFloat)arg2 withContext:(CGContextRef)arg3;
- (CGFunctionRef)colorShader;
- (CGFunctionRef)_newColorShaderForDistance:(CGFloat)arg1;
- (void)dealloc;
- (CGBlendMode)blendMode;
- (CUIColor *)fillColor;
- (BOOL)isDithered;
- (CGFloat)smoothingCoefficient;
- (NSArray *)opacityLocations;
- (NSArray *)opacityStops;
- (NSArray *)colorLocations;
- (NSArray *)colorStops;
//- (id)_colorFromPSDGradientColor:(struct _psdGradientColor)arg1;
- (id)initWithColors:(NSArray *)arg1 colorlocations:(NSArray *)arg2 colorMidpoints:(NSArray *)arg3 opacities:(NSArray *)arg4 opacityLocations:(NSArray *)arg5 opacityMidpoints:(NSArray *)arg6 smoothingCoefficient:(CGFloat)arg7 fillColor:(CUIColor *)arg8 colorSpace:(CGColorSpaceRef)arg9 dither:(BOOL)arg10;
- (id)initWithColors:(NSArray *)arg1 colorlocations:(NSArray *)arg2 colorMidpoints:(NSArray *)arg3 opacities:(NSArray *)arg4 opacityLocations:(NSArray *)arg5 opacityMidpoints:(NSArray *)arg6 smoothingCoefficient:(CGFloat)arg7 fillColor:(CUIColor *)arg8 colorSpace:(CGColorSpaceRef)arg9;
- (id)_initWithGradientEvaluator:(CUIPSDGradientEvaluator *)arg1 colorSpace:(CGColorSpaceRef)arg2;
- (id)_psdGradientColorStopsWithColors:(NSArray *)arg1 locations:(NSArray *)arg2 colorSpace:(CGColorSpaceRef)arg3;
- (struct _psdGradientColor)_psdGradientColorWithColor:(CGColorRef)arg1 colorSpace:(CGColorSpaceRef)arg2;
- (id)_psdGradientOpacityStopsWithOpacities:(NSArray *)arg1 locations:(NSArray *)arg2;

@end

