//
//  StateObject.h
//  connectionblockexample
//
//  Created by Chris Risner on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateObject : NSObject
@property (nonatomic, copy) void (^ callbackBlock)(NSMutableData *response);
@property (nonatomic, retain) NSMutableData* receivedData;
@end
