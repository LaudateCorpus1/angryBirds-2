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
    OALSimpleAudio * music;
    CCSprite * level1star;
    CCSprite * level2star;
    CCSprite * level3star;
}

- (void)didLoadFromCCB {
    level1star.opacity = 0;
    level2star.opacity = 0;
    level3star.opacity = 0;
    defaults = [NSUserDefaults standardUserDefaults];
    music = [OALSimpleAudio sharedInstance];
    [music playBg:@"selector.mp3" loop:TRUE];
    if ([defaults objectForKey:@"Level1Won"] != nil) {
        level1star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level2Won"] != nil) {
        level2star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level3Won"] != nil) {
        level3star.opacity = 1;
    }
}

- (void) playLevel1 {
    [defaults setObject:@"Level1" forKey:@"LevelSelected"];
    [defaults setObject:@"3" forKey:@"BirdCount"];
    [defaults setObject:@"1" forKey:@"EnemyCount"];
    [defaults setObject:@"Bird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) playLevel2 {
    [defaults setObject:@"Level2" forKey:@"LevelSelected"];
    [defaults setObject:@"4" forKey:@"BirdCount"];
    [defaults setObject:@"2" forKey:@"EnemyCount"];
    [defaults setObject:@"Bird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) playLevel3 {
    [defaults setObject:@"Level3" forKey:@"LevelSelected"];
    [defaults setObject:@"5" forKey:@"BirdCount"];
    [defaults setObject:@"2" forKey:@"EnemyCount"];
    [defaults setObject:@"Icebird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) loadLevel {
    CCScene * gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) back {
    [music stopEverything];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"MainScene"]];
}

@end
