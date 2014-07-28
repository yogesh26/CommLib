//
//  ServiceCaller.h
//  connectionblockexample
//
//  Created by Chris Risner on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceCaller : NSObject <NSURLConnectionDelegate> {
    @private 
        NSMutableData* _receivedData;
        NSMutableDictionary* callbacks;
}

-(ServiceCaller*) init;
-(void) postToUrl: (NSString*) url withBody: (NSData*) body
     withCallback: (void(^) (NSMutableData* response)) callback;

@end