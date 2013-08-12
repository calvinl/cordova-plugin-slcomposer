//
//  TweetComposer.h
//
//  Created by Calvin Lai on 8/11/13.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface SocialComposer : CDVPlugin {

  NSMutableDictionary* callbackIds;
//    NSString * phoneNumber;
//    NSString * messageText;

}

@property (nonatomic, retain) NSMutableDictionary* callbackIds;
//@property (nonatomic, retain) NSString *phoneNumber;
//@property (nonatomic, retain) NSString *messageText;

- (void)compose:(CDVInvokedUrlCommand*)command;

@end
