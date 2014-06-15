//
//  Enemy.m
//  angryBirds
//
//  Created by Franco Román Meola on 15/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

//- (id)init {
//    self = [super init];
//    
//    if (self) {
//        CCLOG(@"Enemy created");
//    }
//    
//    return self;
//}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"enemy";
}

@end
