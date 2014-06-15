//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene {
    OALSimpleAudio * music;
}

- (void)didLoadFromCCB {
    music = [OALSimpleAudio sharedInstance];
    if (![music bgPlaying]) {
        [music playBg:@"intro.mp3" loop:TRUE];
    }
}

- (void) play {
    [music stopEverything];
    CCScene * levelSelectorScene = [CCBReader loadAsScene:@"LevelSelector"];
    [[CCDirector sharedDirector] replaceScene:levelSelectorScene];
}

- (void) about {
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"About"]];
}

@end
