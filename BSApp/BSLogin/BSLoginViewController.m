//
//  BSLoginViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/20.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSLoginViewController.h"
#import "BSHeader.h"
#import "BSLoginTextField.h"

@interface BSLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) BSLoginTextField *userNameField;

@property (nonatomic, strong) BSLoginTextField *passwdField;


@end

@implementation BSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}


- (void)setupSubViews
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:blurEffectView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(20, 20, 16, 16);
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"home_pop_tip_close"] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.userNameField = [[BSLoginTextField alloc]initWithFrame:CGRectMake(90, 100, 200, 40)];
    self.userNameField.tintColor = [UIColor whiteColor];
    self.userNameField.layer.cornerRadius = 8.0;
    self.userNameField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.userNameField.placeholder = @"请输入用户名";
    self.userNameField.delegate = self;
    [self.view addSubview:self.userNameField];
    
    self.passwdField = [[BSLoginTextField alloc]initWithFrame:CGRectMake(90, 150, 200, 40)];
    self.passwdField.tintColor = [UIColor whiteColor];
    self.passwdField.layer.cornerRadius = 8.0;
    self.passwdField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.passwdField.placeholder = @"请输入密码";
    self.passwdField.delegate = self;
    [self.view addSubview:self.passwdField];
    
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(70, 270, 240, 40);
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(clickToLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 210, 100, 40)];
    label.text = @"忘记密码？";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.userNameField becomeFirstResponder];
}

- (void)dissMiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickToLogin
{
    
}

@end
