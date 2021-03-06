R4: A SpriteKit in 3D
---------------------

<p align="center">
  <img src="https://dl.dropboxusercontent.com/u/25219211/r4ss.png" />
</p>

R4 is a 3D graphics rendering and animation library based on Apple's SpriteKit Framework. Goal of the library is to ease creation of 3D games and applications by providing the infrastructure whose interface resembles interface of the SpriteKit. Someone who is familiar with SpriteKit shouldn't have any problems working with this library. Concepts that apply to SpriteKit also apply to R4, just with additional space dimension. R4 is not an extension of the SpriteKit, but a separate library.

The library is in an early phase of the development and lacks some of the SpriteKit's counterparts, most notably physical subsystem, but it's usable for the creation of a simple 3D scenes. It provides scene graph infrastructure with drawable nodes like entities and particle emitters, non-drawable nodes like cameras and lights, and scene managers to organize and improve rendering process. Scene nodes are responder objects and can handle touch events defined by the UIResponder class, just like SKNodes.

R4's rendering system is designed to allow easy extension. Main renderer handles basic viewport configuration, frame buffer management and does scene traversal with a help from the scene manager, but forwards actual drawing responsibility to more extendable and configurable components - materials, techniques and passes. A material encapsulates all information on how to render an object, including all possible ways to do it. A technique describes a way to render an object. It does that by specifying one or more passes that perform rendering. Individual passes do actual rendering using shaders and OpenGL framework.

To learn more about R4 check out [Getting started](https://github.com/srdanrasic/R4/wiki/Getting-started) page on Wiki. Continue by reading [classes' reference pages](http://srdanrasic.github.io/R4/docs/). If you're new to the game development consider reading Apple's [Sprite Kit Programming Guide](https://developer.apple.com/library/mac/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html). It provides great starting point and most of the concepts described there apply to R4.


Features
--------

* SpriteKit based design.
* **A node tree** based representation of the scene content. See R4Node and R4Scene for more info.
* The nodes are **responder objects** - they can receive touch events. See R4Node for more info.
* Support for **action** based animations and logic. See R4Action for more info.
* **Particle emitters** compatible with Xcode particle editor. See R4EmitterNode for more info.
* **OBJ mesh file loader** for files that contain one polygon group and one texture. See R4Mesh for more info.
* **User-extendable rendering system** for custom effects. See R4Material, R4Technique and R4Pass for more info.

Planned or in progress
----------------------

* Full NSCopying and NSCoding compliance.
* Support for more 3D file formats and extended OBJ file loader.
* Extended collection of R4Action classes.
* Scene and camera transition support based on SKTransition class.
* More out-of-box materials and shaders.
* Basic physical subsystem.
* Skeletal animation.

Requirements
------------

R4 currently supports iOS 7. It can also run on previous versions if you don't use R4EmitterNode class. Simple scenes can be rendered smoothly on older devices like iPhone 4, but anything more complex will require optimizations like using simpler shaders or lowering drawing resolution to support such devices.

Performance notes
-----------------
iOS Simulator performs software rendering so you might want to try debugging on the device. If you're building library by yourself watch for compiler optimizations. There is significant performance difference in doing Debug vs. Release buid.

Getting started
---------------

Please check out [Getting started](https://github.com/srdanrasic/R4/wiki/Getting-started) page on Wiki.


Contribute
----------

Please check out [Contribute](https://github.com/srdanrasic/R4/wiki/Contribute) page on Wiki.

License
-------

R4 is made available under the MIT License.

Copyright (c) 2013 Srđan Rašić

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
