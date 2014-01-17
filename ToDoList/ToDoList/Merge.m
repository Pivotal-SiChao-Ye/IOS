//
//  Merge.m
//  ToDoList
//
//  Created by DX167-XL on 2014-01-15.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import "Merge.h"
#import "JSONParser.h"
#import "XYZGetJSON.h"

@implementation Merge
- (void)fetchMovies:(NSString *)title{
    [self.getjson searchMovies:title];
}

#pragma mark -MergeDelegate

- (void)receivedJSON:(NSData *)objectNotation {
    NSError *error = nil;
    NSArray *titles =[JSONParser moviesFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingTitlesFailedWithError:error];
    }
    else {
        [self.delegate didReceiveTitles:titles];
    }
}

- (void)fetchingFailedWithError:(NSError *)error {
    [self.delegate fetchingTitlesFailedWithError:error];
}
@end
