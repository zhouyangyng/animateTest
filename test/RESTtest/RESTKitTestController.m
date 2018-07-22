//
//  RESTKitTestController.m
//  test
//
//  Created by 周洋 on 2018/6/10.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "RESTKitTestController.h"
#import <RestKit/RestKit.h>
#import "Factory.h"

@interface RESTKitTestController ()

@end

@implementation RESTKitTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:<#(CGRect)#> byRoundingCorners:uirectcor cornerRadii:<#(CGSize)#>]
    
//    @"http://api.changfangzaixian.com/v2/rent/detail&id=52130"
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNetworkData];
}

- (void)loadNetworkData {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Factory class]];
    
    [mapping addAttributeMappingsFromArray:@[@"city", @"address", @"phone", @"title", @"area"]];
    
    NSIndexSet *statusCode = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
//    AFRKHTTPClient *client = [AFRKHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://api.changfangzaixian.com"]];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://api.changfangzaixian.com"]];
    
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:@"/v2/rent/list" keyPath:@"data.list" statusCodes:statusCode];
    // ObjedtManager添加descriptor
    [manager addResponseDescriptor:descriptor];
    
    //开始loadData
    NSDictionary *para = @{@"cityId": @"320200"};
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/rent/list" parameters:para success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        Factory *fac = mappingResult.firstObject;
        
        NSLog(@"%@", [fac description]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

@end






