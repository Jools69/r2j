//
//  Round.h
//  iArcher
//
//  Created by Julian Parker on 17/04/2009.
//  Copyright 2009 Scientia I.T. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Round : NSObject <NSCopying>
{
	NSString	*Name;
	NSString	*ShortName;
	NSString	*MeasurementSystem;
	NSString	*RoundType;
	NSString	*ScoringType;
	NSString	*Association;
	NSString	*GroupType;
	NSString	*ScoresheetType;
    NSString    *Distance1FaceType;
    NSString    *Distance2FaceType;
    NSString    *Distance3FaceType;
    NSString    *Distance4FaceType;
	int			NumberOfDistances;
	int			Distance1;
	int			Distance2;
	int			Distance3;
	int			Distance4;
	int			EndsForDistance1;
	int			EndsForDistance2;
	int			EndsForDistance3;
	int			EndsForDistance4;
	int			EndSize;
    BOOL        Obsolete;
    BOOL        ShowAsDozens;
}

@property (retain, nonatomic) NSString *Name;
@property (retain, nonatomic) NSString *ShortName;
@property (retain, nonatomic) NSString *MeasurementSystem;
@property (retain, nonatomic) NSString *RoundType;
@property (retain, nonatomic) NSString *ScoringType;
@property (retain, nonatomic) NSString *Association;
@property (retain, nonatomic) NSString *GroupType;
@property (retain, nonatomic) NSString *ScoresheetType;
@property (retain, nonatomic) NSString *Distance1FaceType;
@property (retain, nonatomic) NSString *Distance2FaceType;
@property (retain, nonatomic) NSString *Distance3FaceType;
@property (retain, nonatomic) NSString *Distance4FaceType;
@property (readwrite, nonatomic) int NumberOfDistances;
@property (readwrite, nonatomic) int EndSize;
@property (readwrite, nonatomic) BOOL Obsolete;
@property (readwrite, nonatomic) BOOL ShowAsDozens;

- (int) NumberOfEnds;
- (int) Distance:(int) forIndex;
- (NSString *) FaceType:(int) forIndex;
- (int) Ends:(int) forIndex;
- (void) Add:(int) Distance withEnds:(int) numOfEnds;
- (void) Add:(int) Distance withEnds:(int) numOfEnds andFaceType:(NSString*) faceType;
- (void) changeDistanceTo:(int) newDistance forIndex:(int) index;
- (void) changeFaceTypeTo:(NSString *) faceType forIndex:(int) index;

@end
