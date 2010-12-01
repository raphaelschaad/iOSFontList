//
//  FontListViewController.m
//  FontList
//
//  Created by Raphael Schaad on 20.02.10.
//  Copyright illuBits 2010. All rights reserved.
//


#import "FontListViewController.h"


// all sizes in points
static const CGFloat kFontSizePad	= 24;
static const CGFloat kFontSizePhone	= 18;

static const CGFloat kMarginTop		= 32;
static const CGFloat kMarginLeft	= 20;
static const CGFloat kMarginBottom	= 16;

static const CGFloat kFontNameIndent = 10;

static const CGFloat kFontFamilyMargin	= 24;
static const CGFloat kFontMargin		= 5;

#define kFontFamilyFontColor [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0]; // tableCellBlueTextColor http://iphonedevwiki.net/index.php?title=UIColor


@implementation FontListViewController

#pragma mark -
#pragma mark Life Cycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGFloat maxWidth = 0;
	CGFloat totalHeight = 0;
	
	// Getting the Available Font Names
	
	// Available font family names (base name, e.g. Times New Roman)
	NSArray *familyNames = [UIFont familyNames];
	for (NSString *familyName in familyNames) {
		// Add extra spacing except for the first family name
		if ([familyNames objectAtIndex:0] != familyName) {
			totalHeight += kFontFamilyMargin;
		}
		
		// Create the font object
		CGFloat labelFontSize = [UIFont labelFontSize];
		UIFont *font = [UIFont systemFontOfSize:labelFontSize];
		
		// Add a label to the scroll view with the font family name rendered in the default system font
		CGSize fontSize = [familyName sizeWithFont:font];
		CGRect labelFrame = CGRectMake(0.0, totalHeight, fontSize.width, fontSize.height);
		UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
		label.font = font;
		label.text = familyName;
		label.textColor = kFontFamilyFontColor
		[self.view addSubview:label];
		[label release]; label = nil;
		
		totalHeight += kFontMargin;
		
		maxWidth = fontSize.width > maxWidth ? fontSize.width : maxWidth;
		totalHeight += fontSize.height;
		
		// Available font names in a particular font family (font name, e.g. TimesNewRomanPS-BoldItalicMT)
		NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
		for (NSString *fontName in fontNames) {
			// Create the font object
			UIFont *font = [UIFont fontWithName:fontName size:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? kFontSizePad : kFontSizePhone];
			
			// Add a label to the scroll view with the font name rendered in the font
			CGSize fontSize = [fontName sizeWithFont:font];
			CGRect labelFrame = CGRectMake(kFontNameIndent, totalHeight, fontSize.width, fontSize.height);
			UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
			label.font = font;
			label.text = fontName;
			label.textColor = [UIColor darkTextColor];
			[self.view addSubview:label];
			[label release]; label = nil;
			
			totalHeight += kFontMargin;
			
			maxWidth = fontSize.width > maxWidth ? fontSize.width : maxWidth;
			totalHeight += fontSize.height;
		}
	}
	
	UIScrollView *scrollView = (UIScrollView *)self.view;
	scrollView.contentSize = CGSizeMake(maxWidth, totalHeight);
	scrollView.contentInset = UIEdgeInsetsMake(kMarginTop, kMarginLeft, kMarginBottom, 0.0);
	scrollView.contentOffset = CGPointMake(-scrollView.contentInset.left, -scrollView.contentInset.top);
}


#pragma mark -
#pragma mark UIViewController Method Overrides

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


@end
