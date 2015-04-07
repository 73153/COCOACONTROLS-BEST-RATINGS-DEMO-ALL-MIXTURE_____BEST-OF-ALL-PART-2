RSCategories
============

A Few essential categories for iOS Developers. Include helper methods for 
NSDate, NSString, NSUserDefaults, UIColor and UIImage.

More to come in the future, only adding as and when required.

#### NSDate

    -(NSString *)formatWithString:(NSString *)format;
    -(NSString *)formatWithStyle:(NSDateFormatterStyle)style;
    -(NSString *)distanceOfTimeInWords;
    -(NSString *)distanceOfTimeInWords:(NSDate *)date;


#### NSString

    -(NSString *)MD5;
    -(NSString *)sha1;
    -(NSString *)reverse;
    -(NSString *)URLEncode;
    -(NSString *)URLDecode;
    -(NSString *)stringByStrippingWhitespace;
    -(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
    -(NSString *)CapitalizeFirst:(NSString *)source;
    -(NSString *)UnderscoresToCamelCase:(NSString*)underscores;
    -(NSString *)CamelCaseToUnderscores:(NSString *)input;
    
    -(NSUInteger)countWords;

    -(BOOL)contains:(NSString *)string;
    -(BOOL)isBlank;


#### NSUserDefaults

    +(void)saveObject:(id)object forKey:(NSString *)key;
    +(id)retrieveObjectForKey:(NSString *)key;
    +(void)deleteObjectForKey:(NSString *)key;


#### UIColor

    +(UIColor *)colorWithHex:(int)hex;


#### UIImage + GIF

    +(UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;
    +(UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;



###### Please note: Some or most of the methods are code I have collected from other developers and due credit should be given to them.





## License
The MIT License (MIT)

Copyright (c) 2012 Reejo Samuel (http://reejosamuel.com/)


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.