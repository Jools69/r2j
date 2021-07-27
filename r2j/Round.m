//
//  Round.m
//  iArcher
//
//  Created by Julian Parker on 07/04/2009.
//  Copyright 2009 Scientia I.T. Ltd. All rights reserved.
//

#import "Round.h"


@implementation Round

@synthesize Name;
@synthesize ShortName;
@synthesize MeasurementSystem;
@synthesize RoundType;
@synthesize ScoringType;
@synthesize Association;
@synthesize GroupType;
@synthesize ScoresheetType;
@synthesize NumberOfDistances;
@synthesize EndSize;
@synthesize Distance1FaceType;
@synthesize Distance2FaceType;
@synthesize Distance3FaceType;
@synthesize Distance4FaceType;
@synthesize Obsolete;
@synthesize ShowAsDozens;

- (int) NumberOfEnds
{
	return (EndsForDistance1 + EndsForDistance2 + EndsForDistance3 + EndsForDistance4);
}

- (int) Distance:(int) forIndex
{
	int requiredDistance = 0;
	
	if((forIndex < 1) || (forIndex > 4))
		return requiredDistance;
	else
	{
		switch(forIndex)
		{
			case 1:
				requiredDistance = Distance1;
				break;
			case 2:
				requiredDistance = Distance2;
				break;
			case 3:
				requiredDistance = Distance3;
				break;
			case 4:
				requiredDistance = Distance4;
				break;
		}
		
		return requiredDistance;
	}
}

- (NSString *) FaceType:(int) forIndex
{
	NSString *requiredFaceType = @"";
	
	if((forIndex < 1) || (forIndex > 4))
		return requiredFaceType;
	else
	{
		switch(forIndex)
		{
			case 1:
				requiredFaceType = Distance1FaceType;
				break;
			case 2:
				requiredFaceType = Distance2FaceType;
				break;
			case 3:
				requiredFaceType = Distance3FaceType;
				break;
			case 4:
				requiredFaceType = Distance4FaceType;
				break;
		}
		
		return requiredFaceType;
	}
}

- (void) changeDistanceTo:(int) newDistance forIndex:(int) index
{
    if((index < 1) || (index > 4))
		return;
    else
    {
        switch(index)
        {
            case 1:
                Distance1 = newDistance;
                break;
            case 2:
                Distance2 = newDistance;
                break;
            case 3:
                Distance3 = newDistance;
                break;
            case 4:
                Distance4 = newDistance;
                break;
        }
    }
}

- (void) changeFaceTypeTo:(NSString *) faceType forIndex:(int) index
{
    if((index < 1) || (index > 4))
        return;
    else
    {
        switch(index)
        {
            case 1:
                Distance1FaceType = [NSString stringWithString:faceType];
                break;
            case 2:
                Distance2FaceType = [NSString stringWithString:faceType];
                break;
            case 3:
                Distance3FaceType = [NSString stringWithString:faceType];
                break;
            case 4:
                Distance4FaceType = [NSString stringWithString:faceType];
                break;
        }
    }
}

- (int) Ends:(int) forIndex
{
	int requiredEnds = 0;
	
	if((forIndex < 1) || (forIndex > 4))
		return requiredEnds;
	else
	{
		switch(forIndex)
		{
			case 1:
				requiredEnds = EndsForDistance1;
				break;
			case 2:
				requiredEnds = EndsForDistance2;
				break;
			case 3:
				requiredEnds = EndsForDistance3;
				break;
			case 4:
				requiredEnds = EndsForDistance4;
				break;
		}
		
		return requiredEnds;
	}
	
}

- (void) Add:(int) Distance withEnds:(int) numOfEnds
{
	switch (NumberOfDistances)
	{
		case 0:
			NumberOfDistances = 1;
			Distance1 = Distance;
			EndsForDistance1 = numOfEnds;
			break;
		case 1:
			NumberOfDistances = 2;
			Distance2 = Distance;
			EndsForDistance2 = numOfEnds;
			break;
		case 2:
			NumberOfDistances = 3;
			Distance3 = Distance;
			EndsForDistance3 = numOfEnds;
			break;
		case 3:
			NumberOfDistances = 4;
			Distance4 = Distance;
			EndsForDistance4 = numOfEnds;
			break;
	}
}

- (void) Add:(int) Distance withEnds:(int) numOfEnds andFaceType:(NSString*) faceType
{
	switch (NumberOfDistances)
	{
		case 0:
			NumberOfDistances = 1;
			Distance1 = Distance;
			EndsForDistance1 = numOfEnds;
            self.Distance1FaceType = [NSString stringWithString:faceType];
			break;
		case 1:
			NumberOfDistances = 2;
			Distance2 = Distance;
			EndsForDistance2 = numOfEnds;
            self.Distance2FaceType = [NSString stringWithString:faceType];
			break;
		case 2:
			NumberOfDistances = 3;
			Distance3 = Distance;
			EndsForDistance3 = numOfEnds;
            self.Distance3FaceType = [NSString stringWithString:faceType];
			break;
		case 3:
			NumberOfDistances = 4;
			Distance4 = Distance;
			EndsForDistance4 = numOfEnds;
            self.Distance4FaceType = [NSString stringWithString:faceType];
			break;
	}
}

- (id) copyWithZone:(NSZone *)zone
{
	Round *roundCopy;
	
	roundCopy = [[[self class] allocWithZone:zone] init];
	
	NSString *nameCopy = [self.Name copy];
	roundCopy.Name = nameCopy;
	
	NSString *shortNameCopy = [self.ShortName copy];
	roundCopy.ShortName = shortNameCopy;
	
	NSString *measurementSystemCopy = [self.MeasurementSystem copy];
	roundCopy.MeasurementSystem = measurementSystemCopy;

	NSString *roundTypeCopy = [self.RoundType copy];
	roundCopy.RoundType = roundTypeCopy;
	NSString *scoringTypeCopy = [self.ScoringType copy];
	roundCopy.ScoringType = scoringTypeCopy;
	NSString *associationCopy = [self.Association copy];
	roundCopy.Association = associationCopy;
	
	NSString *groupTypeCopy = [self.GroupType copy];
	roundCopy.GroupType = groupTypeCopy;
	
	NSString *scoresheetTypeCopy = [self.ScoresheetType copy];
	roundCopy.ScoresheetType = scoresheetTypeCopy;

	roundCopy.EndSize = self.EndSize;
    
    roundCopy.Obsolete = self.Obsolete;
    
    roundCopy.ShowAsDozens = self.ShowAsDozens;
	
	for (int dist = 1; dist <= self.NumberOfDistances; dist++)
    {
        NSString *targetFaceCopy = [[self FaceType:dist] copy];
		[roundCopy Add:[self Distance:dist] withEnds:[self Ends:dist] andFaceType:targetFaceCopy];
    }
	
	return (roundCopy);
}

@end
