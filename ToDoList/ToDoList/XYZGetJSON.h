//
//  XYZGetJSON.h
//  ToDoList
//
//  Created by DX167-XL on 2014-01-15.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYZGetJSONDelegate;

@interface XYZGetJSON : NSObject
@property(weak, nonatomic) id<XYZGetJSONDelegate> delegate;

-(void)searchMovies:(NSString *)moviename;
@end
