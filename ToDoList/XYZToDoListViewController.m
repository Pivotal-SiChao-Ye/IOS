//
//  XYZToDoListViewController.m
//  ToDoList
//
//  Created by DX167-XL on 2014-01-13.
//  Copyright (c) 2014 DX167-XL. All rights reserved.
//

#import "XYZToDoListViewController.h"
#import "XYZToDoItem.h"
#import "XYZAddToDoItemViewController.h"

#define string @"HUUUU"
@interface XYZToDoListViewController () {
    NSURL* url;
    int pagelimit;
    NSString *summary;
}

@property NSMutableArray *toDoItems;
@property NSMutableArray *movies;
@property int pagenum;


@end

@implementation XYZToDoListViewController
int pagenum;

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
         NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
        //NSArray* feeds = [json objectForKey:@"feed"];
        NSArray* movies = [json objectForKey:@"movies"];
        //NSLog(@"%@",movies);
        [self.toDoItems removeAllObjects];
    
        for (int i = 0; i < pagelimit; i++){
            XYZToDoItem *item = [[XYZToDoItem alloc] init];
            // Parse through JSON to get title / image url
            //item.itemName = [feeds[i] objectForKey:@"headline"];
            //NSArray *imagearray = [feeds[i] objectForKey:@"images"];
            //NSString *imageurl;
            
            
            item.itemName = [movies[i] objectForKey:@"title"];
            
            item.summary = [movies[i] objectForKey:@"synopsis"];
            
            NSString *imageurl = [[movies[i] objectForKey:@"posters"] objectForKey:@"profile"];
            item.imgurl = imageurl;
            NSURL *newurl = [NSURL URLWithString:imageurl];
            NSData *data = [NSData dataWithContentsOfURL:newurl];
            UIImage *image = [[UIImage alloc] initWithData:data];
            item.img = image;

            
            // Get creation Time
            NSDate *time = [NSDate date];
            NSDate *date = [NSDate date];
            
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

            [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat:@"MMM dd, yyyy"];
            
            NSString *currentTime = [timeFormatter stringFromDate:time];
            NSString *currentDate = [dateFormatter stringFromDate:date];
            NSString *current = [currentTime stringByAppendingString:@" "];
            current = [current stringByAppendingString:currentDate];
            item.creationDate = current;
            
            
            [self.toDoItems addObject:item];
        }
        [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


-(void)loadInitialData{
    
    [_responseData setLength:0];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    NSLog(@"Hu");
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    XYZAddToDoItemViewController *source = [segue sourceViewController];
    XYZToDoItem *item = source.toDoItem;
    if (item != nil){
        [self.toDoItems addObject:item];
        [self.tableView reloadData];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)refreshTable:(UIRefreshControl *)refreshMe
{
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:
                                 @"Refreshing data..."];
    // TODO: do stuffs here
    if (pagelimit < 40){
    pagelimit = pagelimit + 10;
    }
    NSString *update = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=%d&country=us&apikey=3ju33k3tweekjjkvcfbw6h9j", pagelimit];
    NSLog(@"%@",update);
    url = [NSURL URLWithString:update];
    [self loadInitialData];
    
    [refreshMe endRefreshing];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:
                                 @"Pull To Load More"];
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Load More"];
    [refresh addTarget:self action:@selector(refreshTable:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    self.toDoItems = [[NSMutableArray alloc] init];
    url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=20&country=us&apikey=3ju33k3tweekjjkvcfbw6h9j"];
    pagelimit = 20;
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
     // Configure the cell...
    XYZToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    cell.detailTextLabel.text = toDoItem.creationDate;
    cell.imageView.image = toDoItem.img;

    
    return cell;
}
 
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detail"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        XYZAddToDoItemViewController *controller = (XYZAddToDoItemViewController *)segue.destinationViewController;
        controller.movie = summary;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



#pragma mark - Table view delegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYZToDoItem *cur = self.toDoItems[indexPath.row];
    summary = cur.summary;
    NSLog(@"clicked");
}
- (IBAction)refresh:(id)sender {
}
@end
