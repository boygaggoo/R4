//
//  R4Entity.m
//  R4
//
//  Created by Srđan Rašić on 19/01/14.
//  Copyright (c) 2014 Srđan Rašić. All rights reserved.
//

#import "R4EntityNode.h"
#import "R4Mesh.h"

@implementation R4EntityNode

+ (R4EntityNode *)entityWithMesh:(R4Mesh *)mesh
{
  R4EntityNode *entity = [[[self class] alloc] init];
  entity.mesh = mesh;
  return entity;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  R4EntityNode *node = [super copyWithZone:zone];
  node.mesh = self.mesh;
  node.material = self.material;
  return node;
}

- (R4Box)boundingBox
{
  return self.mesh.geometryBoundingBox;
}

- (R4Material *)material
{
  if (_material == nil) {
    return self.mesh.material;
  } else {
    return _material;
  }
}

- (void)prepareToDraw
{
}

- (void)drawPass
{
  if ((self.mesh->indexBuffer != GL_INVALID_VALUE)) {
    glDrawElements(GL_TRIANGLES, self.mesh->elementCount, GL_UNSIGNED_SHORT, BUFFER_OFFSET(0));
  } else {
    glDrawArrays(GL_TRIANGLES, 0, self.mesh->elementCount);
  }
}

@end
