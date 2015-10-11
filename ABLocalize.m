//
//  ABLocalize.m
//  GetFollowers
//
//  Created by Антон Буков on 25.09.15.
//  Copyright © 2015 Codeless Solutions. All rights reserved.
//

#import <JRSwizzle/JRSwizzle.h>
#import "ABLocalize.h"

NSString *ABLocalizeTag;

@implementation NSBundle (ABLocalize)

+ (void)load
{
    [NSBundle jr_swizzleMethod:@selector(localizedStringForKey:value:table:) withMethod:@selector(xxx_localizedStringForKey:value:table:) error:NULL];
}

- (NSString *)xxx_localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)table
{
    static NSString *notFound = @"@#$NOT_FOUND$#@";
    NSString *taggedKey = [key stringByAppendingFormat:@"#%@", ABLocalizeTag];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[[NSLocale preferredLanguages].firstObject componentsSeparatedByString:@"-"].firstObject ofType:@"lproj"];
    
    NSString *ret = [[NSBundle bundleWithPath:path] xxx_localizedStringForKey:taggedKey value:notFound table:table];
    if (![ret isEqualToString:notFound])
        return ret;
    
    ret = [self xxx_localizedStringForKey:taggedKey value:notFound table:table];
    if (![ret isEqualToString:notFound])
        return ret;
    
    ret = [[NSBundle bundleWithPath:path] xxx_localizedStringForKey:key value:notFound table:table];
    if (![ret isEqualToString:notFound])
        return ret;
    
    ret = [self xxx_localizedStringForKey:key value:notFound table:table];
    if (![ret isEqualToString:notFound])
        return ret;
    
    return value;
}

@end

//

UIColor *rgb(NSInteger rgb)
{
    return [UIColor colorWithRed:(0xff&(rgb>>16))/255.
                           green:(0xff&(rgb>>8))/255.
                            blue:(0xff&(rgb>>0))/255.
                           alpha:1.0];
}

UIColor *rgbs(NSString *rgbs)
{
    NSScanner *scanner = [NSScanner scannerWithString:rgbs];
    NSUInteger location = [rgbs rangeOfString:@"#"].location;
    if (location != NSNotFound)
        scanner.scanLocation = location + 1;
    unsigned rgbValue = 0;
    [scanner scanHexInt:&rgbValue];
    return rgb(rgbValue);
}

NSString *NSLocalizedStr(NSString *key)
{
    NSString *str = NSLocalizedString(key, @"");
    if (str.length)
        return str;
    
    NSString *basePath = [[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj"];
    NSString *str2 = NSLocalizedStringFromTableInBundle(key, nil, [NSBundle bundleWithPath:basePath], @"");
    if (str2.length)
        return str2;
    
    return @"";
}

UIColor *NSLocalizedColor(NSString *key)
{
    return rgbs(NSLocalizedStr(key));
}

NSArray *NSLocalizedStringsArray(NSString *key)
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 1; ; i++) {
        NSString *k = [key stringByAppendingFormat:@"_%@",@(i)];
        NSString *str = NSLocalizedStr(k);
        if (str.length == 0)
            break;
        [arr addObject:str];
    }
    return arr;
}

NSArray *NSLocalizedColorsArray(NSString *key)
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in NSLocalizedStringsArray(key))
        [arr addObject:rgbs(str)];
    return arr;
}
