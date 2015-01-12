//
//  CPSInfoSpecViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourceView.h"

@protocol CPSInfoSpecView <CPSVideoListResourceView>

- (void)showTitleText:(NSString *)titleText;
- (void)showInfoText:(NSString *)infoText;
- (void)playModelVideoWithName:(NSString *)videoName;
- (void)playSecurityLevelVideoWithName:(NSString *)videoName;
- (void)showSecurityLevelImageWithName:(NSString *)imageName;

@end
