//
//  ChipmunkSpaceLayer.m
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChipmunkSpaceLayer.h"
#import "AppDelegate.h"

static NSString *borderType = @"borderType";

@implementation ChipmunkSpaceLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	ChipmunkSpaceLayer *layer = [ChipmunkSpaceLayer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark -
#pragma mark Update

-(void)update:(ccTime)dt {
  [_space step:(dt)];
}

#pragma mark -
#pragma mark CPDebugLayer

-(void)setDebugLayer {
  // CPDebugLayer only accept cpSpace, so use chipmunkSpace.space to get it.
  _debugLayer = [[CPDebugLayer alloc]initWithSpace:_space.space options:nil];
  [self addChild:_debugLayer z:999];
}

#pragma mark -
#pragma mark Chipmunk objects

-(void)setChipmunkCircleObject {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  // set chipmunkBody
  cpFloat mass = 1;
  cpFloat innerRadius = 0;
  cpFloat outerRadius = 100;
  cpVect offset = cpv(0, 0);
  
  cpFloat moment = cpMomentForCircle(mass, innerRadius, outerRadius, offset);
  ChipmunkBody *chipmunkBody = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  chipmunkBody.vel = cpv(CCRANDOM_0_1()*300+100, CCRANDOM_0_1()*300+100);
  chipmunkBody.angVel = CCRANDOM_0_1()*2;
  chipmunkBody.pos = cpv(winSize.width/2, winSize.height/2);
  [_space addBody:chipmunkBody];
  
  // set chipmunkShape
  ChipmunkShape *chipmunkShape = [ChipmunkCircleShape circleWithBody:chipmunkBody radius:outerRadius offset:offset];
  chipmunkShape.elasticity = 1.0;
  chipmunkShape.friction = 0.0;
  [_space addShape:chipmunkShape];
}

#pragma mark -
#pragma mark ChipmunkSpace

-(void)setChipmunkSpace {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  _space = [[ChipmunkSpace alloc]init];
  [_space addBounds:CGRectMake(0, 0, winSize.width, winSize.height) thickness:30.0f elasticity:1.0f friction:0.0f layers:CP_ALL_LAYERS group:CP_NO_GROUP collisionType:borderType];
}

#pragma mark -
#pragma mark Init

/*
 Target: Set the ChipmunkSpace and put a Chipmunk circle object in it.
 1. Set ChipmunkSpace.
 2. Set Chipmunk circle object with ChipmunkBody and ChipmunkShape.
 3. Set CPDebugLayer and the Chipmunk objects will be drawn.
 4. Update the ChipmunkSpace step
 */

-(id) init {
	if( (self=[super init]) ) {
    [self setChipmunkSpace];
    
    [self setChipmunkCircleObject];
    
    [self setDebugLayer];
    
    [self schedule:@selector(update:)];
	}
  
	return self;
}

- (void) dealloc
{
  [_space release];
  [_debugLayer release];
  
	[super dealloc];
}

@end
