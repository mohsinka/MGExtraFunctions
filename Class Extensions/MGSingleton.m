//
//  MGSingleton.m
//  GroupSpends
//
//  Created by Vitaliy Gozhenko on 7/24/14.
//  Copyright (c) 2014 Tivogi. All rights reserved.
//

#import "MGSingleton.h"

@implementation MGSingleton

+ (instancetype)instance
{
  static dispatch_once_t once;
  static id instance;
  dispatch_once(&once, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

@end
