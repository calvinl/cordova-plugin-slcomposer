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
    NSLog(@"compose:%@", command.arguments);
    
    [self.callbackIds setValue:command.callbackId forKey:@"compose"];
    
    NSDictionary *options = [command.arguments objectAtIndex:0];
    NSString *body = [options objectForKey:@"body"];
    NSString *type = [options objectForKey:@"type"];
    NSString *url  = [options objectForKey:@"url"];
    NSString *imageUrl = [options objectForKey:@"imageUrl"];
    NSString *serviceType = SLServiceTypeFacebook;

    if ([type isEqual:@"facebook"]) {
        serviceType = SLServiceTypeFacebook;
    }
    if ([type isEqual:@"twitter"]) {
        serviceType = SLServiceTypeTwitter;
    }

    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {

        SLComposeViewController *composerSheet = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [composerSheet setInitialText:body];

        if (imageUrl) {
            [composerSheet addImage:[UIImage imageNamed:imageUrl]];
        } else {
            [composerSheet addImage:nil];
        }
        if (url) {
            [composerSheet addURL:[NSURL URLWithString:url]];
        }

        [composerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {

            NSString *status = @"cancelled";
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    status = @"cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    status = @"done";
                    break;

                default:
                    break;
             }

            NSDictionary *results = [NSDictionary dictionaryWithObject:status forKey:@"result"];

            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:results];
	          [self writeJavascript:[pluginResult toSuccessCallbackString:[self.callbackIds valueForKey:@"compose"]]];

            [self.viewController dismissViewControllerAnimated:YES completion:nil];

        }];

        [self.viewController presentViewController:composerSheet animated:YES completion:nil];
    }
          
}


@end

