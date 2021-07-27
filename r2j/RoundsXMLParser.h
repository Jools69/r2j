//
//  RoundsXMLParser.h
//  iArcher
//
//  Created by Julian Parker on 07/04/2009.
//  Copyright 2009 Scientia I.T. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Round;


@interface RoundsXMLParser : NSObject <NSXMLParserDelegate>
{
	NSMutableArray *theRounds;
	
	NSMutableString	*currentElementValue;
	Round	*aRound;
	int	currentDistance;
	float currentDozen;
    NSString *currentTargetFace;
	int currentArrows;
}
@property (retain, nonatomic) NSMutableArray *theRounds;

- (RoundsXMLParser *) initRoundsXMLParser;

@end
