//
//  AppDelegate_iPad.h
//  iOSFontList
//
//  Created by Raphael Schaad on 01.12.10.
//


// FL
@class FontListViewController;


@interface AppDelegate_iPad : NSObject
<UIApplicationDelegate>

@property (nonatomic, retain, readwrite) IBOutlet UIWindow *window;
@property (nonatomic, retain, readwrite) IBOutlet FontListViewController *fontListViewController;

@end

