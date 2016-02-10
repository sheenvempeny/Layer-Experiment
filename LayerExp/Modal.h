//
//  Modal.h
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

typedef enum
{
	Resume = 0,
	Pause = 1,
	Unload = 2

}EModalState;


#import <Foundation/Foundation.h>

@interface Modal : NSObject
{
	NSString *name;
	EModalState state;
	
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,assign) EModalState state;

@end
