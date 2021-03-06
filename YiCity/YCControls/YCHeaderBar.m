//
//  YCHeaderBar.m
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCHeaderBar.h"
#import "EDColor.h"
@interface YCHeaderBar()
{
    UILabel *_titleLabel ;
    NSMutableArray *_rightButtons ;
    CALayer *bottomLayer ;
    UIButton *closeBtn ;
}
@end
@implementation YCHeaderBar
-(id)init
{
    self = [super init];
    if (self) {
        [self initila];
    }
    return self ;
}



-(void)initila
{
    _rightButtons = [NSMutableArray arrayWithCapacity:4];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    _leftButton.frame = CGRectMake(0, 0, 45, 45);
    bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor =  [UIColor colorWithRed:0.706f green:0.706f blue:0.706f alpha:1.0f].CGColor;
    //bottomLayer.borderWidth = 1;
    bottomLayer.frame = CGRectMake(0,CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1);
    //_rightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    //_rightButton.frame = CGRectMake(CGRectGetWidth(self.frame)-45, 0, 45, 45) ;
    [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[_rightButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithHexString:@"#FD5E0F"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(45, 0, 45, 45) ;
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [self addSubview:_titleLabel ];
    [self addSubview:_leftButton];
        [self.layer addSublayer:bottomLayer];
    //[self addSubview:_rightButton];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initila];
    }
    return self ;
}
-(void)setLeftButton:(UIButton *)leftButton
{
    if (leftButton) {
        leftButton.frame = CGRectMake(0, 0, 45, 45);
    }
    _leftButton = leftButton ;
    [self addSubview:_leftButton];
}

-(void)setRightButton:(UIButton *)rightButton
{
    if (_rightButton) {
        rightButton.frame = CGRectMake(CGRectGetWidth(self.frame)-45, 0, 45, 45) ;
    }
    _rightButton = rightButton ;
    [_rightButtons addObject:_rightButton];
    [self addSubview:_rightButton];
}

-(void)addToRightButtons:(UIButton *)btn
{
    [self addSubview:btn];
    [_rightButtons addObject:btn];
    [self layoutHeaderRight] ;
}

-(void)clearRightBtns
{
    if (_rightButtons) {
        for (UIButton *btn in _rightButtons) {
            if (btn && [btn isKindOfClass:[UIButton class]]) {
                [btn removeFromSuperview];
            }
        }
    }
}

-(void)layoutHeaderRight
{
    NSInteger addedButton = 0 ;
    for (NSInteger i = [_rightButtons count]-1 ; i>=0 ; i--) {
        addedButton++ ;
        UIButton *button = _rightButtons[i];
        button.frame = CGRectMake(CGRectGetWidth(self.frame) - addedButton*45, 0, 45, 45);
    }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame] ;
    _titleLabel.frame = frame ;

}

-(void)setTitle:(NSString *)title
{
    _title = title ;
    _titleLabel.text = title ;
}

-(void)close:(id)sender 
{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(close)]) {
            [_delegate close];
        }
    }
}

@end
