//
//  ClassMethodPair.h
//  TTPod
//
//  Created by chaoyang.zhang on 14-2-18.
//
//

#import <Foundation/Foundation.h>

@interface ClassMethodPair : NSObject

@property(nonatomic, assign, readonly) Class aClass;
@property(nonatomic, assign, readonly) SEL aSelector;

+ (id)classMethodPairWithClass:(Class)oneClass withSelector:(SEL)oneSelector;

- (id)initWithClass:(Class)oneClass withSelector:(SEL)oneSelector;
@end
