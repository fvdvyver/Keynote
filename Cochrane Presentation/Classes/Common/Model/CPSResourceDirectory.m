//
//  CPSResourceDirectory.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceDirectory.h"

@implementation CPSResourceDirectory

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; %@; contentFiles = <%li objects>>",
            NSStringFromClass(self.class), self, self.directoryPath, (long)self.contentFiles.count];
}

@end
