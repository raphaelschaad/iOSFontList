//
//  FontListViewController.m
//  FontList
//
//  Created by Raphael Schaad on 20.02.10.
//


// FL
#import "FontListViewController.h"

// RS
#import "NSString+RSAdditions.h"


#pragma mark Constants

// all sizes in points
static const CGFloat kFontSizePad	= 24;
static const CGFloat kFontSizePhone	= 18;

static const CGFloat kMarginTop		= 32;
static const CGFloat kMarginLeft	= 20;
static const CGFloat kMarginBottom	= 16;

static const CGFloat kFontNameIndent = 12;

static const CGFloat kFontFamilyMargin	= 24;
static const CGFloat kFontMargin		= 5;

#define kFontFamilyFontColor [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0]; // tableCellBlueTextColor http://iphonedevwiki.net/index.php?title=UIColor


@implementation FontListViewController

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Track content size
	CGFloat maxWidth	= 0;
	CGFloat totalHeight	= 0;
	
	
	// Getting the Available Font Names
	
	// Available font family (typeface) names (base name, e.g. Times New Roman)
	NSArray *familyNames = [UIFont familyNames];
	
	// Sort ascending alphabetically
	familyNames = [familyNames sortedArrayUsingComparator:^(id obj1, id obj2) {
		NSString *familyName1 = (NSString *)obj1;
		NSString *familyName2 = (NSString *)obj2;
		
		return [familyName1 compare:familyName2];
	}];
	
	for (NSString *familyName in familyNames) {
		// Add extra spacing except for the first family name
		if ([[familyNames objectAtIndex:0] isEqualToString:familyName] == NO) {
			totalHeight += kFontFamilyMargin;
		}
		
		// Create the font object
		CGFloat labelFontSize = [UIFont labelFontSize];
		UIFont *font = [UIFont systemFontOfSize:labelFontSize];
		
		// Add a label to the scroll view with the font family name rendered in the default system font
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        CGSize labelSize = [familyName sizeWithAttributes:attrs];
		CGRect labelFrame = CGRectMake(0, totalHeight, ceil(labelSize.width), ceil(labelSize.height));
		UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
		label.font = font;
		label.text = familyName;
		label.textColor = kFontFamilyFontColor
		[self.view addSubview:label];
		[label release]; label = nil;
		
		maxWidth = MAX(maxWidth, labelSize.width);
		
		totalHeight += kFontMargin;
		totalHeight += labelSize.height;		
		
		// Available font names in a particular font family (typeface) (font name, e.g. TimesNewRomanPS-BoldItalicMT)
		NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
		
		// Sort regular first
		// This approach is simple but works for most naming conventions
		NSString *familyNameTrimmed = [familyName stringByReplacingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] withString:@""];
		fontNames = [fontNames sortedArrayUsingComparator:^(id obj1, id obj2) {
			NSString *fontName1 = (NSString *)obj1;
			NSString *fontName2 = (NSString *)obj2;
			
			if ([fontName1 isEqualToString:familyNameTrimmed]) {
				return NSOrderedAscending;
			} else if ([fontName2 isEqualToString:familyNameTrimmed]) {
				return NSOrderedDescending;
			} else {
				return NSOrderedSame;
			}
		}];
		
		for (NSString *fontName in fontNames) {
			// Create the font object
			UIFont *font = [UIFont fontWithName:fontName size:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? kFontSizePad : kFontSizePhone];
			
			// Add a label to the scroll view with the font name rendered in the font
            NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
            CGSize labelSize = [fontName sizeWithAttributes:attrs];
			CGRect labelFrame = CGRectMake(kFontNameIndent, totalHeight, ceil(labelSize.width), ceil(labelSize.height));
			UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
			label.font = font;
			label.text = fontName;
			label.textColor = [UIColor darkTextColor];
			[self.view addSubview:label];
			[label release]; label = nil;
			
			maxWidth = MAX(maxWidth, labelSize.width);
			
			totalHeight += kFontMargin;
			totalHeight += labelSize.height;
		}
	}
	
	
	// Configure the scroll view
	UIScrollView *scrollView = (UIScrollView *)self.view;
	scrollView.contentSize = CGSizeMake(maxWidth, totalHeight);
	scrollView.contentInset = UIEdgeInsetsMake(kMarginTop, kMarginLeft, kMarginBottom, 0);
	scrollView.contentOffset = CGPointMake(-scrollView.contentInset.left, -scrollView.contentInset.top);
}


@end
