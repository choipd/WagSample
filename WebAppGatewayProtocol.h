//
//  WebAppGatewayProtocolDelegate.h
//  ImIn
//
//  Created by Myungjin Choi on 11. 9. 28..
//  Copyright 2011년 KTH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebAppGatewayProtocolDelegate <NSObject>
@required
- (void) closeVC;
@optional
- (BOOL) willProcessUiDescriptionWithData:(NSDictionary*) data;
- (BOOL) didProcessUiDescriptionWithData:(NSDictionary*) data;
- (BOOL) willProcessAppRequestWithData:(NSDictionary*) data;
- (BOOL) didProcessAppRequestWithData:(NSDictionary*) data;
@end

@interface WebAppGatewayProtocol : NSObject {
    __weak id<WebAppGatewayProtocolDelegate> delegate;
    UIWebView* whichWebView;
    UIViewController* whichVC;
}

@property (weak) id<WebAppGatewayProtocolDelegate> delegate;
@property (nonatomic, retain) UIWebView* whichWebView;
@property (nonatomic, retain) UIViewController* whichVC;


- (BOOL) processWithUrl:(NSURL*) url;
- (NSDictionary* ) parseWithUrl:(NSURL*) url;

@end