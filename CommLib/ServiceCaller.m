//
//  ServiceCaller.m
//  connectionblockexample
//
//  Created by Chris Risner on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceCaller.h"
#import "StateObject.h"
#import <UIKit/UIKit.h>
@implementation ServiceCaller

-(ServiceCaller*) init {
    callbacks = [[NSMutableDictionary alloc] init];
    return self;
}

-(void) postToUrl:(NSString *)url withBody:(NSData *)body 
     withCallback: (void (^)( NSMutableData*))callback {
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	[req setHTTPMethod:@"POST"];
	[req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[req setHTTPBody:body];
    NSURLConnection *conn = [[NSURLConnection alloc] 
                             initWithRequest: req delegate:self];
    StateObject* connectionState = [[StateObject alloc] init];
    connectionState.receivedData = [[NSMutableData alloc] init];
    [connectionState.receivedData setLength:0];
    connectionState.callbackBlock = callback;
    [callbacks setValue:connectionState forKey:[NSString stringWithFormat:@"%i", conn.hash]];
}

#pragma NSUrlConnectionDelegate Methods

-(void)connection:(NSConnection*)conn didReceiveResponse:
(NSURLResponse *)response 
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:
(NSData *)data
{
    StateObject* connectionState = [callbacks objectForKey:[NSString stringWithFormat:@"%i", connection.hash]];
    [connectionState.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:
(NSError *)error
{    
    //Naive error handling - log it!
//    NSLog(@"Connection failed! Error - %@ %@",
//          [error localizedDescription],
//          [[error userInfo] objectForKey:
//           NSURLErrorFailingURLStringErrorKey]);
//    
    // inform the user
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Connection Failure" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   
    NSString* connectionHash = [NSString stringWithFormat:@"%i", connection.hash];    
    StateObject* connectionState = [callbacks objectForKey:connectionHash];    
    //NSString *txt = [[NSString alloc] initWithData:connectionState.receivedData
    //                                      encoding: NSASCIIStringEncoding];    
    connectionState.callbackBlock(connectionState.receivedData);
    [callbacks removeObjectForKey:connectionHash];
    
}

@end