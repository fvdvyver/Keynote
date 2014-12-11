//
//  CPSGraphListPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSGraphListPresenter.h"

#import "MCArrayTableViewDatasource.h"
#import "MCSimpleTableViewCellPresenter.h"

#define CPSPropertyString(x) NSStringFromSelector(@selector(x))

@interface CPSGraphListPresenter () <UITableViewDelegate>

@property (nonatomic, strong) MCArrayTableViewDatasource *     datasource;
@property (nonatomic, strong) MCSimpleTableViewCellPresenter * itemPresenter;

@end

@implementation CPSGraphListPresenter

- (void)updateView
{
    [self.interactor requestAllVideoItems];
}

- (void)setAllVideoItems:(NSArray *)videoItems
{
    NSString *cellIdentifier = [self.userInterface cellReuseIdentifier];
    MCSimpleTableViewCellPresenter *itemPresenter = [MCSimpleTableViewCellPresenter new];
    itemPresenter.dataKeyPath = CPSPropertyString(title);
    
    id datasource = [[MCArrayTableViewDatasource alloc] initWithItems:videoItems
                                                       cellIdentifier:cellIdentifier
                                                            presenter:itemPresenter];
    
    [self.userInterface setTableViewDelegate:self];
    [self.userInterface setTableViewDatasource:datasource];
    self.datasource = datasource;
    self.itemPresenter = itemPresenter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.interactor itemSelectedAtIndex:indexPath.row];
}

@end
