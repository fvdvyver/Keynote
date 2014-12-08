//
//  CPSInfoSpecPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSInfoSpecPresenter.h"

#import "MCArrayTableViewDatasource.h"
#import "CPSInfoSpecCellPresenter.h"

@interface CPSInfoSpecPresenter () <UITableViewDelegate>

@property (nonatomic, strong) CPSInfoSpecCellPresenter *     cellPresenter;
@property (nonatomic, strong) MCArrayTableViewDatasource *   datasource;

@end

@implementation CPSInfoSpecPresenter

- (instancetype)init
{
    if (self = [super init])
    {
        _cellPresenter = [CPSInfoSpecCellPresenter new];
    }
    return self;
}

- (void)showTitleText:(NSString *)titleText
{
    [self.userInterface showTitleText:[titleText uppercaseString]];
}

- (void)setVideoTitles:(NSArray *)videoTitles
{
    NSString *cellIdentifier = [self.userInterface cellReuseIdentifier];
    MCArrayTableViewDatasource *datasource = [[MCArrayTableViewDatasource alloc] initWithItems:videoTitles
                                                                                cellIdentifier:cellIdentifier
                                                                                     presenter:self.cellPresenter];
    
    [self.userInterface setTableViewDatasource:datasource];
    [self.userInterface setTableViewDelegate:self];

    self.datasource = datasource;
}

- (void)showInfoStrings:(NSArray *)infoStrings
{
    NSMutableString *infoText = [NSMutableString string];
    for (NSString *info in infoStrings)
    {
        [infoText appendFormat:@"• %@\n", [info uppercaseString]];
    }
    
    [self.userInterface showInfoText:infoText];
}

- (void)showModelWithVideoName:(NSString *)modelVideoName
{
    [self.userInterface playModelVideoWithName:modelVideoName];
}

- (void)showSecurityLevelVideoWithName:(NSString *)securityLevelVideoName
{
    [self.userInterface playSecurityLevelVideoWithName:securityLevelVideoName];
}

- (void)showSecurityLevelImageWithName:(NSString *)securityLevelImageName
{
    [self.userInterface showSecurityLevelImageWithName:securityLevelImageName];
}

- (void)introVideoPlaybackCompleted
{
    [super introVideoPlaybackCompleted];
    [self.interactor requestData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.interactor itemSelectedAtIndex:indexPath.row];
}

@end
