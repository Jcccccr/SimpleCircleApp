//
//  BSComicWebViewController.m
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSComicWebViewController.h"
#import <WebKit/WebKit.h>
#import "BSHeader.h"

@interface BSComicWebViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation BSComicWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BSGlobalColor;
    self.webView = [[WKWebView alloc]init];
    self.webView.frame = self.view.bounds;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrlString]]];
    [self.view addSubview:self.webView];
}


// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = webView.title;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    self.title = webView.title;
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    
    if (navigationAction.navigationType==WKNavigationTypeBackForward) {//判断是返回类型
        
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮 这里可以监听左滑返回事件，仿微信添加关闭按钮。
//        self.navigationItem.leftBarButtonItems = @[self.backBtn, self.closeBtn];
        //可以在这里找到指定的历史页面做跳转
//        if (webView.backForwardList.backList.count>0) {                                  //得到栈里面的list
//            DLog(@"%@",webView.backForwardList.backList);
//            DLog(@"%@",webView.backForwardList.currentItem);
//            WKBackForwardListItem * item = webView.backForwardList.currentItem;          //得到现在加载的list
//            for (WKBackForwardListItem * backItem in webView.backForwardList.backList) { //循环遍历，得到你想退出到
//                //添加判断条件
//                [webView goToBackForwardListItem:[webView.backForwardList.backList firstObject]];
//            }
//        }
    }
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}


@end
