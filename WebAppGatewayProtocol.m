//
//  WebAppGatewayProtocol.m
//  ImIn
//
//  Created by Myungjin Choi on 11. 10. 5..
//  Copyright 2011년 KTH. All rights reserved.
//

#import "WebAppGatewayProtocol.h"
#import "NSString+URLEncoding.h"

@implementation WebAppGatewayProtocol

@synthesize delegate;
@synthesize whichVC, whichWebView;

// TODO: UI관련 공통 처리 모듈을 여기에 놓자
- (BOOL) processUiDescriptionWithData:(NSDictionary*) data
{
    return YES;
}

// TODO: 앱내 호출 관련, 공통 처리 모듈을 여기 놓자
- (BOOL) processAppRequestWithData:(NSDictionary*) data
{
    return YES;
}

- (BOOL) processWithUrl:(NSURL*) url
{
    BOOL willContinue = NO;
    NSDictionary* data = [self parseWithUrl:url];
    
    if (self.delegate == nil) {
        return YES;
    }
    
    if (data == nil) {
        return YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(willProcessUiDescriptionWithData:)]) {
        willContinue = [self.delegate willProcessUiDescriptionWithData:data];
    }
    
    if (willContinue == NO) {
        return NO;
    }
    
    willContinue = [self processUiDescriptionWithData:data];

    if (willContinue == NO) {
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(didProcessUiDescriptionWithData:)]) {
        willContinue = [self.delegate didProcessUiDescriptionWithData:data];
    }
    
    if (willContinue == NO) {
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(willProcessAppRequestWithData:)]) {
        willContinue = [self.delegate willProcessAppRequestWithData:data];
    }
    
    if (willContinue == NO) {
        return NO;
    }
    
    willContinue = [self processAppRequestWithData:data];
    
    if (willContinue == NO) {
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(didProcessAppRequestWithData:)]) {
        willContinue = [self.delegate didProcessAppRequestWithData:data];
    }
    
    if (willContinue == NO) {
        return NO;
    }
    
    return YES;
}

- (NSDictionary* ) parseWithUrl:(NSURL*) url
{
	NSString* urlBody = [[[url absoluteString] componentsSeparatedByString:@"//"] lastObject];
    urlBody = [urlBody URLDecodedString];
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    
    NSString* key = nil;
    NSString* value = nil;
    NSArray* keyValues;
    
    [mutableDictionary setObject:url forKey:@"URL"];
    
    if (urlBody == nil) {
        [mutableDictionary setObject:@"error" forKey:@"schemename"]; //스키마이름 저장
        return mutableDictionary;
    }
    
    NSArray* parts = [urlBody componentsSeparatedByString:@"?"];
    if ([parts count] == 1) {
        [mutableDictionary setObject:[parts objectAtIndex:0] forKey:@"schemename"];
        keyValues = [[parts objectAtIndex:0] componentsSeparatedByString:@"/"];
    } else if ([parts count] == 2) {
        [mutableDictionary setObject:[parts objectAtIndex:0] forKey:@"schemename"];
        keyValues = [[parts objectAtIndex:1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
    }

    for (int i=0; i < [keyValues count]; i++) {
        if (i % 2 == 0) {
            // key
            key = [keyValues objectAtIndex:i];
        } else {
            // value
            value = [keyValues objectAtIndex:i];
            [mutableDictionary setObject:value forKey:key];
        }
    }
    
    NSLog(@"mutableDictionary = %@", mutableDictionary);
	return mutableDictionary;
}


#pragma mark - 아임IN 프로토콜
- (void) apiFailedWhichObject:(NSObject *)theObject {
    
}

- (void) closeVC {
    if ([self.delegate respondsToSelector:@selector(closeVC)]) {
        [self.delegate closeVC];
    }
}

- (void) apiDidLoadWithResult:(NSDictionary *)result whichObject:(NSObject *)theObject {
    
    if ([[result objectForKey:@"func"] isEqualToString:@"homeInfo"]) {
    }
    
}

@end
