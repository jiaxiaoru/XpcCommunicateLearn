//
//  XpcService.h
//  XpcService
//
//  Created by Judith on 2019/11/6.
//  Copyright © 2019 Judith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XpcServiceProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XpcService : NSObject <XpcServiceProtocol>

@property NSXPCConnection *xpcConnect;

@end
