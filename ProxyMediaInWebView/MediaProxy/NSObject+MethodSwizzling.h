//
//  NSObject+MethodSwizzling.h
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import <Foundation/Foundation.h>

@class ClassMethodPair;

@interface NSObject (MethodSwizzling)

+ (void)replaceClassPair:(ClassMethodPair *)one withAnother:(ClassMethodPair *)another;
- (void)replaceSelector:(SEL)oneSelector withClassPair:(ClassMethodPair *)another;
@end
