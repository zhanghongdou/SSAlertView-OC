//
//  SSAlertView.h
//  SSAlertView
//
//  Created by 爱利是 on 16/8/3.
//  Copyright © 2016年 爱利是. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SSAlertViewMode){
    SSAlertViewModeSuccess,
    SSAlertViewModeError,
    SSAlertViewModeWarning,
    SSAlertViewModeDefault,
};


typedef NS_ENUM(NSInteger, SSAlertLeaveMode){
    SSAlertLeaveModeDefault,
    SSAlertLeaveModeTop,
    SSAlertLeaveModeBottom,
    SSAlertLeaveModeLeft,
    SSAlertLeaveModeRight,
    
};


typedef void (^ClickBlock)(NSInteger index);
@interface SSAlertView : UIView
- (id)initWithTitle:(NSString *)title
                   AlertMessage:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray  *)otherButtonsTitles;
@property (nonatomic, assign) SSAlertViewMode mode;
@property (nonatomic, assign) SSAlertLeaveMode leaveModel;
@property (nonatomic, copy) ClickBlock clickBlock;
@property (nonatomic, assign) CGFloat radious;
-(void)show;
@end
