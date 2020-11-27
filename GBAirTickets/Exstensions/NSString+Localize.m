//
//  NSString+Localize.m
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 27.11.2020.
//

#import "NSString+Localize.h"

@implementation NSString (Localize)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end

