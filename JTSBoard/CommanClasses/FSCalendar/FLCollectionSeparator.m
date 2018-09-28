//
//  FLCollectionSeparator.m
//  JTSBoard
//
//  Created by jts on 25/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

#import "FLCollectionSeparator.h"


@implementation FLCollectionSeparator

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.frame = layoutAttributes.frame;
}

@end
