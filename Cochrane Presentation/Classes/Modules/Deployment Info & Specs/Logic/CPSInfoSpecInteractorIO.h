//
//  CPSInfoSpecInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourceInteractorIO.h"

@protocol CPSInfoSpecInteractorInput <CPSVideoListResourceInteractorInput>

- (void)requestData;

@end

@protocol CPSInfoSpecInteractorOutput <CPSVideoListResourceInteractorOutput>

- (void)setVideoTitles:(NSArray *)videoTitles;

- (void)showTitleText:(NSString *)titleText;
- (void)showInfoStrings:(NSArray *)infoStrings;
- (void)showModelWithVideoName:(NSString *)modelVideoName;
- (void)showSecurityLevelVideoWithName:(NSString *)securityLevelVideoName;
- (void)showSecurityLevelImageWithName:(NSString *)securityLevelImageName;

@end