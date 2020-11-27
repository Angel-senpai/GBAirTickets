//
//  TicketsViewController.h
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 26.11.2020.
//

#import <UIKit/UIKit.h>
#import "TicketTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewController : UITableViewController
- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;
@end

NS_ASSUME_NONNULL_END
