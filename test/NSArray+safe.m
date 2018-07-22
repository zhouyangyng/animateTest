//
//  NSArray+safe.m
//  test
//
//  Created by 周洋 on 2018/3/4.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "NSArray+safe.h"
#import <objc/runtime.h>

@implementation NSArray (safe)


+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        
        [obj swizzleMethod:@selector(indexOfObject:) withMethod:@selector(safeIndexOfObject:)];
    });
}

-(NSUInteger)safeIndexOfObject:(id)anObject {
    
    if (![self containsObject:anObject]) {
        NSLog(@"index");
        return 111;
    }
    return [self safeIndexOfObject:anObject];
}

-(id)safeObjectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        NSLog(@"out of array bounds");
        return [[NSObject alloc]init];
    }else {
        return [self safeObjectAtIndex:index];
    }
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
