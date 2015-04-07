<p align="center">
  <img src="assets/logo.png"/>
</p>

[![Build Status](https://travis-ci.org/andreamazz/UITextField-Shake.png)](https://travis-ci.org/andreamazz/UITextField-Shake)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/UITextField+Shake/badge.png)](http://cocoapods.org/?q=summary%3Auitextfield%20name%3Ashake%2A)
[![Analytics](https://ga-beacon.appspot.com/UA-42282237-8/UITextField+Shake/README)](https://github.com/igrigorik/ga-beacon)

UITextField category that adds a shake animation like the password field of the OsX login screen.

##Screenshot
![UITextField+Shake](https://raw.githubusercontent.com/andreamazz/UITextField-Shake/master/assets/screenshot.gif)

##Setup with Cocoapods
* Add ```pod 'UITextField+Shake'``` to your Podfile
* Run ```pod install```
* Run ```open App.xcworkspace```
* Import ```UITextField+Shake.h``` in your controller's header file

##Usage
```objc
// Shake with the default speed
[self.textField shake:10   // 10 times
            withDelta:5    // 5 points wide
];

// Shake with a custom speed
[self.textField shake:10   // 10 times
            withDelta:5    // 5 points wide
             andSpeed:0.03 // 30ms per shake
];

// Shake with a custom speed and direction
[self.textField shake:10   // 10 times
            withDelta:5    // 5 points wide
             andSpeed:0.03 // 30ms per shake
       shakeDirection:ShakeDirectionVertical
];
```

##Completion Handler
You can also pass a completion block that will be performed as soon as the shake animation stops
```objc
- (void)shake:(int)times withDelta:(CGFloat)delta completion:(void((^)()))handler;
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void((^)()))handler;
- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void((^)()))handler;
```

MIT License
==================
	Copyright (c) 2014 Andrea Mazzini. All rights reserved.

	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the "Software"),
	to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
