//
//  XYZGetJSON.m
//  ToDoList
//
//  Created by DX167-XL on 2014-01-15.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import "XYZGetJSON.h"
#import "XYZGetJSONDelegate.h"

#define API_KEY @"3ju33k3tweekjjkvcfbw6h9j"
#define PAGE_COUNT 20

@implementation XYZGetJSON

-(void)searchMovies:(NSString *)moviename {
    NSString *urlAsString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=30&country=us&apikey=3ju33k3tweekjjkvcfbw6h9j";
    //[NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=",PAGE_COUNT,@"&country=us&apikey=", API_KEY];
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError){
            [self.delegate fetchingFailedWithError:connectionError];
        }
        else {
            [self.delegate receivedJSON:data];
        }
    }];
    
}
@end
