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
    CCSprite * level4star;
    CCSprite * level5star;
    CCSprite * level6star;
}

- (void)didLoadFromCCB {
    defaults = [NSUserDefaults standardUserDefaults];
    music = [OALSimpleAudio sharedInstance];
    [music playBg:@"selector.mp3" loop:TRUE];
    [self loadStars];
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
    [defaults setObject:@"3" forKey:@"BirdCount"];
    [defaults setObject:@"2" forKey:@"EnemyCount"];
    [defaults setObject:@"Bird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) playLevel3 {
    [defaults setObject:@"Level3" forKey:@"LevelSelected"];
    [defaults setObject:@"3" forKey:@"BirdCount"];
    [defaults setObject:@"2" forKey:@"EnemyCount"];
    [defaults setObject:@"Bird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) playLevel4 {
    [defaults setObject:@"Level4" forKey:@"LevelSelected"];
    [defaults setObject:@"2" forKey:@"BirdCount"];
    [defaults setObject:@"1" forKey:@"EnemyCount"];
    [defaults setObject:@"Icebird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) playLevel5 {
    [defaults setObject:@"Level5" forKey:@"LevelSelected"];
    [defaults setObject:@"2" forKey:@"BirdCount"];
    [defaults setObject:@"2" forKey:@"EnemyCount"];
    [defaults setObject:@"Icebird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void) playLevel6 {
    [defaults setObject:@"Level6" forKey:@"LevelSelected"];
    [defaults setObject:@"2" forKey:@"BirdCount"];
    [defaults setObject:@"2" forKey:@"EnemyCount"];
    [defaults setObject:@"Icebird" forKey:@"BirdType"];
    [self loadLevel];
}

- (void)loadStars
{
    level1star.opacity = 0;
    level2star.opacity = 0;
    level3star.opacity = 0;
    level4star.opacity = 0;
    level5star.opacity = 0;
    level6star.opacity = 0;
    if ([defaults objectForKey:@"Level1Won"] != nil) {
        level1star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level2Won"] != nil) {
        level2star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level3Won"] != nil) {
        level3star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level4Won"] != nil) {
        level4star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level5Won"] != nil) {
        level5star.opacity = 1;
    }
    if ([defaults objectForKey:@"Level6Won"] != nil) {
        level6star.opacity = 1;
    }
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
