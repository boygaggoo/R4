//
//  R4View_.h
//  R4
//
//  Created by Srđan Rašić on 9/29/13.
//  Copyright (c) 2013 Srđan Rašić. All rights reserved.
//

#import "R4View.h"

@class R4Renderer;

@interface R4View ()

@property (nonatomic) GLKMatrix4 projectionMatrix;
@property (nonatomic, strong) NSMutableArray *responderChain;

@end
