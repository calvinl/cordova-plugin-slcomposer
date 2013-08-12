//
//  SocialComposer.m
//  Helper
//
//  Created by Calvin Lai on 7/17/13.
//
//

#import "SocialComposer.h"
#import <Cordova/CDVViewController.h>
#import <Cordova/CDVDebug.h>


@implementation SocialComposer

@synthesize callbackIds = _callbackIds;

- (NSMutableDictionary*)callbackIds {
	if(_callbackIds == nil) {
		_callbackIds = [[NSMutableDictionary alloc] init];
	}
	return _callbackIds;
}

- (void)compose:(CDVInvokedUrlCommand*)command {
    NSLog(@"showComposer:%@", command.arguments);
    
    [self.callbackIds setValue:command.callbackId forKey:@"composeTweet"];
    
    NSDictionary *options = [command.arguments objectAtIndex:0];
    NSString *body = [options objectForKey:@"body"];
    NSString *type = [options objectForKey:@"type"];


    NSString *serviceType = SLServiceTypeFacebook;

    if (type == @"facebook") {
        serviceType = SLServiceTypeFacebook;
    }
    if (type == @"twitter") {
        serviceType = SLServiceTypeTwitter;
    }

   if ([SLComposeViewController isAvailableForServiceType:serviceType]) {

        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:serviceType];

        [mySLComposerSheet setInitialText:body];

        //[mySLComposerSheet addImage:[UIImage imageNamed:@"myImage.png"]];
        [mySLComposerSheet addURL:[NSURL URLWithString:@"http://wunwun.com"]];

        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {

             switch (result) {
                 case SLComposeViewControllerResultCancelled:
                     NSLog(@"Post Canceled");
                     break;
                 case SLComposeViewControllerResultDone:
                     NSLog(@"Post Sucessful");
                     break;

                 default:
                     break;
             }
         }];

        //[self presentViewController:mySLComposerSheet animated:YES completion:nil];
        [self.viewController presentModalViewController:mySLComposerSheet animated:YES];
    }
          
}


@end

