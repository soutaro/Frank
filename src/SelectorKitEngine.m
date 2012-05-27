//
//  SelectorKitEngine.m
//  Frank
//
//  Created by 宗太郎 松本 on 12/05/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectorKitEngine.h"
#import "STLexer.h"
#import "STParser.h"
#import "STSelector.h"
#import "SKViewSelectorEngine.h"

@implementation SelectorKitEngine

+(void)load{
	SelectorKitEngine* engine = [self new];
	[SelectorEngineRegistry registerSelectorEngine:engine WithName:@"selectorkit"];
}

- (NSArray *) selectViewsWithSelector:(NSString *)selector {
    NSLog( @"Using SelectorKit to select views with selector: %@", selector );
	
	STLexer* lexer = [[STLexer alloc] initWithString:selector];
	STParser* parser = [STParser newParserWithLexer:lexer];
	STSelector* s = [parser parseSelectorWithParent:nil];
	
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	return [SKViewSelectorEngine selectViewsWithSelector:s fromView:window];
}

@end
