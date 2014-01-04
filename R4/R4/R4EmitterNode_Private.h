//
//  R4EmitterNode_Private.h
//  R4
//
//  Created by Srđan Rašić on 25/12/13.
//  Copyright (c) 2013 Srđan Rašić. All rights reserved.
//

#import "R4EmitterNode.h"
#import "R4PrimitiveNode.h"

typedef enum {
  R4VertexAttribPosition,
  R4VertexAttribTexCoord,
  R4VertexAttribColor,
  R4VertexAttribColorBlendFactor,
  R4VertexAttribAlpha,
  R4VertexAttribMVM
} R4VertexAttrib;

typedef struct {
  GLKMatrix4 MVM;
  GLKVector4 color;
  GLKVector3 direction;
  CGFloat colorBlendFactor;
  CGFloat alpha;
  
  CGFloat lifetime;
  CGFloat timeToLive;
  GLKVector3 initialPosition;
  CGFloat initialScale;
  CGFloat initialAlpha;
  CGFloat speed;
} R4ParticleAttributes;

@interface R4EmitterNode () {
  @public
  GLuint particleAttributesVertexBuffer;
  GLuint particleAttributesVertexArray;
  NSInteger maxParticeCount;
}

@property (nonatomic, assign) NSInteger particleCount;
@property (nonatomic, assign) R4ParticleAttributes *particleAttributes;
@property (strong, nonatomic) R4PrimitiveNode *particleDrawable;

- (void)updateAtTime:(NSTimeInterval)time;

@end
