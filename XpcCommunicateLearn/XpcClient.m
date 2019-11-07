//
//  XpcClient.m
//  XpcCommunicateLearn
//
//  Created by Judith on 2019/11/6.
//  Copyright © 2019 Judith. All rights reserved.
//

#import "XpcClient.h"

@interface XpcClient()

@property NSXPCConnection *connectionToService;
@property NSMutableArray <NSXPCConnection *>*connections;
@end

@implementation XpcClient
- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建单个xpc
        [self createConnect];
        //创建多个xpc
//        [self createConnects];
    }
    return self;
}

- (void)createConnect {
    _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"JJ.XpcService"];
    _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XpcServiceProtocol)];
    _connectionToService.exportedObject = self;
    _connectionToService.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XpcClientProtocol)];
    [_connectionToService resume];
    
    /*
     [_connectionToService remoteObjectProxy] 返回 <__NSXPCInterfaceProxy_XpcServiceProtocol: 0x600002110aa0>对象
     调用service端实现XpcServiceProtocol协议的类的方法（即调用XpcService.m的方法）
     */
    [[_connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
        // We have received a response. Update our text field, but do it on the main thread.
        NSLog(@"result from server is: %@", aString);
    }];
}


- (void)createConnects {
    _connections = [NSMutableArray arrayWithCapacity:5];
    for (int i = -1; i < 4; i++) {
        NSString *serviceName = i == -1 ? @"JJ.XpcService":[NSString stringWithFormat:@"JJ.XpcService%d",i];
        NSXPCConnection *connection = [[NSXPCConnection alloc] initWithServiceName:serviceName];
        [_connections addObject:connection];
        connection.exportedObject = self;
        connection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XpcClientProtocol)];
        connection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XpcServiceProtocol)];
        [connection resume];
        
        [[connection remoteObjectProxy] upperCaseString:[NSString stringWithFormat:@"This is connect number %d",i] withReply:^(NSString *result) {
            NSLog(@"result from service :%@, current thread is %@",result,[NSThread currentThread]);
        }];
    }
}
#pragma mark - <XpcClientProtocol>

-(void)addNumbers:(NSArray <NSNumber *>*)numbers withReply:(void (^)(NSInteger))reply {
    __block NSInteger sum = 0;
    [numbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull number, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += number.intValue;
    }];
    reply(sum);
}

@end
