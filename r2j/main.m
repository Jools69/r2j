//
//  main.m
//  r2j
//
//  Created by Jools on 06/07/2021.
//

#import <Foundation/Foundation.h>
#import "RoundsXMLParser.h"
#import "Round.h"
#import "Utils.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *rounds;
        NSString *json = @"{\n\"rounds\": [\n";
//        printf("%s", json.UTF8String);
//        fflush(stdout);
//
        if(argc != 3)
        {
            printf("Usage: r2j <input XML file> <output JSON file>\n");
            fflush(stdout);
            return 1;
        }
        
        NSString *inFile = [NSString stringWithCString:argv[1] encoding:(NSASCIIStringEncoding)];
        NSString *outFile = [NSString stringWithCString:argv[2] encoding:(NSASCIIStringEncoding)];;
        
        NSString *finalPath = inFile;
        NSData *xmlData = [NSData dataWithContentsOfFile:finalPath];

        //Now init an NSXMLParser object.
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];

        // Now initialise the RoundsXMLParser.
        RoundsXMLParser *parser = [[RoundsXMLParser alloc] initRoundsXMLParser];

        //Now set the delegate for the NSXMLParser
        [xmlParser setDelegate:parser];

        // Now start parsing the XML file
        BOOL success = [xmlParser parse];

        // Save the rounds that have been read in
        if(!success)
        {
            printf("XML Parsing failed, check input file\n");
            fflush(stdout);
            return 1;
        }
        
        rounds = parser.theRounds;
        
        // convert parsed round data to JSON formatted strings.
        
        for(int i = 0; i < [rounds count]; i++)
        {
            Round *rnd = rounds[i];

            json = [json stringByAppendingString:@"{\n"];
            json = [json stringByAppendingString:[Utils toJson:@"id" withIntVal:i includeComma:TRUE]];
            json = [json stringByAppendingString:[Utils toJson:@"roundName" withVal:rnd.Name includeComma:TRUE]];
            json = [json stringByAppendingString:[Utils toJson:@"system" withVal:rnd.MeasurementSystem includeComma:TRUE]];
            json = [json stringByAppendingString:[Utils toJson:@"type" withVal:rnd.RoundType includeComma:TRUE]];
            json = [json stringByAppendingString:[Utils toJson:@"scoreType" withVal:rnd.ScoringType includeComma:TRUE]];
            json = [json stringByAppendingString:[Utils toJson:@"endSize" withIntVal:rnd.EndSize includeComma:TRUE]];
            if(rnd.Obsolete)
                json = [json stringByAppendingString:[Utils toJson:@"obsolete" withVal:@"Yes" includeComma:TRUE]];
            json = [json stringByAppendingString:@"\"distances\": ["];
            for(int d = 1; d <= rnd.NumberOfDistances; d++)
            {
                BOOL includeComma = d != rnd.NumberOfDistances;
                json = [json stringByAppendingString:@"{\n"];
                json = [json stringByAppendingString:[Utils toJson:@"targetFace" withVal:[rnd FaceType:d] includeComma:TRUE]];
                json = [json stringByAppendingString:[Utils toJson:@"measurement" withIntVal:[rnd Distance:d] includeComma:TRUE]];
                double arrows = (float) [rnd Ends:d] * rnd.EndSize;
                if(rnd.ShowAsDozens)
                {
                    double dozens = arrows / 12.0;
                    json = [json stringByAppendingString:[Utils toJson:@"dozens" withFloatVal:dozens includeComma:FALSE]];
                }
                else
                {
                    json = [json stringByAppendingString:[Utils toJson:@"arrows" withIntVal:arrows includeComma:FALSE]];
                }
                json = [json stringByAppendingFormat:@"}%@\n", includeComma ? @"," : @""];
            }
            
            BOOL includeComma = i != ([rounds count] - 1);
            
            json = [json stringByAppendingString:@"]\n"];
            json = [json stringByAppendingFormat:@"}%@\n", includeComma ? @"," : @""];
        }
        // Now complete the json with the closing square brace and curly brace.
        json = [json stringByAppendingString:@"]\n"];
        json = [json stringByAppendingString:@"}\n"];

        printf("%s", json.UTF8String);
        fflush(stdout);
    }

    return 0;
}
