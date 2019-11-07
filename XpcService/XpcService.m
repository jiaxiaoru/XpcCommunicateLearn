//
//  XpcService.m
//  XpcService
//
//  Created by Judith on 2019/11/6.
//  Copyright © 2019 Judith. All rights reserved.
//

#import "XpcService.h"

@implementation XpcService

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
    
    [[_xpcConnect remoteObjectProxy] addNumbers:@[@3,@4,@5,@6,@90] withReply:^(NSInteger sum) {
        NSLog(@"result from client is %ld",(long)sum);
    }];
}

@end
