//
//  CPSClearVuListPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSClearVuListPresenter.h"

#import "MCArrayTableViewDatasource.h"
#import "CPSClearVuTableViewDelegate.h"

#import "CPSClearVuItemPresenter.h"

@interface CPSClearVuListPresenter () <MCTableViewDelegateEventHandler>

@property (nonatomic, strong) MCArrayTableViewDatasource *  datasource;
@property (nonatomic, strong) CPSClearVuTableViewDelegate * delegate;
@property (nonatomic, strong) CPSClearVuItemPresenter *     itemPresenter;

@end

@implementation CPSClearVuListPresenter

- (instancetype)init
{
    if (self = [super init])
    {
        _delegate = [CPSClearVuTableViewDelegate new];
        _delegate.eventHandler = self;
    }
    return self;
}

- (void)setAllVideoItems:(NSArray *)videoItems
{
    NSString *cellIdentifier = [self.userInterface cellReuseIdentifier];
    CPSClearVuItemPresenter *itemPresenter = [CPSClearVuItemPresenter new];
    
    id datasource = [[MCArrayTableViewDatasource alloc] initWithItems:videoItems
                                                       cellIdentifier:cellIdentifier
                                                            presenter:itemPresenter];
    
    self.delegate.items = videoItems;
    [self.userInterface setTableViewDelegate:self.delegate];
    [self.userInterface setTableViewDatasource:datasource];
    self.datasource = datasource;
    self.itemPresenter = itemPresenter;
}

- (void)introVideoPlaybackCompleted
{
    [super introVideoPlaybackCompleted];
    [self.interactor requestAllVideoItems];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.interactor itemSelectedAtIndex:indexPath.row];
}

@end
