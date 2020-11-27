//
//  CoreDataHelper.h
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 27.11.2020.
//

#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject
- (BOOL)isFavorite:(Ticket *)ticket;
+ (instancetype)sharedInstance;
- (NSArray *)favorites;
- (void)addToFavorite:(Ticket *)ticket;
- (void)removeFromFavorite:(Ticket *)ticket;
@end

NS_ASSUME_NONNULL_END
