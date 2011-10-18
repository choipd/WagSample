//
//  BizWebViewController.h
//  ImIn
//
//  Created by Myungjin Choi on 11. 10. 11..
//  Copyright 2011년 KTH. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WebAppGatewayProtocol.h"

@interface BizWebViewController : UIViewController <UIWebViewDelegate, WebAppGatewayProtocolDelegate> {
    
    IBOutlet UIWebView* aWebView;
    
    IBOutlet UILabel* titleLabel;
    IBOutlet UIButton* leftBtn;
    IBOutlet UIButton* rightBtn;
    
    __weak IBOutlet UITextField *urlTextField;
    WebAppGatewayProtocol* wagw;
    
    NSString* titleString;
    NSString* urlString;
    NSString* left_jscall;
    NSString* right_jscall;
}

@property (nonatomic, retain) NSString* urlString;
@property (nonatomic, retain) NSString* titleString;
@property (nonatomic, retain) NSString* left_jscall;
@property (nonatomic, retain) NSString* right_jscall;

- (IBAction)goUrl:(id)sender;
- (IBAction) closeVC;
- (IBAction) leftBtnClick;
- (IBAction) rightBtnClick;

@end
