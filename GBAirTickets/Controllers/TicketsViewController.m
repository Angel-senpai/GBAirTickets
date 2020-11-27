//
//  TicketsViewController.m
//  GBAirTickets
//
//  Created by Даниил Мурыгин on 26.11.2020.
//

#import "TicketsViewController.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"
#import "NSString+Localize.h"
#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController () 
@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;
@end

@implementation TicketsViewController{
    BOOL isFavorites;
    TicketTableViewCell *notificationCell;
}

- (instancetype)initFavoriteTicketsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.tickets = [NSArray new];
        self.title = @"Избранное";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}
- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self)
    {
        _tickets = tickets;
        self.title = @"Билеты";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate date];
        
        _dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
        _dateTextField.hidden = YES;
        _dateTextField.inputView = _datePicker;
        
        UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
        [keyboardToolbar sizeToFit];
        UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
        
        _dateTextField.inputAccessoryView = keyboardToolbar;
        [self.view addSubview:_dateTextField];
    }
    return self;
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _tickets = [[CoreDataHelper sharedInstance] favorites];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    if (isFavorites) {
        cell.favoriteTicket = [_tickets objectAtIndex:indexPath.row];
    } else {
        cell.ticket = [_tickets objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavorites) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[@"Tickets do" localize] message:[@"What are you want do with ticket?" localize] preferredStyle:UIAlertControllerStyleActionSheet];
     UIAlertAction *favoriteAction;
     if ([[CoreDataHelper sharedInstance] isFavorite: [_tickets objectAtIndex:indexPath.row]]) {
         favoriteAction = [UIAlertAction actionWithTitle:[@"Remove from favorites" localize] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
             [[CoreDataHelper sharedInstance] removeFromFavorite:[self->_tickets objectAtIndex:indexPath.row]];
         }];
     } else {
         favoriteAction = [UIAlertAction actionWithTitle:[@"Add to favorites" localize] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [[CoreDataHelper sharedInstance] addToFavorite:[self->_tickets objectAtIndex:indexPath.row]];
         }];
     }
     
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:[@"Remind" localize] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
         self->notificationCell = [tableView cellForRowAtIndexPath:indexPath];
         [self->_dateTextField becomeFirstResponder];
     }];
     
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"Close" localize] style:UIAlertActionStyleCancel handler:nil];
     [alertController addAction:favoriteAction];
     [alertController addAction:notificationAction];
     [alertController addAction:cancelAction];
     [self presentViewController:alertController animated:YES completion:nil];
 }

- (void)doneButtonDidTap:(UIBarButtonItem *)sender
{
    if (_datePicker.date && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.", notificationCell.ticket.from, notificationCell.ticket.to, notificationCell.ticket.price];

        NSURL *imageURL;
//        if (notificationCell.airlineLogoView.image) {
//            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
//            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//                UIImage *logo = notificationCell.airlineLogoView.image;
//                NSData *pngData = UIImagePNGRepresentation(logo);
//                [pngData writeToFile:path atomically:YES];
//
//            }
//            imageURL = [NSURL fileURLWithPath:path];
//        }

        Notification notification = NotificationMake([@"Notification about ticket" localize], message, _datePicker.date, imageURL);
        [[NotificationCenter sharedInstance] sendNotification:notification];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [@"Complete" localize] message:[NSString stringWithFormat:[@"Notification will be sent - %@" localize], _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"Close" localize] style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
}




@end
