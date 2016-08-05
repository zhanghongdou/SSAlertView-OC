//
//  SSAlertView.m
//  SSAlertView
//
//  Created by 爱利是 on 16/8/3.
//  Copyright © 2016年 爱利是. All rights reserved.
//

#import "SSAlertView.h"
#import "Masonry.h"
#import "UIView+DrawImage.h"
#define drawRectImageWidth 60
#define SUCCESS_COLOR [UIColor colorWithRed:126/255.0 green:216/255.0 blue:33/255.0 alpha:1]
#define WARNING_COLOR [UIColor colorWithRed:245/255.0 green:166/255.0 blue:35/255.0 alpha:1]
#define ERROR_COLOR [UIColor colorWithRed:208/255.0 green:2/255.0 blue:27/255.0 alpha:1]
@interface SSAlertView()
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *messageStr;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, copy) NSString *cancelStr;
@property (nonatomic, strong) UIButton *cacelButton;
@property (nonatomic, strong) NSArray *otherButtons;
@property (nonatomic, strong) UIView *logoView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation SSAlertView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.buttonArray = [NSMutableArray array];
        self.radious = 5.0;
        self.leaveModel = SSAlertLeaveModeDefault;
        self.mode = SSAlertViewModeDefault;
        [self registerKVC];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
       AlertMessage:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray  *)otherButtonsTitles
{
    if (self = [self initWithFrame:[UIScreen mainScreen].bounds]) {
        self.titleStr = title;
        self.messageStr = message;
        self.cancelStr = cancelButtonTitle;
        self.otherButtons = otherButtonsTitles;
        [self creatUI];
    }
    return self;
}
//底部的View
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.2;
    }
    return  _backView;
}
//弹出的View
-(UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 5;
    }
    return _alertView;
}
//弹出View的logo
-(UIView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIView alloc]init];
    }
    return _logoView;
}

//标题
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = self.titleStr;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

//message
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.text = self.messageStr;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _messageLabel;
}

-(void)creatUI
{
    [self addSubview:self.backView];
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.logoView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.messageLabel];
    //下面就是设置button
    
    [self creatButtons];
    [self updateModeStyle];
    [self setLayout];
}
-(void)setLayout
{

    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.backView);
        make.left.mas_equalTo(self.backView.mas_left).offset(30);
        make.right.mas_equalTo(self.backView.mas_right).offset(-30);
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView.mas_centerX);
        make.top.mas_equalTo(self.alertView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(drawRectImageWidth, drawRectImageWidth));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView.mas_centerX);
        make.left.mas_equalTo(self.alertView.mas_left).offset(10);
        make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(10);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.alertView);
        make.left.mas_equalTo(self.alertView).offset(10);
        make.right.mas_equalTo(self.alertView).offset(-10);
        
    }];
    //如果有取消按钮，且其他按钮只有一个的时候
    if (self.cancelStr != nil && self.otherButtons.count == 1) {
        [self.cacelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView.mas_left).offset(10);
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(self.alertView.mas_centerX).offset(-5);
            make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
            make.height.mas_equalTo(44);
        }];
        UIButton *btn = self.buttonArray[0];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView.mas_centerX).offset(5);
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
            make.height.mas_equalTo(44);
        }];
    }
    
    //如果有取消按钮，且其他按钮不止一个的时候
    if (self.cancelStr != nil && self.otherButtons.count > 1) {
        [self.cacelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView.mas_left).offset(10);
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
            make.height.mas_equalTo(44);
        }];
        
        for (int i = 0; i < self.buttonArray.count; i++) {
            UIButton *btn = self.buttonArray[i];
            if (i == 0) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                    make.top.mas_equalTo(self.cacelButton.mas_bottom).offset(10);
                    make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                    make.height.mas_equalTo(44);
                }];
            }else{
                UIButton *lastBtn = self.buttonArray[i - 1];
                
                if (i == self.buttonArray.count - 1) {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                        make.top.mas_equalTo(lastBtn.mas_bottom).offset(10);
                        make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                        make.height.mas_equalTo(44);
                        make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
                    }];
                }else{
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                        make.top.mas_equalTo(lastBtn.mas_bottom).offset(10);
                        make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                        make.height.mas_equalTo(44);
                    }];
                }
            }
        }
    }
//    如果只有取消的时候
    if (self.cancelStr != nil && self.buttonArray.count == 0) {
        [self.cacelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView.mas_left).offset(10);
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
        }];
    }
    //如果只有其他按钮的时候（只有一个的情况和两个的时候，还有大于两个的时候）
    if (self.cancelStr.length == 0 && self.buttonArray.count > 0) {
        if (self.buttonArray.count == 1) {
            UIButton *btn = self.buttonArray[0];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
                make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                make.height.mas_equalTo(44);
                make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
            }];
        }
        if (self.buttonArray.count == 2) {
            UIButton *btn1 = self.buttonArray[0];
            [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
                make.right.mas_equalTo(self.alertView.mas_centerX).offset(-5);
                make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
                make.height.mas_equalTo(44);
            }];
            UIButton *btn2 = self.buttonArray[1];
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.alertView.mas_centerX).offset(5);
                make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
                make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
                make.height.mas_equalTo(44);
            }];
        }
        if (self.buttonArray.count > 2) {
            for (int i = 0; i < self.buttonArray.count; i++) {
                UIButton *btn = self.buttonArray[i];
                if (i == 0) {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(10);
                        make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                        make.height.mas_equalTo(44);
                    }];
                }else{
                    UIButton *lastBtn = self.buttonArray[i - 1];
                    
                    if (i == self.buttonArray.count - 1) {
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                            make.top.mas_equalTo(lastBtn.mas_bottom).offset(10);
                            make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                            make.height.mas_equalTo(44);
                            make.bottom.mas_equalTo(self.alertView.mas_bottom).offset(-10);
                        }];
                    }else{
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(self.alertView.mas_left).offset(10);
                            make.top.mas_equalTo(lastBtn.mas_bottom).offset(10);
                            make.right.mas_equalTo(self.alertView.mas_right).offset(-10);
                            make.height.mas_equalTo(44);
                        }];
                    }
                }
            }
        }
    }
}


-(void)creatButtons
{
    if (self.cancelStr != nil) {
        self.cacelButton = [[UIButton alloc]init];
        [self.cacelButton setTitle:self.cancelStr forState:UIControlStateNormal];
        self.cacelButton.tag = 999;
        [self.cacelButton addTarget:self action:@selector(btnCLikc:) forControlEvents:UIControlEventTouchUpInside];
        self.cacelButton.layer.cornerRadius = 4.0;
        self.cacelButton.layer.borderWidth = 1.0;
        [self.alertView addSubview:self.cacelButton];
    }
    if (self.otherButtons.count != 0) {
        for (int i = 0; i < self.otherButtons.count; i++) {
            UIButton *btn = [[UIButton alloc]init];
            [btn setTitle:self.otherButtons[i] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 4.0;
            if (self.cancelStr != nil) {
                btn.tag = 999 + i + 1;
            }else{
                btn.tag = 999 + i;
            }
            
            [btn addTarget:self action:@selector(btnCLikc:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:btn];
            [self.buttonArray addObject:btn];
        }
    }
   
}
-(void)btnCLikc:(UIButton *)sender
{
    if (self.clickBlock) {
        self.clickBlock(sender.tag - 999);
    }
    [self hide];
}

//show
-(void)show
{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backView);
        make.left.mas_equalTo(self.backView.mas_left).offset(30);
        make.right.mas_equalTo(self.backView.mas_right).offset(-30);
    }];
}


-(void)hide
{
    NSTimeInterval interval = 0.3;
    switch (self.leaveModel) {
        case SSAlertLeaveModeBottom:
        {
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self.backView);
                    make.left.mas_equalTo(self.backView.mas_left).offset(30);
                    make.right.mas_equalTo(self.backView.mas_right).offset(-30);
                    make.top.mas_equalTo(self.backView.mas_bottom);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self removeAllObserve];
            }];
        }
            break;
        case SSAlertLeaveModeTop:
        {
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self.backView);
                    make.left.mas_equalTo(self.backView.mas_left).offset(30);
                    make.right.mas_equalTo(self.backView.mas_right).offset(-30);
                    make.bottom.mas_equalTo(self.backView.mas_top);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self removeAllObserve];
            }];
        }
            break;
        case SSAlertLeaveModeRight:
        {
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.backView);
                    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 60);
                    make.left.mas_equalTo(self.backView.mas_right).offset(30);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self removeAllObserve];
            }];
        }
            break;
        case SSAlertLeaveModeLeft:
        {
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.backView);
                    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 60);
                    make.right.mas_equalTo(self.backView.mas_left);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self removeAllObserve];
            }];
        }
            break;
        default:
            [self removeFromSuperview];
            [self removeAllObserve];
            break;
    }
}
-(void)removeAllObserve
{
    [self removeObserver:self forKeyPath:@"mode"];
}
//监听mode变化的时候进行刷新页面
-(void)updateModeStyle
{
    if (self.mode == SSAlertViewModeDefault || self.mode == SSAlertViewModeSuccess) {
        [self.logoView ss_drawCheckMark];
        [self.cacelButton setTitleColor:SUCCESS_COLOR forState:UIControlStateNormal];
        self.cacelButton.layer.borderColor = SUCCESS_COLOR.CGColor;
        for (UIButton *button in self.buttonArray) {
            [button setBackgroundColor:SUCCESS_COLOR];
        }
    }
    if(self.mode == SSAlertViewModeWarning){
        [self.logoView ss_drawWarning];
        [self.cacelButton setTitleColor:WARNING_COLOR forState:UIControlStateNormal];
        self.cacelButton.layer.borderColor = WARNING_COLOR.CGColor;
        for (UIButton *button in self.buttonArray) {
            [button setBackgroundColor:WARNING_COLOR];
        }
    }
    if(self.mode == SSAlertViewModeError){
        [self.logoView ss_drawError];
        [self.cacelButton setTitleColor:ERROR_COLOR forState:UIControlStateNormal];
        self.cacelButton.layer.borderColor = ERROR_COLOR.CGColor;
        for (UIButton *button in self.buttonArray) {
            [button setBackgroundColor:ERROR_COLOR];
        }
    }
}

-(void)registerKVC
{
    [self addObserver:self forKeyPath:@"mode" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateModeStyle) withObject:nil waitUntilDone:nil];
    }else{
        [self updateModeStyle];
    }
}
@end
