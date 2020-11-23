#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(BePaid, UIViewController)

RCT_EXTERN_METHOD(processPayment:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(setAmount:(float)amount)

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;  // only do this if your module initialization relies on calling UIKit!
}

@end
