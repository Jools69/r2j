//
//  RoundsXMLParser.m
//  iArcher
//
//  Created by Julian Parker on 07/04/2009.
//  Copyright 2009 Scientia I.T. Ltd. All rights reserved.
//

#import "RoundsXMLParser.h"
#import "Round.h"


@implementation RoundsXMLParser
@synthesize theRounds;

- (RoundsXMLParser *) initRoundsXMLParser
{
	if(self = [super init])
    {
    }	
	
	return self;
}

- (void) parser:(NSXMLParser *)parser 
				didStartElement:(NSString *)	elementName
				namespaceURI:(NSString *)		namespaceURI 
				qualifiedName:(NSString *)		qualifiedName
				attributes:(NSDictionary *)		attributeDict
{
	
	if([elementName isEqualToString:@"Rounds"]) 
	{
		//Initialize the Rounds array.
		NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
		self.theRounds = tmpArray;
	}
	else if([elementName isEqualToString:@"Round"]) 
	{
		
		//Initialize the round.
		aRound = [[Round alloc] init];
		// Default the number of arrows per end to 6 here.
		aRound.EndSize = 6;
		// Default the Association, GroupType and Obsolete members too
		aRound.Association = @"Normal";
		aRound.GroupType = @"Distance";
		aRound.ScoresheetType = @"Default";
        aRound.Obsolete = NO;
		
		//Extract the attributes here.
		aRound.Name = [attributeDict objectForKey:@"Name"];
		aRound.ShortName = [attributeDict objectForKey:@"ShortName"];
		aRound.MeasurementSystem = [attributeDict objectForKey:@"MeasurementSystem"];
		aRound.RoundType = [attributeDict objectForKey:@"RoundType"];
	}
	else if([elementName isEqualToString:@"Distance"])
	{
		// We're about to read a new Distance for the current round, so clear the two ivars for these values
		currentDistance = 0;
		currentDozen = 0;
        currentTargetFace = @"";
	}
	else if([elementName isEqualToString:@"Game"])
	{
		// We're about to read a new Game for the current round, so clear the two ivars for these values
		currentDistance = 0;
		currentArrows = 0;
        currentTargetFace = @"";
	}
	else
	{
		currentElementValue = nil;
	}
}

- (void) parser:(NSXMLParser *)					parser 
				foundCharacters:(NSString *)	string 
{
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];	
}

- (void) parser:(NSXMLParser *)				parser 
				didEndElement:(NSString *)	elementName
				namespaceURI:(NSString *)	namespaceURI 
				qualifiedName:(NSString *)	qName 
{
	
	if([elementName isEqualToString:@"Rounds"])
		return;
	
	//There is nothing to do if we encounter the Rounds element here.
	
	//If we encounter the Round element however, we want to add the round object to the array
	// and release the object.
	if([elementName isEqualToString:@"Round"]) 
	{
		[theRounds addObject:aRound];
		
		aRound = nil;
	}
	// If we encounter the end of the Distance element, we need to put the current element value into our Distance ivar
	else if([elementName isEqualToString:@"Measurement"])
	{
		currentDistance = [currentElementValue intValue];
	}
    // If we encounter the end of the TargetFace element, we need to put the current element value into
    // the currentTargetFace ivar.
    else if([elementName isEqualToString:@"TargetFace"])
    {
        currentTargetFace = [NSString stringWithString:currentElementValue];
    }
	// If we encounter the end of the NumberOfDozens element, we need to put the current element value into
	// the number of dozens ivar, and then add the current distance/number of dozen to the current round we're building.
	else if([elementName isEqualToString:@"NumberOfDozens"])
	{
		currentDozen = [currentElementValue floatValue];
		[aRound Add:currentDistance withEnds:(int) ((currentDozen * 12.0)/aRound.EndSize) andFaceType:currentTargetFace];
        aRound.ShowAsDozens = YES;
	}
	else if([elementName isEqualToString:@"NumberOfArrows"])
	{
		currentArrows = [currentElementValue intValue];
		// Now convert the number of arrows to number of ends, by dividing by the EndSize
		int numberOfEnds = currentArrows / aRound.EndSize;
		[aRound Add:currentDistance withEnds:numberOfEnds andFaceType:currentTargetFace];
        aRound.ShowAsDozens = NO;
	}
	else if([elementName isEqualToString:@"Distance"])
	{
		// We want to do nothing if it's the end of a Distance container.
	}
	else if([elementName isEqualToString:@"Game"])
	{
		// We want to do nothing if it's the end of a Game container.
	}
	else if([elementName isEqualToString:@"EndSize"])
	{
		aRound.EndSize = [currentElementValue intValue];
	}
    else if([elementName isEqualToString:@"Obsolete"])
    {
        aRound.Obsolete = [currentElementValue boolValue];
    }
	else
		[aRound setValue:currentElementValue forKey:elementName];
	
	currentElementValue = nil;
}

@end
