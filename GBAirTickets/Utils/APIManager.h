//
//  APIManager.h
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 26.11.2020.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
NS_ASSUME_NONNULL_BEGIN
typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;

@interface APIManager : NSObject
+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void (^)(City *city))completion;
- (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;
- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
@end

NS_ASSUME_NONNULL_END
