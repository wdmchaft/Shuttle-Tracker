//
//  MapPlacemark.m
//  Shuttle-Tracker
//
//  Created by Brendon Justin on 4/8/11.
//  Copyright 2011 Naga Softworks, LLC. All rights reserved.
//

#import "MapPlacemark.h"


@interface UIColor (stringcolor)

+ (UIColor *)UIColorFromRGBString:(NSString *)rgbString;
+ (UIColor *)UIColorFromRGBAString:(NSString *)rgbaString;

@end

@implementation MapPlacemark

@synthesize name;
@synthesize title;
@synthesize idTag;
@synthesize description;
@synthesize subtitle;
@synthesize styleUrl;
@synthesize style;
@synthesize timeDisplayFormatter;

@end

@implementation PlacemarkStyle

@synthesize idTag;
@synthesize color;
@synthesize colorString;
@synthesize width;

- (void)setColorString:(NSString *)newColorString {
    colorString = newColorString;
    [colorString retain];
    
    color = [UIColor UIColorFromRGBString:colorString];
	[color retain];
}

@end

@implementation MapRoute

@synthesize lineString;

@end

@implementation MapPoint

@synthesize coordinate;
@synthesize annotationView;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [self init];
    
    if (self) {
        coordinate = coord;
    }
    
    return self;
}

//  The subtitle for a map pin
- (NSString *)subtitle {
    return description;
}

//  The title for a map pin
- (NSString *)title {
    return name;
}

@end

@implementation MapStop

@synthesize routeIds;
@synthesize routeNames;

@end

@implementation MapVehicle

@synthesize ETAs;
@synthesize heading;
@synthesize updateTime;
@synthesize routeNo;
@synthesize routeImageSet;
@synthesize viewNeedsUpdate;

- (void)copyAttributesExceptLocation:(MapVehicle *)newVehicle {
    
}

@end

@implementation UIColor (stringcolor)

//  Take an NSString formatted as such: RRGGBB and return a UIColor
//  Note that this removes any '#' characters from rgbString
//  before doing anything.
+ (UIColor *)UIColorFromRGBString:(NSString *)rgbString {
    NSScanner *scanner;
    unsigned int rgbValue;
    
    rgbString = [rgbString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    if (rgbString) {
        scanner = [NSScanner scannerWithString:rgbString];
        [scanner scanHexInt:&rgbValue];
        
    } else {
        rgbValue = 0;
    }
    
    //  From the JSON, color comes as RGB
    UIColor *colorToReturn = [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                                             green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                                              blue:((float)((rgbValue & 0xFF)))/255.0
                                             alpha:1];
    
    return colorToReturn;
}

//  Take an NSString formatted as such: RRGGBBAA and return a UIColor
+ (UIColor *)UIColorFromRGBAString:(NSString *)rgbaString {
    NSScanner *scanner;
    unsigned int rgbaValue;
    
    if (rgbaString) {
        scanner = [NSScanner scannerWithString:rgbaString];
        [scanner scanHexInt:&rgbaValue];
        
    } else {
        rgbaValue = 0;
    }
    
    //  Assume ABGR format and convert appropriately
    UIColor *colorToReturn = [UIColor colorWithRed:((float)((rgbaValue & 0xFF)))/255.0
                                             green:((float)((rgbaValue & 0xFF00) >> 8))/255.0
                                              blue:((float)((rgbaValue & 0xFF0000) >> 16))/255.0
                                             alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0];
    
    return colorToReturn;
}

@end