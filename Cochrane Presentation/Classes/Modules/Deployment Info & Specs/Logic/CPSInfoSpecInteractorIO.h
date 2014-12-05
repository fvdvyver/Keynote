//
//  CPSInfoSpecInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListInteractorIO.h"

@protocol CPSInfoSpecInteractorInput <CPSVideoListInteractorInput>

- (void)requestData;

@end

@protocol CPSInfoSpecInteractorOutput <CPSVideoListInteractorOutput>

- (void)setVideoTitles:(NSArray *)videoTitles;

- (void)showTitleText:(NSString *)titleText;
- (void)showInfoStrings:(NSArray *)infoStrings;
- (void)showModelWithVideoName:(NSString *)modelVideoName;

@end