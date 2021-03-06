//
//  R4Scene.m
//  R4
//
//  Created by Srđan Rašić on 9/29/13.
//  Copyright (c) 2013 Srđan Rašić. All rights reserved.
//

#import "R4ScenePrivate.h"
#import "R4NodePrivate.h"
#import "R4ViewPrivate.h"
#import "R4CameraNodePrivate.h"
#import "R4EmitterNodePrivate.h"
#import "R4DefaultSceneManager.h"

@implementation R4Scene

+ (instancetype)sceneWithSize:(CGSize)size
{
  return [[[self class] alloc] initWithSize:size];
}

- (instancetype)initWithSize:(CGSize)size
{
  self = [super init];
  if (self) {
    self.size = size;
    self.anchorPoint = CGPointMake(0, 0);
    self.scaleMode = R4SceneScaleModeResizeFill;
    self.backgroundColor = [R4Color colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    self.currentCamera = [R4CameraNode cameraAtPosition:GLKVector3Make(0, 1, 2) lookingAt:GLKVector3Make(0, 0, 0)];
    self.sceneManager = [[R4DefaultSceneManager alloc] initWithScene:self];
    self.particleEmitters = [NSMutableSet set];
  }
  return self;
}

- (R4Scene *)scene
{
  return self;
}

- (GLKVector3)position
{
  return GLKVector3Make(0, 0, 0);
}

- (R4Sphere)calculateAccumulatedBoundingSphere
{
  return R4SphereZero;
}

- (void)setSize:(CGSize)size
{
  if (!CGSizeEqualToSize(_size, size)) {
    _size = size;
    [self didChangeSize:size];
  }
}

#pragma mark - Instance methods

- (void)didChangeSize:(CGSize)oldSize
{
}

- (void)didMoveToView:(R4View *)view
{
}

- (void)willMoveFromView:(R4View *)view
{
}

- (void)didEvaluateActions
{
}

- (void)didSimulatePhysics
{
}

- (void)update:(NSTimeInterval)currentTime
{
}

- (void)updateParticleEmittersAtTime:(NSTimeInterval)time
{
  for (id emitter in _particleEmitters) {
    [emitter updateAtTime:time];
  }
}

#pragma mark - UIResponder overrides

- (R4Node *)hitTest:(R4Ray)ray event:(UIEvent *)event
{
  R4Node *node = [super hitTest:ray event:event];
  
  if (node == self) {
    return nil;
  } else {
    return node;
  }
}

- (UIResponder *)nextResponder
{
  return self.view;
}

@end
