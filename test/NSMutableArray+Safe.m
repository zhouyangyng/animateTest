//
//  NSMutableArray+Safe.m
//  test
//
//  Created by 周洋 on 2018/3/4.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Safe)

+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
//        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
//        [obj swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
//        [obj swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
//        [obj swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safeReplaceObjectAtIndex:withObject:)];
    });
    
}


- (void)safeAddObject:(id)anObject
{
    if (anObject) {
        [self safeAddObject:anObject];
    }else{
        NSLog(@"obj is nil");
        
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
