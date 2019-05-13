//
//  Util.m
//  OncologyApp
//
//  Created by Niranjan Kode on 12/16/12.
//
//

#import "Util.h"

@implementation Util

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

+ (NSMutableArray*)getReferences:(NSString*)string
{
    
    NSMutableArray* strings = [NSMutableArray arrayWithCapacity:0];
    
    NSRange startRange = [string rangeOfString:@"$"];
    
    for( ;; )
    {
        
        if (startRange.location != NSNotFound)
        {
            
            NSRange targetRange;
            
            targetRange.location = startRange.location + startRange.length;
            targetRange.length = [string length] - targetRange.location;
            
            NSRange endRange = [string rangeOfString:@"$" options:0 range:targetRange];
            
            if (endRange.location != NSNotFound)
            {
                
                targetRange.length = endRange.location - targetRange.location;
                [strings addObject:[string substringWithRange:targetRange]];
                
                NSRange restOfString;
                
                restOfString.location = endRange.location + endRange.length;
                restOfString.length = [string length] - restOfString.location;
                
                startRange = [string rangeOfString:@"$" options:0 range:restOfString];
                
            }
            else
            {
                break;
            }
            
        }
        else
        {
            break;
        }
        
    }
    
    return strings;
    
}
@end
