//
//  FontListViewController.m
//  FontList
//
//  Created by Raphael Schaad on 01.07.10.
//


// RS
#import "NSString+RSAdditions.h"


@implementation NSString (RSAdditions)

#pragma mark Task: Replacing Substrings

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)set withString:(NSString *)replacement {
	
	// parameter check: return unmodified string (in favor to throw a NSInvalidArgumentException)
	if (set == nil || // causes -scanUpToCharactersFromSet:intoString: to throw a NSInvalidArgumentException
		replacement == nil) // causes -appendString: to throw a NSInvalidArgumentException
	{
		return self;
	}
	
	
	NSScanner *scanner = [NSScanner scannerWithString:self];
	// default skips whitespace and newline, don't ignore any characters
	[scanner setCharactersToBeSkipped:nil];
	
	NSMutableString *result = [NSMutableString stringWithCapacity:[self length]];
	NSString *value = nil;
	
	while ([scanner isAtEnd] == NO) {
		BOOL scannedNonReplacingCharacters = [scanner scanUpToCharactersFromSet:set intoString:&value];
		
		if (scannedNonReplacingCharacters == YES) {
			[result appendString:value];
		} else {
			[result appendString:replacement];
			[scanner setScanLocation:[scanner scanLocation]+1];
		}
	}
	
	return result;
}


@end
