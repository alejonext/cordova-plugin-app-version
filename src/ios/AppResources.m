#import "AppResources.h"
#import <Cordova/CDVPluginResult.h>

@implementation AppResources

- (void)getAppName : (CDVInvokedUrlCommand *)command
{
    NSString * callbackId = command.callbackId;
    NSString * version =[[[NSBundle mainBundle]infoDictionary]objectForKey :@"CFBundleDisplayName"];
    CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)getPackageName:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* packageName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:packageName];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)getVersionNumber:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (version == nil) {
      NSLog(@"CFBundleShortVersionString was nil, attempting CFBundleVersion");
      version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
      if (version == nil) {
        NSLog(@"CFBundleVersion was also nil, giving up");
        // not calling error callback here to maintain backward compatibility
      }
    }

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)getVersionCode:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)getResources:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult;
    NSString *filePath;
    NSDictionary *dict;
    NSString *result;
    NSString *callbackId = command.callbackId;

    @try {
        NSString *resource = [command.arguments objectAtIndex:0];
        filePath = [[NSBundle mainBundle] pathForResource:@"strings" ofType:@"plist"];
        dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        result = [dict objectForKey:resource];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Is not a file or key"];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    }
}
@end
