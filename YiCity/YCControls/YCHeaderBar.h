//
//  YCHeaderBar.h
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YCHeaderBarOperation <NSObject>
-(void)leftButtonClick ;
-(void)rightButtonClick ;
-(void)close ;
@end
@interface YCHeaderBar : UIView
@property(nonatomic,strong)UIButton *leftButton ;
@property(nonatomic,strong)UIButton *rightButton ;
@property(nonatomic,strong)NSString *title ;
-(void)addToRightButtons:(UIButton *)btn ;
-(void)clearRightBtns ;
@property(nonatomic,assign)id<YCHeaderBarOperation> delegate ;
@end
