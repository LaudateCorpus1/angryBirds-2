//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene {
    OALSimpleAudio * bgmusic;
}

- (void)didLoadFromCCB {
    bgmusic = [OALSimpleAudio sharedInstance];
    [bgmusic playBg:@"intro.mp3" loop:TRUE];
}

- (void) play {
    [bgmusic stopEverything];
    CCScene * gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
