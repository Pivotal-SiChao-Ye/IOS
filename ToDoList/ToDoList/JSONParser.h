//
//  JSONParser.h
//  ToDoList
//
//  Created by DX167-XL on 2014-01-15.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

+ (NSArray *)moviesFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
