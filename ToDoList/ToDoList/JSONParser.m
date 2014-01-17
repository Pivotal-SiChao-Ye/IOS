//
//  JSONParser.m
//  ToDoList
//
//  Created by DX167-XL on 2014-01-15.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import "JSONParser.h"
#import "XYZToDoItem.h"

@implementation JSONParser

+ (NSArray *)moviesFromJSON:(NSData *)objectNotation error:(NSError *__autoreleasing *)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil){
        *error = localError;
        return nil;
    }
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    
    NSArray *movies = [parsedObject valueForKey:@"movies"];
    NSLog(@"Count %d", movies.count);
    
    for (NSDictionary *movieDic in movies){
        XYZToDoItem *title = [[XYZToDoItem alloc] init];
        
        for (NSString *key in movieDic){
            if ([title respondsToSelector:NSSelectorFromString(key)]) {
                [title setValue:[movieDic valueForKey:key] forKey:key];
            }
        }
        
        [titles addObject:title];
        
    }
    
    return titles;
}
@end
