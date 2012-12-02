//
//  ChipmunkSpaceLayer.h
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "ObjectiveChipmunk.h"
#import "CPDebugLayer.h"

@interface ChipmunkSpaceLayer : CCLayer
{
  ChipmunkSpace *_space;
  CPDebugLayer *_debugLayer;
}

+(CCScene *) scene;

-(void)update:(ccTime)dt;

@end
