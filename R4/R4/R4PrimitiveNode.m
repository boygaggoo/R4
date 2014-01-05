//
//  R4PrimitiveNode.m
//  R4
//
//  Created by Srđan Rašić on 9/29/13.
//  Copyright (c) 2013 Srđan Rašić. All rights reserved.
//

#import "R4Base.h"
#import "R4Renderer.h"
#import "R4DrawableNode_private.h"
#import "R4Node_private.h"
#import "R4PrimitiveNode.h"

@implementation R4PrimitiveNode

GLfloat gCubeVertexData[216] =
{
  // Data layout for each line below is:
  // positionX, positionY, positionZ,     normalX, normalY, normalZ,
  0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,
  0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
  0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
  0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
  0.5f, 0.5f, -0.5f,          1.0f, 0.0f, 0.0f,
  0.5f, 0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
  
  0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,
  -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
  0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
  0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
  -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
  -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,
  
  -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,
  -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
  -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
  -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
  -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
  -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,
  
  -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,
  0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
  -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
  -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
  0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
  0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,
  
  0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,
  -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
  0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
  0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
  -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
  -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,
  
  0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,
  -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
  0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
  0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
  -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
  -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f
};

GLfloat gPlainVertexData[48] =
{
  0.5f, 0.5f, 0.0f,          0.0f, 0.0f, 1.0f,   1.0f, 1.0,
  -0.5f, 0.5f, 0.0f,         0.0f, 0.0f, 1.0f,   0.0f, 1.0,
  0.5f, -0.5f, 0.0f,         0.0f, 0.0f, 1.0f,   1.0f, 0.0,
  0.5f, -0.5f, 0.0f,         0.0f, 0.0f, 1.0f,   1.0f, 0.0,
  -0.5f, 0.5f, 0.0f,         0.0f, 0.0f, 1.0f,   0.0f, 1.0,
  -0.5f, -0.5f, 0.0f,        0.0f, 0.0f, 1.0f,   0.0f, 0.0,
};

+ (instancetype)boxWithSize:(GLKVector3)size
{
  return [[[self class] alloc] initBoxWithSize:size];
}

+ (instancetype)plainWithSize:(CGSize)size
{
  return [[[self class] alloc] initPlainWithSize:size];
}

- (instancetype)initBoxWithSize:(GLKVector3)size
{
  self = [super init];
  if (self) {
    
    self.drawableObject = [[R4DrawableObject alloc] init];
    self.drawableObject->elementCount = 36;
    
    glGenVertexArraysOES(1, &self.drawableObject->vertexArray);
    glBindVertexArrayOES(self.drawableObject->vertexArray);
    
    glGenBuffers(1, &self.drawableObject->vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, self.drawableObject->vertexBuffer);
    
    GLfloat vertexData[sizeof(gCubeVertexData)];
    for (int i = 0; i < sizeof(gCubeVertexData); i=i+6) {
      vertexData[i+0] = gCubeVertexData[i+0] * size.x;
      vertexData[i+1] = gCubeVertexData[i+1] * size.y;
      vertexData[i+2] = gCubeVertexData[i+2] * size.z;
      vertexData[i+3] = gCubeVertexData[i+3];
      vertexData[i+4] = gCubeVertexData[i+4];
      vertexData[i+5] = gCubeVertexData[i+5];
    }
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), vertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));

    glBindVertexArrayOES(0);
    
    self.drawableObject.geometryBoundingBox = R4BoxMake(GLKVector3Make(-.5f, -.5f, -.5f), GLKVector3Make(.5f, .5f, .5f));
  }
  return self;
}

- (instancetype)initPlainWithSize:(CGSize)size
{
  self = [super init];
  if (self) {
    
    self.drawableObject = [[R4DrawableObject alloc] init];
    self.drawableObject->elementCount = 6;
    
    glGenVertexArraysOES(1, &self.drawableObject->vertexArray);
    glBindVertexArrayOES(self.drawableObject->vertexArray);
    
    glGenBuffers(1, &self.drawableObject->vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, self.drawableObject->vertexBuffer);
    
    GLfloat vertexData[sizeof(gPlainVertexData)];
    for (int i = 0; i < sizeof(gPlainVertexData); i=i+8) {
      vertexData[i+0] = gPlainVertexData[i+0] * size.width;
      vertexData[i+1] = gPlainVertexData[i+1];
      vertexData[i+2] = gPlainVertexData[i+2] * size.height;
      vertexData[i+3] = gPlainVertexData[i+3];
      vertexData[i+4] = gPlainVertexData[i+4];
      vertexData[i+5] = gPlainVertexData[i+5];
      vertexData[i+6] = gPlainVertexData[i+6];
      vertexData[i+7] = gPlainVertexData[i+7];
    }
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(gPlainVertexData), vertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 8, BUFFER_OFFSET(0));
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE,  sizeof(GLfloat) * 8, BUFFER_OFFSET(12));
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE,  sizeof(GLfloat) * 8, BUFFER_OFFSET(24));
    
    NSDictionary* options = @{GLKTextureLoaderOriginBottomLeft:[NSNumber numberWithBool:YES],
                              GLKTextureLoaderGenerateMipmaps: [NSNumber numberWithBool:NO]};
    GLKTextureInfo *texture = [GLKTextureLoader textureWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"spark" ofType:@"png"] options:options error:nil];
    
    if (texture) {
      self.drawableObject.effect.texture2d0.name = texture.name;
      self.drawableObject.effect.texture2d0.enabled = GL_TRUE;
      self.drawableObject.effect.texture2d0.envMode = GLKTextureEnvModeModulate;
      self.drawableObject.effect.colorMaterialEnabled = GL_TRUE;
    }
    
    glBindVertexArrayOES(0);
    
    self.drawableObject.geometryBoundingBox = R4BoxMake(GLKVector3Make(-.5f, -.1f, -.5f), GLKVector3Make(.5f, .1f, .5f));
  }
  return self;
}

@end
