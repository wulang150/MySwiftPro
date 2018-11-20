//
//  SimpleAlertView.m
//  Runner
//
//  Created by  Tmac on 16/2/29.
//  Copyright © 2016年 Janson. All rights reserved.
//

#import "SimpleAlertView.h"



@interface SimpleAlertView()
{
    NSString *alertTitle;
    NSString *alertContent;
    UIView *vi;
    NSArray *btnTitle;
    CGRect frame;
    UIView *mainView;   //弹出框
    
}
@end

@implementation SimpleAlertView

- (void)dealloc
{

}

- (id)initAlertView:(NSString *)title content:(NSString *)content vi:(UIView *)_vi
{
    if(self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)])
    {
        alertTitle = title;
        alertContent = content;
        vi = _vi;
        [self createView];
    }
    return self;
}

- (id)initAlertView:(NSString *)title content:(NSString *)content vi:(UIView *)_vi btnTilte:(NSArray *)_btnTitle
{
    if(self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)])
    {
        alertTitle = title;
        alertContent = content;
        vi = _vi;
        btnTitle = _btnTitle;
        [self createViewWithTitle];
    }
    return self;
}


- (UIView *)commondView
{
    int width = 280;    //弹出框的宽度
    int headHeight = 50,bottomHeight = 60;
    //CGRect frame = CGRectMake(20, (SCREEN_HEIGHT-140)/2, SCREEN_WIDTH-20*2, 140);
    
    //背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    if(alertTitle==nil)
    {
        headHeight = 15;    //没有标题
    }
    //中部
    UILabel *centerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headHeight, width-16, 40)];
    centerViewLabel.textAlignment = NSTextAlignmentCenter;
    centerViewLabel.text = alertContent;
    centerViewLabel.numberOfLines = 0;
    centerViewLabel.textColor = RGB(128,128,128);
    [centerViewLabel sizeToFit];
    
    CGRect iframe = centerViewLabel.frame;
    iframe.size.height = iframe.size.height + 40;
    iframe.origin.x = (width - iframe.size.width)/2;
    centerViewLabel.frame = iframe;
    
    int Height = iframe.size.height+headHeight+bottomHeight;
    if(vi!=nil)
    {
        Height = vi.frame.size.height+vi.frame.origin.y + headHeight + bottomHeight+20;
        vi.frame = CGRectMake(vi.frame.origin.x, vi.frame.origin.y + headHeight, width, vi.frame.size.height);
    }
    frame = CGRectMake((SCREEN_WIDTH-width)/2, (SCREEN_HEIGHT-Height)/2, width, Height);
    
    //弹出框背景
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 8;
    [self addSubview:view];
    mainView = view;
    if(vi==nil)
    {
        [view addSubview:centerViewLabel];
    }
    else
    {
        [view addSubview:vi];
    }
    
    if(alertTitle!=nil)
    {
        //头部
        UILabel *headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, headHeight)];
        headLab.text = alertTitle;
        headLab.font = [UIFont fontWithName:@"Arial" size:20];
        headLab.textColor = RGB(0,80,129);
        headLab.numberOfLines = 0; //by Janson
        headLab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:headLab];
        
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headLab.frame)-1, frame.size.width, 1)];
        lineView.backgroundColor = RGB(200,200,200);
        [view addSubview:lineView];
    }
    self.popView = view;
    return view;
}
- (void)createView
{
    UIView *view = [self commondView];
    //底部
    
    int wbtn = (frame.size.width - 30)/2;
    int hbtn = 45;
    
    UIButton *cancleBtn = [self getBtn:CGRectMake(10, frame.size.height-60, wbtn, hbtn) title:@"取消" tag:1];
    UIButton *okBtn = [self getBtn:CGRectMake(CGRectGetMaxX(cancleBtn.frame)+10, CGRectGetMinY(cancleBtn.frame), wbtn, hbtn) title:@"确定" tag:2];
    [view addSubview:cancleBtn];
    [view addSubview:okBtn];
    
    
}

- (void)createViewWithTitle
{
    
    
    UIView *view = [self commondView];
    //底部
    
    int wbtn = (frame.size.width - 30)/2;
    int hbtn = 45;
    if(btnTitle==nil)
    {
        UIButton *cancleBtn = [self getBtn:CGRectMake(10, frame.size.height-60, wbtn, hbtn) title:@"取消" tag:1];
        UIButton *okBtn = [self getBtn:CGRectMake(CGRectGetMaxX(cancleBtn.frame)+10, CGRectGetMinY(cancleBtn.frame), wbtn, hbtn) title:@"确定" tag:2];
        [view addSubview:cancleBtn];
        [view addSubview:okBtn];
    }
    else
    {
        if(btnTitle.count==2)
        {
            UIButton *cancleBtn = [self getBtn:CGRectMake(10, frame.size.height-60, wbtn, hbtn) title:[btnTitle objectAtIndex:0] tag:1];
            UIButton *okBtn = [self getBtn:CGRectMake(CGRectGetMaxX(cancleBtn.frame)+10, CGRectGetMinY(cancleBtn.frame), wbtn, hbtn) title:[btnTitle objectAtIndex:1] tag:2];
            [view addSubview:cancleBtn];
            [view addSubview:okBtn];
        }
        else
        {
            wbtn = frame.size.width-40;
            UIButton *okBtn = [self getBtn:CGRectMake(20, frame.size.height-60, wbtn, hbtn) title:[btnTitle objectAtIndex:0] tag:2];
            [view addSubview:okBtn];
            
        }
    }
    
    
}

- (UIButton *)getBtn:(CGRect)_frame title:(NSString *)title tag:(int)tag
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = _frame;
    [btn1 setTitle:title forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 7.0;
    btn1.tag = tag;
    btn1.backgroundColor = RGB(242,242,242);
    [btn1 setTitleColor:RGB(128,128,128) forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn1;
}

- (void)buttonPressed:(UIButton *)sender
{
    if(self.callBack)
        self.callBack(@"",(int)sender.tag);
    [self removeFromSuperview];
}

- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        // 当前顶层窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        [window addSubview:self];
    }];
    [self showAlertAnimation];
    
}


-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [mainView.layer addAnimation:animation forKey:nil];
}

#pragma -mark keyboard notification

- (void)keyboardDidAppear:(NSNotification *)notification
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    
    NSDictionary *useInfo = [notification userInfo];
    NSValue *aValue = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    //获取键盘的y轴距离
    float yheight = ([UIScreen mainScreen].bounds.size.height) - keyboardRect.size.height;
    //获取输入控件的y轴距离
    CGRect rect=[self convertRect:self.bounds toView:window];
    float theight = rect.origin.y+rect.size.height;
    if(theight>yheight)
    {
        [UIView beginAnimations:nil context:nil];
        CGRect iframe = mainView.frame;
        iframe.origin.y = iframe.origin.y - (theight-yheight>0?theight-yheight+2:0);
        mainView.frame = iframe;
        [UIView setAnimationDuration:0.35];
        [UIView commitAnimations];
    }
}

@end
