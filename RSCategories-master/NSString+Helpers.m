//
//  NSString+Helpers.m

//
//  Created by Reejo Samuel on 8/2/13.
//  Copyright (c) 2013 Reejo Samuel | m[at]reejosamuel.com All rights reserved.
//

#import "NSString+Helpers.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helpers)

- (NSString *)MD5 {
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}


-(NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data 	 = [NSData dataWithBytes:cstr length:self.length];
    
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
	CC_SHA1(data.bytes, data.length, digest);
    
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
    
	return output;
}



-(NSString *)reverse {
	NSInteger length = [self length];
	unichar *buffer = calloc(length, sizeof(unichar));
    
	// TODO(gabe): Apparently getCharacters: is really slow
	[self getCharacters:buffer range:NSMakeRange(0, length)];
    
	for(int i = 0, mid = ceil(length/2.0); i < mid; i++) {
		unichar c = buffer[i];
		buffer[i] = buffer[length-i-1];
		buffer[length-i-1] = c;
	}
    
	NSString *s = [[NSString alloc] initWithCharacters:buffer length:length];
    buffer = nil;
	return s;
}


-(NSUInteger)countWords {

    __block NSUInteger wordCount = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                wordCount++;
                            }];
    return wordCount;
}

-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}


-(NSString *)URLEncode {
    
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (__bridge CFStringRef)self,
                                                                  NULL,
                                                                  CFSTR(":/?#[]@!$&'()*+,;="),
                                                                  kCFStringEncodingUTF8);
    return [NSString stringWithString:(__bridge_transfer NSString *)encoded];
}

-(NSString *)URLDecode {
    
    CFStringRef decoded = CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)self,
                                                                     CFSTR(":/?#[]@!$&'()*+,;=") );
    return [NSString stringWithString:(__bridge_transfer NSString *)decoded];
}



-(NSString *)CamelCaseToUnderscores:(NSString *)input {
    
    NSMutableString *output = [NSMutableString string];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    for (NSInteger idx = 0; idx < [input length]; idx += 1) {
        unichar c = [input characterAtIndex:idx];
        if ([uppercase characterIsMember:c]) {
            [output appendFormat:@"%s%C", (idx == 0 ? "" : "_"), (unichar)(c ^ 32)];
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

-(NSString *)UnderscoresToCamelCase:(NSString*)underscores {
    
    NSMutableString *output = [NSMutableString string];
    BOOL makeNextCharacterUpperCase = NO;
    for (NSInteger idx = 0; idx < [underscores length]; idx += 1) {
        unichar c = [underscores characterAtIndex:idx];
        if (c == '_') {
            makeNextCharacterUpperCase = YES;
        } else if (makeNextCharacterUpperCase) {
            [output appendString:[[NSString stringWithCharacters:&c length:1] uppercaseString]];
            makeNextCharacterUpperCase = NO;
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

-(NSString *)CapitalizeFirst:(NSString *)source {
    
    if ([source length] == 0) {
        return source;
    }
    return [source stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                           withString:[[source substringWithRange:NSMakeRange(0, 1)] capitalizedString]];
}






#pragma mark - Boolean Helpers

-(BOOL)isBlank {
    if([[self stringByStrippingWhitespace] isEqualToString:@""])
        return YES;
    return NO;
}

-(BOOL)contains:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}


@end
