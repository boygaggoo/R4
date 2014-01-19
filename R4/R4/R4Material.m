//
//  R4Material.m
//  R4
//
//  Created by Srđan Rašić on 18/01/14.
//  Copyright (c) 2014 Srđan Rašić. All rights reserved.
//

#import "R4Material.h"
#import "R4Technique.h"

@implementation R4Material

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.techniques = [NSMutableArray arrayWithObject:[[R4Technique alloc] init]];
  }
  return self;
}

- (instancetype)initWithTechniques:(NSArray *)techniques
{
  self = [super init];
  if (self) {
    for (id technique in techniques) {
      NSAssert([technique isKindOfClass:[R4Technique class]], @"Techniques array must contain only instances of class R4Technique or its descendants.");
    }
    self.techniques = [techniques mutableCopy];
  }
  return self;
}

- (R4Technique *)optimalTechnique
{
  for (R4Technique *technique in self.techniques) {
    if ([technique isUsable]) {
      return technique;
    }
  }
  return nil;
}

- (R4Technique *)firstTechnique
{
  return [self.techniques firstObject];
}

- (R4Technique *)techniqueAtIndex:(NSUInteger)index
{
  return [self.techniques objectAtIndex:index];
}

@end
