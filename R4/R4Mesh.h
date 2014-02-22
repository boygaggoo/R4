//
//  R4Mesh.h
//  R4
//
//  Created by Srđan Rašić on 19/01/14.
//  Copyright (c) 2014 Srđan Rašić. All rights reserved.
//

#import "R4Base.h"

@class R4Material;

@interface R4Mesh : NSObject {
@public
  GLuint vertexArray;
  GLuint vertexBuffer;
  GLuint indexBuffer;
  GLuint vertexCount;
  GLuint elementCount;
  GLuint stride;
  BOOL hasTextures;
  BOOL hasNormals;
}

@property (nonatomic, strong) R4Material *material;
@property (assign, nonatomic) R4Box geometryBoundingBox;

+ (R4Mesh *)boxWithSize:(GLKVector3)size;
+ (R4Mesh *)planeWithSize:(CGSize)size;
+ (R4Mesh *)OBJMeshNamed:(NSString *)name normalize:(BOOL)normalize center:(BOOL)center;

@end
