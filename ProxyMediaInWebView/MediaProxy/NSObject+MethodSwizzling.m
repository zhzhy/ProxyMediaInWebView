//
//  NSObject+MethodSwizzling.m
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import "NSObject+MethodSwizzling.h"
#import "ClassMethodPair.h"
#import "objc/runtime.h"

@implementation NSObject (MethodSwizzling)

+ (void)replaceClassPair:(ClassMethodPair *)one withAnother:(ClassMethodPair *)another {
    Method originalMethod = class_getInstanceMethod(one.aClass, one.aSelector);
    Method overrideMethod = class_getInstanceMethod(another.aClass, another.aSelector);
    
    method_exchangeImplementations(originalMethod, overrideMethod);
}

- (void)replaceSelector:(SEL)oneSelector withClassPair:(ClassMethodPair *)another {
    ClassMethodPair *onePair = [[ClassMethodPair alloc] initWithClass:[self class] withSelector:oneSelector];
    [[self class] replaceClassPair:onePair withAnother:another];
}

@end
