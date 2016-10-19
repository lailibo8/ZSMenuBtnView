//
//  MenuBtnView.m
//  PaintCodeDemo
//
//  Created by Kael on 2016/10/13.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "MenuBtnView.h"


@interface MenuBtnView(){
    
    
    
}

#pragma mark - 通过画图方式（drawRect）完成的动画

/**
 横线原始尺寸
 */
@property (nonatomic,assign) CGSize originalSize;

/**
 横线变成箭头时的尺寸
 */
@property (nonatomic,assign) CGSize arrowSize;

/**
 横线原始旋转角度
 */
@property (nonatomic,assign) CGFloat originalAngle;

/**
 箭头状态的时候 上横线的角度
 */
@property (nonatomic,assign) CGFloat arrowUpAngle;

/**
 下横线的角度状态
 */
@property (nonatomic,assign) CGFloat arrowDownAngle;

/**
 上箭头的原始位置
 */
@property (nonatomic,assign) CGPoint originalUpPoint;

/**
 上横线的 箭头状态位置
 */
@property (nonatomic,assign) CGPoint arrowUpPoint;

/**
 下横线的 原始状态 位置
 */
@property (nonatomic,assign) CGPoint originalDownPoint;

/**
 下横线 箭头状态 位置
 */
@property (nonatomic,assign) CGPoint arrowDownPoint;




/**
 当前 上横线 角度
 */
@property (nonatomic,assign) CGFloat upAngle;

/**
 当前 下横线 角度
 */
@property (nonatomic,assign) CGFloat downAngle;

/**
 当前 上横线 尺寸
 */
@property (nonatomic,assign) CGSize upSize;

/**
 当前下横线尺寸
 */
@property (nonatomic,assign) CGSize downSize;

/**
 当前 上横线 位置
 */
@property (nonatomic,assign) CGPoint upPoint;

/**
 当前下横线位置
 */
@property (nonatomic,assign) CGPoint downPoint;



@end

@implementation MenuBtnView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        _lineColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        _bgColor = [UIColor colorWithRed: 0.059 green: 0.51 blue: 0.898 alpha: 1];
        
        _isDrawView = NO;
        _statusType = kBtnOriginalType;
        
        _originalSize = CGSizeMake(32, 3);
        _arrowSize = CGSizeMake(16, 3);
        _originalAngle = 0;
        _arrowUpAngle = 45;
        _arrowDownAngle = -45;
        _originalUpPoint = CGPointMake(9, 10);
        _originalDownPoint = CGPointMake(9, 30);
        _arrowUpPoint = CGPointMake(9.5, 20);
        _arrowDownPoint = CGPointMake(9.5, 19);
        
        [self setTitle:@"" forState:UIControlStateHighlighted];
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    return self;

}


-(instancetype)init{
    self = [super init];
    if (self) {
        _lineColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        _bgColor = [UIColor colorWithRed: 0.059 green: 0.51 blue: 0.898 alpha: 1];
        
        _isDrawView = NO;
        _statusType = kBtnOriginalType;
        
        _originalSize = CGSizeMake(32, 3);
        _arrowSize = CGSizeMake(16, 3);
        _originalAngle = 0;
        _arrowUpAngle = 45;
        _arrowDownAngle = -45;
        _originalUpPoint = CGPointMake(9, 10);
        _originalDownPoint = CGPointMake(9, 30);
        _arrowUpPoint = CGPointMake(9.5, 20);
        _arrowDownPoint = CGPointMake(9.5, 19);
        
        [self setTitle:@"" forState:UIControlStateHighlighted];
        [self setTitle:@"" forState:UIControlStateNormal];

    }
    return self;
}
#pragma mark - UIBUtton点击事件



#pragma mark - CAAnimation 动画改变
-(void)changeToArrowView:(BOOL)toArrow{
    
    if (_isDrawView) {
        [self setNeedsDisplay];
        return;
    }
    
    if (toArrow) {
        [self upLayerToArrow];
        [self downLayerToArrow];
        self.progressValue = 1;
        _statusType = kBtnArrowType;
    }else{
        [self upLayerToOriginal];
        [self downLayerToOriginal];
        self.progressValue = 0;
        _statusType = kBtnOriginalType;
    }
    


}


-(void)upLayerToArrow{
    CGFloat kTime = kDurationTime;
    
        //---------------------- 设定为缩放
    CABasicAnimation *scaleXanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        // 动画选项设定
    scaleXanimation.duration = kTime; // 动画持续时间
    scaleXanimation.removedOnCompletion = NO;
    scaleXanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    scaleXanimation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    scaleXanimation.toValue = [NSNumber numberWithFloat:0.5]; // 结束时的倍率
    
    
    
        //------------------rotate  旋转！！
    CABasicAnimation *rotateanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        // 动画选项设定
    rotateanimation.duration = kTime; // 动画持续时间
    rotateanimation.removedOnCompletion = NO;
    rotateanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    rotateanimation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的角度
    rotateanimation.toValue = [NSNumber numberWithFloat:-0.25*M_PI]; // 结束时的角度
    
    
        //-------------------position 位置
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = kTime;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:_upLayer.position];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_upLayer.position.x - 9, _upLayer.position.y+4)];
    
        //----------------- 组合动画 animationGroup
    NSMutableArray *animationArray = [NSMutableArray array];
    [animationArray addObject:scaleXanimation];
    [animationArray addObject:rotateanimation];
    [animationArray addObject:positionAnimation];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kTime;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = animationArray;
    
    animationGroup.delegate = self;
    
    [_upLayer addAnimation:animationGroup forKey:@"upLayerToArrowAnimation"];

}


-(void)downLayerToArrow{
    CGFloat kTime = kDurationTime;
    
//---------------------- 设定为缩放
    CABasicAnimation *scaleXanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        // 动画选项设定
    scaleXanimation.duration = kTime; // 动画持续时间
    scaleXanimation.removedOnCompletion = NO;
    scaleXanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    scaleXanimation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    scaleXanimation.toValue = [NSNumber numberWithFloat:0.5]; // 结束时的倍率
    
    
//------------------rotate  旋转！！
    CABasicAnimation *rotateanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        // 动画选项设定
    rotateanimation.duration = kTime; // 动画持续时间
    rotateanimation.removedOnCompletion = NO;
    rotateanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    rotateanimation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的角度
    rotateanimation.toValue = [NSNumber numberWithFloat: 0.25*M_PI]; // 结束时的角度
    
    
//-------------------position 位置
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = kTime;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:_downLayer.position];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_downLayer.position.x - 9, _downLayer.position.y - 4)];
    
    
    
//--------------------动画数组
    
    NSMutableArray *animationArray = [NSMutableArray array];
    [animationArray addObject:scaleXanimation];
    [animationArray addObject:rotateanimation];
    [animationArray addObject:positionAnimation];
    
//--------------------组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kTime;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = animationArray;
    animationGroup.delegate = self;
    
    [_downLayer addAnimation:animationGroup forKey:@"downLayerToArrowAnimation"];
}

-(void)upLayerToOriginal{
    CGFloat kTime = kDurationTime;
    
        //---------------------- 设定为缩放
    CABasicAnimation *scaleXanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        // 动画选项设定
    scaleXanimation.duration = kTime; // 动画持续时间
    scaleXanimation.removedOnCompletion = NO;
    scaleXanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    scaleXanimation.fromValue = [NSNumber numberWithFloat:0.5]; // 开始时的倍率
    scaleXanimation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    
    
    
        //------------------rotate  旋转！！
    CABasicAnimation *rotateanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        // 动画选项设定
    rotateanimation.duration = kTime; // 动画持续时间
    rotateanimation.removedOnCompletion = NO;
    rotateanimation.fillMode = kCAFillModeForwards;
        // 旋转的 角度
    rotateanimation.fromValue = [NSNumber numberWithFloat:-0.25*M_PI]; // 开始时的角度
    rotateanimation.toValue = [NSNumber numberWithFloat:0.0]; // 结束时的角度
    
    
        //-------------------position 位置
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = kTime;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_upLayer.position.x - 9, _upLayer.position.y+4)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:_upLayer.position];

    
    
    NSMutableArray *animationArray = [NSMutableArray array];
    [animationArray addObject:scaleXanimation];
    [animationArray addObject:rotateanimation];
    [animationArray addObject:positionAnimation];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kTime;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = animationArray;
    
    animationGroup.delegate = self;
    
    [_upLayer addAnimation:animationGroup forKey:@"upLayerToOriginalAnimation"];
}

-(void)downLayerToOriginal{
    CGFloat kTime = kDurationTime;
    
        //---------------------- 设定为缩放
    CABasicAnimation *scaleXanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        // 动画选项设定
    scaleXanimation.duration = kTime; // 动画持续时间
    scaleXanimation.removedOnCompletion = NO;
    scaleXanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    scaleXanimation.toValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    scaleXanimation.fromValue = [NSNumber numberWithFloat:0.5]; // 结束时的倍率
    
    
    
        //------------------rotate  旋转！！
    CABasicAnimation *rotateanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        // 动画选项设定
    rotateanimation.duration = kTime; // 动画持续时间
    rotateanimation.removedOnCompletion = NO;
    rotateanimation.fillMode = kCAFillModeForwards;
    rotateanimation.toValue = [NSNumber numberWithFloat:0.0]; // 开始时的角度
    rotateanimation.fromValue = [NSNumber numberWithFloat: 0.25*M_PI]; // 结束时的角度
    
    
        //-------------------position 位置
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = kTime;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.toValue = [NSValue valueWithCGPoint:_downLayer.position];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_downLayer.position.x - 9, _downLayer.position.y - 4)];
    
    
    
        //--------------------动画数组
    
    NSMutableArray *animationArray = [NSMutableArray array];
    [animationArray addObject:scaleXanimation];
    [animationArray addObject:rotateanimation];
    [animationArray addObject:positionAnimation];
    
        //--------------------组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kTime;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = animationArray;
    animationGroup.delegate = self;
    
    [_downLayer addAnimation:animationGroup forKey:@"downLayerToOriginalAnimation"];
}

#pragma mark - 动画回调方法 CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"animationDidStop");
    
    
}

#pragma mark - 动态改变
-(void)setProgressValue:(CGFloat)progressValue{
    
    _isDrawView = YES;//更换进度的时候强制把动画状态更换为画图模式
    _animationlayer.hidden = _isDrawView;
    
    _progressValue = progressValue;
    if (progressValue < 0 || progressValue > 1) {
        _progressValue = 0;
    }
        //更换当前属性
    [self changeCurrentProperty];

//    if (progressValue>0 && progressValue<1) {
//        _isDrawView = YES;//更换进度的时候强制把动画状态更换为画图模式
//    }
//----------------如果进度值不是初始化赋值则需要更新UI 重新绘制
    if (progressValue >= 0 && progressValue <= 1) {
        [self setNeedsDisplay];
    }
    
    if (progressValue==0) {
        [self upLayerToOriginal];
        [self downLayerToOriginal];
        _statusType = kBtnOriginalType;
    }
    if (progressValue==1) {
        [self upLayerToArrow];
        [self downLayerToArrow];
        _statusType = kBtnArrowType;
    }
    
}


-(void)changeViewAnimationWith:(CGFloat)progress{

    [self upLayerChangedWith:progress];
    [self downLayerChangedWith:progress];

}

-(void)upLayerChangedWith:(CGFloat)progress{
    CGFloat kTime = 0.1;
    
//---------------------- 设定为缩放
    CABasicAnimation *scaleXanimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        // 动画选项设定
    scaleXanimation.duration = kTime; // 动画持续时间
        //    scaleXanimation.repeatCount = 1; // 重复次数
        //    scaleXanimation.autoreverses = YES; // 动画结束时执行逆动画
    scaleXanimation.removedOnCompletion = NO;
    scaleXanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    scaleXanimation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    scaleXanimation.toValue = [NSNumber numberWithFloat:(0.5+(1-progress)*0.5)]; // 结束时的倍率
    
    
    
//------------------rotate  旋转！！
    CABasicAnimation *rotateanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        // 动画选项设定
    rotateanimation.duration = kTime; // 动画持续时间
        //    rotateanimation.repeatCount = 1; // 重复次数
        //    rotateanimation.autoreverses = YES; // 动画结束时执行逆动画
    rotateanimation.removedOnCompletion = NO;
    rotateanimation.fillMode = kCAFillModeForwards;
        // 缩放倍数
    rotateanimation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的倍率
    rotateanimation.toValue = [NSNumber numberWithFloat:-0.25*progress*M_PI]; // 结束时的倍率
    
    
//-------------------position 位置
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = kTime;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:_upLayer.position];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_upLayer.position.x - 9, _upLayer.position.y+4)];
    
    
    
    
    NSMutableArray *animationArray = [NSMutableArray array];
    [animationArray addObject:scaleXanimation];
//    [animationArray addObject:rotateanimation];
//    [animationArray addObject:positionAnimation];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        //    animationGroup.repeatCount = 1;
    animationGroup.duration = kTime;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
        //    animationGroup.autoreverses = YES;
    animationGroup.animations = animationArray;
    
    animationGroup.delegate = self;
    
    [_upLayer addAnimation:animationGroup forKey:@"upLayerToArrowAnimation"];
}

-(void)downLayerChangedWith:(CGFloat)progress{



}

#pragma mark - 基本属性改变
-(void)changeCurrentProperty{
    
    _originalSize = CGSizeMake(32, 3);
    _arrowSize = CGSizeMake(16, 3);
    _originalAngle = 0;
    _arrowUpAngle = 45;
    _arrowDownAngle = -45;
    _originalUpPoint = CGPointMake(9, 10);
    _originalDownPoint = CGPointMake(9, 30);

    _arrowUpPoint = CGPointMake(9.5, 20);
    _arrowDownPoint = CGPointMake(10.5, 20.25);
        //角度
    _upAngle = (_arrowUpAngle - _originalAngle) * _progressValue + _originalAngle;
    _downAngle = (_arrowDownAngle - _originalAngle) * _progressValue + _originalAngle;;
    
    _upAngle = [self getCurrentValueWithOriginalValue:_originalAngle andArrowValue:_arrowUpAngle andProgressValue:_progressValue];
    _downAngle = [self getCurrentValueWithOriginalValue:_originalAngle andArrowValue:_arrowDownAngle andProgressValue:_progressValue];
    
        //尺寸
    _upSize = [self getCurrentSizeWithOriginalSize:_originalSize andArrowSize:_arrowSize andProgressValue:_progressValue];
    //    _downSize = [self getCurrentSizeWithOriginalSize:_originalSize andArrowSize:_arrowSize andProgressValue:_progressValue];
    _downSize = _upSize;
        //位置
    _upPoint = [self getCurrentPointWithOriginalPoint:_originalUpPoint andArrowPoint:_arrowUpPoint andProgressValue:_progressValue];
    _downPoint = [self getCurrentPointWithOriginalPoint:_originalDownPoint andArrowPoint:_arrowDownPoint andProgressValue:_progressValue];
}

-(CGFloat)getCurrentValueWithOriginalValue:(CGFloat)originalValue andArrowValue:(CGFloat)arrowValue andProgressValue:(CGFloat)progress{
    
    CGFloat resultValue = 0;
    resultValue = (arrowValue - originalValue) * progress + originalValue;
    return resultValue;
    
}

-(CGSize)getCurrentSizeWithOriginalSize:(CGSize)originalSize andArrowSize:(CGSize)arrowSize andProgressValue:(CGFloat)progress{
    
    CGFloat width = [self getCurrentValueWithOriginalValue:originalSize.width andArrowValue:arrowSize.width andProgressValue:progress];
    CGFloat height = [self getCurrentValueWithOriginalValue:originalSize.height andArrowValue:arrowSize.height andProgressValue:progress];
    CGSize resultSize = CGSizeMake(width, height);
    return resultSize;
}

-(CGPoint)getCurrentPointWithOriginalPoint:(CGPoint)originalPoint andArrowPoint:(CGPoint)arrowPoint andProgressValue:(CGFloat)progress{
    
    CGFloat xValue = [self getCurrentValueWithOriginalValue:originalPoint.x andArrowValue:arrowPoint.x andProgressValue:progress];
    CGFloat yVale = [self getCurrentValueWithOriginalValue:originalPoint.y andArrowValue:arrowPoint.y andProgressValue:progress];
    CGPoint resultPoint = CGPointMake(xValue, yVale);
    return resultPoint;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
    
}

-(void)setIsDrawView:(BOOL)isDrawView{
    
    _isDrawView = isDrawView;
    //********** 这句话 真的很重要
    self.userInteractionEnabled = !_isDrawView;
    //**********

    if (isDrawView) {
        _animationlayer.hidden = YES;
        
        switch (_statusType) {
            case kBtnOriginalType:
            {
                self.progressValue = 0;
            }
                break;
            case kBtnArrowType:
            {
                self.progressValue = 1;
            }
                break;
            default:
                break;
        }
        
        
    }else{
        _animationlayer.hidden = NO;
    }
    [self setNeedsDisplay];
    
}


    //按钮的状态 是原始状态 还是 箭头状态 动画调整
-(void)setStatusType:(DrawBtnType)statusType{
    
    
    switch (statusType) {
        case kBtnOriginalType:
        {
        [self upLayerToOriginal];
        [self downLayerToOriginal];
        }
            break;
        case kBtnArrowType:
        {
        [self upLayerToArrow];
        [self downLayerToArrow];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 画图

- (void)drawRect:(CGRect)rect {
        // Drawing code
    self.titleLabel.hidden = YES;
//---------检测到未初始化数据的时候 要先初始化基本属性
    if (_downSize.height == 0) {
        [self changeCurrentProperty];
    }
//-------------画出背景色
    UIBezierPath* backgroundPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 50, 44)];
    [_bgColor setFill];
    [backgroundPath fill];

//---------- 画图开始...
        //// upLine Drawing
    CGContextRef upContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(upContext);
    CGContextTranslateCTM(upContext, _upPoint.x, _upPoint.y);
    CGContextRotateCTM(upContext, -_upAngle * M_PI / 180);
    _upLine = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, _upSize.width, _upSize.height) cornerRadius: 1];
    [_lineColor setFill];
    [_upLine fill];
    CGContextRestoreGState(upContext);
    
    
        //// midLine Drawing
    UIBezierPath* midLinePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(9, 20, 32, 3) cornerRadius: 1];
    [_lineColor setFill];
    [midLinePath fill];
    
        //// downLine Drawing
    CGContextRef downContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(downContext);
    CGContextTranslateCTM(downContext, _downPoint.x, _downPoint.y);
    CGContextRotateCTM(downContext, -_downAngle * M_PI / 180);
    _downLine = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, _downSize.width, _downSize.height) cornerRadius: 1];
    [_lineColor setFill];
    [_downLine fill];
    CGContextRestoreGState(downContext);
    
//---------- 画图结束...
    
    if (!_isDrawView) {
        _animationlayer.hidden = NO;
            //-----------------------初始化动画层
        if (_animationlayer == nil) {
            
            _animationlayer = [CALayer layer];
            _animationlayer.frame = rect;
            _animationlayer.backgroundColor = [_bgColor CGColor];
//            _animationlayer.backgroundColor = [[UIColor orangeColor] CGColor];
            
                //上部线
            if (!_upLayer) {
                _upLine = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 32, 3) cornerRadius: 1];
                [_lineColor setFill];
                _upLine.lineWidth = 1;
                
                _upLayer.path = [_upLine CGPath];
                _upLayer = [CAShapeLayer layer];
                _upLayer.frame = CGRectMake(_upPoint.x, _upPoint.y, _upSize.width, _upSize.height);
                _upLayer.transform = CATransform3DMakeRotation(-_upAngle*180 / M_PI, 0, 0, 1);
                _upLayer.fillColor = [[UIColor whiteColor] CGColor];
                _upLayer.path = _upLine.CGPath;
                _upLayer.lineWidth = 0;
                _upLayer.lineCap = kCALineCapRound;
            }
                //中部
            if (!_midLayer) {
                _midLine = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 32, 3) cornerRadius: 1];
                [[UIColor whiteColor] setFill];
                _midLayer.path = [_midLine CGPath];
                _midLayer = [CAShapeLayer layer];
                _midLayer.frame = CGRectMake(9, 20, 32, 3);
                _midLayer.fillColor = [[UIColor whiteColor] CGColor];
                _midLayer.path = _midLine.CGPath;
                _midLayer.lineWidth = 0;
                _midLayer.lineCap = kCALineCapRound;
            }
                //下部
            if (!_downLayer) {
                _downLine = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 32, 3) cornerRadius: 1];
                [[UIColor whiteColor] setFill];
                
                _downLayer = [CAShapeLayer layer];
                _downLayer.frame = CGRectMake(9, 30, 32, 3);
                _downLayer.fillColor = [[UIColor whiteColor] CGColor];
                _downLayer.path = [_downLine CGPath];
                _downLayer.lineWidth = 0;
                _downLayer.lineCap = kCALineCapRound;
                
            }
                //添加图层
            [_animationlayer addSublayer:_upLayer];
            [_animationlayer addSublayer:_midLayer];
            [_animationlayer addSublayer:_downLayer];
            
            [self.layer addSublayer:_animationlayer];
            _animationlayer.hidden = self.isDrawView;

        }
    
    }else{

    }
}


@end
