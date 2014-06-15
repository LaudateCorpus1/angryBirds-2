//
//  Gameplay.m
//  angryBirds
//
//  Created by Franco Román Meola on 15/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#define BIRD_COUNT 3

@implementation Gameplay {
    CCPhysicsNode * _physicsNode;
    CCNode * _catapultArm;
    CCNode * _levelNode;
    CCNode * _contentNode;
    CCNode * _launcher;
    CCNode * _currentBird;
    int birdCount;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.debugDraw = TRUE;
    _physicsNode.collisionDelegate = self;
    birdCount = 0;
    CCScene * level = [CCBReader loadAsScene:@"Levels/Level2"];
    [_levelNode addChild:level];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // Vuelvo la cámara al al lanzador
    // ¿Cómo se hace?
}

- (void)launchBird:(id)sender {
    if (birdCount < BIRD_COUNT) {
        CCNode * bird = [CCBReader load:@"Bird"];
        // Calculo la rotación en Radianes
        float rotationRadians = CC_DEGREES_TO_RADIANS(_launcher.rotation);
        // Vector para la rotación
        CGPoint directionVector = ccp(sinf(rotationRadians),cosf(rotationRadians));
        CGPoint ballOffset = ccpMult(directionVector, 50);
        bird.position = ccpAdd(_launcher.position, ballOffset);
        [_physicsNode addChild:bird];
        self.position = ccp(0, 0);
        CCActionFollow * follow = [CCActionFollow actionWithTarget:bird worldBoundary:self.boundingBox];
        [_contentNode runAction:follow];
        // Agrego el impulso inicial
        CGPoint force = ccpMult(directionVector, 10000);
        [bird.physicsBody applyForce:force];
        birdCount++;
    }
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair enemy:(CCNode *)nodeA wildcard:(CCNode *)nodeB{
    float energy = [pair totalKineticEnergy];
    if (energy > 5000.f) {
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
}

- (void)retry {
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
