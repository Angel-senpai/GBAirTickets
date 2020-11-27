//
//  TicketTableViewCell.h
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 26.11.2020.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "CoreDataHelper.h"
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell
@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic,strong) FavoriteTicket *favoriteTicket;
- (void)setFavoriteTicket:(FavoriteTicket *)favoriteTicket;
@end

NS_ASSUME_NONNULL_END
