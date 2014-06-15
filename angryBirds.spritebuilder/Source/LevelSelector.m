//
//  LevelSelector.m
//  angryBirds
//
//  Created by Franco Román Meola on 15/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LevelSelector.h"

@implementation LevelSelector {
    NSUserDefaults * defaults;
}

- (void)didLoadFromCCB {
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void) playLevel1 {
    [defaults setObject:@"Level1" forKey:@"LevelSelected"];
    [defaults setObject:@"3" forKey:@"BirdCount"];
    [self loadLevel];
}

- (void) playLevel2 {
    [defaults setObject:@"Level2" forKey:@"LevelSelected"];
    [defaults setObject:@"4" forKey:@"BirdCount"];
    [self loadLevel];
}

- (void) playLevel3 {
    [defaults setObject:@"Level3" forKey:@"LevelSelected"];
    [defaults setObject:@"5" forKey:@"BirdCount"];
    [self loadLevel];
}

- (void) loadLevel {
    CCScene * gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) back {
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"MainScene"]];
}

@end
