//
//  CPSResourceDirectory.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSResourceDirectory : NSObject

@property (nonatomic, strong) NSString * directoryName;
@property (nonatomic, strong) NSString * directoryPath;
@property (nonatomic, strong) NSArray *  contentFiles;

@end
