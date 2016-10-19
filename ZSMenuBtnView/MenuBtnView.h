//
//  MenuBtnView.h
//  PaintCodeDemo
//
//  Created by Kael on 2016/10/13.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDurationTime 0.4//动画执行时长

typedef NS_ENUM(NSUInteger, DrawBtnType) {
    kBtnOriginalType,
    kBtnArrowType,
};

@interface MenuBtnView : UIButton <CAAnimationDelegate>

/**
 * 横线颜色
 * 就是可能会有动画的那三条横线的颜色
 */
@property (nonatomic,strong) UIColor *lineColor;//线的颜色

/**
 背景色
 */
@property (nonatomic,strong) UIColor *bgColor;//背景色

/**
 背景色图层
 */
@property (nonatomic,strong) CALayer *bgColorLayer;

/**
 手绘动画的进度
 */
@property (nonatomic,assign) CGFloat progressValue;



#pragma mark - 手绘线条
@property (nonatomic,strong) UIBezierPath *upLine;

@property (nonatomic,strong) UIBezierPath *midLine;

@property (nonatomic,strong) UIBezierPath *downLine;

@property (nonatomic,strong) CALayer *drawContentLayer;

#pragma mark - 动画实现 点击效果的时候 一次性完成动画
@property (nonatomic,strong) CAShapeLayer *upLayer;

@property (nonatomic,strong) CAShapeLayer *midLayer;

@property (nonatomic,strong) CAShapeLayer *downLayer;

/**
 动画层
 */
@property (nonatomic,strong) CALayer *animationlayer;

/**
 是否使用 绘图方式 执行动画
 这个属性关乎 UIButton 是否可点击
 */
@property (nonatomic,assign) BOOL isDrawView;//是否使用划线方式


/**
 绘制按钮的 状态 ：1、原始菜单状态：kBtnOriginalType--2、箭头状态：kBtnArrowType,
 */
@property (nonatomic,assign) DrawBtnType statusType;

/**
 按钮点击变为箭头或者 返回原始状态

 @param toArrow 是否是要变为箭头状态
 */
-(void)changeToArrowView:(BOOL)toArrow;

@end
