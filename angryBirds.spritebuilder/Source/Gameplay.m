//
//  Gameplay.m
//  angryBirds
//
//  Created by Franco Román Meola on 15/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

static const float MIN_SPEED = 5.f;

@implementation Gameplay {
    CCPhysicsNode * _physicsNode;
    CCNode * _catapultArm;
    CCNode * _levelNode;
    CCNode * _contentNode;
    CCNode * _launcher;
    CCNode * _currentBird;
    int triesCount;
    OALSimpleAudio * sounds;
    CCLabelBMFont * _scoreLabel;
    CCAction * _followBird;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
//    _physicsNode.debugDraw = TRUE;
    _physicsNode.collisionDelegate = self;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    triesCount = [[defaults objectForKey:@"BirdCount"] intValue];
    [_scoreLabel setString: [NSString stringWithFormat:@"%d x", triesCount]];
    NSString * levelSelected = [NSString stringWithFormat:@"Levels/%@",[defaults objectForKey:@"LevelSelected"]];
    CCScene * level = [CCBReader loadAsScene:levelSelected];
    [_levelNode addChild:level];
    sounds = [OALSimpleAudio sharedInstance];
    [sounds playBg:@"background.mp3" loop:YES];
}

- (void)launchBird:(id)sender {
    if (triesCount) {
        CCNode * bird = [CCBReader load:@"Bird"];
        _currentBird = bird;
        // Calculo la rotación en Radianes
        float rotationRadians = CC_DEGREES_TO_RADIANS(_launcher.rotation);
        // Vector para la rotación
        CGPoint directionVector = ccp(sinf(rotationRadians),cosf(rotationRadians));
        CGPoint ballOffset = ccpMult(directionVector, 50);
        _currentBird.position = ccpAdd(_launcher.position, ballOffset);
        [_physicsNode addChild:_currentBird];
        self.position = ccp(0, 0);
//        CCActionFollow * follow = [CCActionFollow actionWithTarget:_currentBird worldBoundary:self.boundingBox];
//        [_contentNode runAction:follow];
        // Agrego el impulso inicial
        CGPoint force = ccpMult(directionVector, 10000);
        [_currentBird.physicsBody applyForce:force];
        triesCount--;
        [sounds playEffect:@"flying.mp3"];
        [_scoreLabel setString: [NSString stringWithFormat:@"%d x", triesCount]];
        _followBird = [CCActionFollow actionWithTarget:_currentBird worldBoundary:self.boundingBox];
        [_contentNode runAction:_followBird];
    }
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair enemy:(CCNode *)nodeA wildcard:(CCNode *)nodeB{
    float energy = [pair totalKineticEnergy];
    if (energy > KINETIC_ENERGY_REQUIRED) {
        [self enemyRemove:nodeA];
    }
}

- (void)enemyRemove:(CCNode *)enemy {
    // load particle effect
    CCParticleSystem * explosion = (CCParticleSystem *)[CCBReader load:@"EnemyExplosion"];
    // make the particle effect clean itself up, once it is completed
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = enemy.position;
    // add the particle effect to the same node the seal is on
    [enemy.parent addChild:explosion];
    // finally, remove the destroyed seal
    [enemy removeFromParent];
    [sounds playEffect:@"explosion.mp3"];
}

- (void)back {
    [sounds stopEverything];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"LevelSelector"]];
}

- (void)update:(CCTime)delta
{
    // if speed is below minimum speed, assume this attempt is over
    if (ccpLength(_currentBird.physicsBody.velocity) < MIN_SPEED){
        [self nextAttempt];
        return;
    }
    int xMin = _currentBird.boundingBox.origin.x;
    if (xMin < self.boundingBox.origin.x) {
        [self nextAttempt];
        return;
    }
    int xMax = xMin + _currentBird.boundingBox.size.width;
    if (xMax > (self.boundingBox.origin.x + self.boundingBox.size.width)) {
        [self nextAttempt];
        return;
    }
}

- (void)nextAttempt {
    _currentBird = nil;
    [_contentNode stopAction:_followBird];
    [_contentNode setPosition:ccp(0, 0)];
// ¿Por qué oscila la cámara?
//    CCActionMoveTo * actionMoveTo = [CCActionMoveTo actionWithDuration:1.f position:ccp(0, 0)];
//    [_contentNode runAction:actionMoveTo];
}

- (void)reset {
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
