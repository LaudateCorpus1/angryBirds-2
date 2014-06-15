//
//  LevelSelector.m
//  angryBirds
//
//  Created by Franco Román Meola on 15/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LevelSelector.h"

@implementation LevelSelector

- (void) playLevel {
    CCScene * gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
