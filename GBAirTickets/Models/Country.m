//
//  Country.m
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 25.11.2020.
//

#import "Country.h"

@implementation Country
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _currency = [dictionary valueForKey:@"currency"];
        _translations = [dictionary valueForKey:@"name_translations"];
        _name = [dictionary valueForKey:@"name"];
        _code = [dictionary valueForKey:@"code"];
    }
    return self;
}
@end
