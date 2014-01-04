//
//  ParticleShader.vsh
//
//  Created by Srdan Rasic on 25/12/13.
//  Copyright (c) 2013 Srdan Rasic. All rights reserved.
//

uniform mat4 model_view_projection_matrix;

attribute vec4 position;
attribute mediump vec2 texcoord;

attribute float instanceAlpha;
attribute vec4  instanceColor;
attribute float instanceColorBlendFactor;
attribute mat4  instanceMVM;

//varying lowp float  out_alpha;
varying lowp vec4   out_color;
varying lowp vec2   out_texcoord;
varying lowp float  out_colorBlendFactor;

void main()
{
//  out_alpha = instanceAlpha;
  out_color = instanceColor * vec4(1.0, 1.0, 1.0, instanceAlpha);
  out_texcoord = texcoord;
  out_colorBlendFactor = instanceColorBlendFactor;
  
  gl_Position = model_view_projection_matrix * instanceMVM * position;
}
