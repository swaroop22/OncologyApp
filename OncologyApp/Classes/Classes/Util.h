//
//  Util.h
//  OncologyApp
//
//  Created by Niranjan Kode on 12/16/12.
//
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSMutableArray*)getReferences:(NSString*)string;

@end
