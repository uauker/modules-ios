//
//  MyAppsViewController.m
//  Projeto Modules
//
//  Created by Uauker on 6/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "MyAppsViewController.h"

@interface MyAppsViewController ()

@end

@implementation MyAppsViewController

- (void)initWithVariables {
    if (!self.tableBackgroundColor) {
        self.tableBackgroundColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1.0];
    }
    
    if (!self.cacheTimeInSeconds) {
        self.cacheTimeInSeconds = 5 * 60;
    }
}

- (void)loadView
{
    [super loadView];
    
    [self initWithVariables];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MyApps" owner:self options:nil];
    self.view = [nibObjects objectAtIndex:0];
    
    self.tableView = (UITableView *)[self.view viewWithTag:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationItem setTitle:self.navTitle];
    
    [[self tableView] setBackgroundColor:self.tableBackgroundColor];
    
    __block NSMutableArray *tmpAppsArray = [[NSMutableArray alloc] init];
    
    [EGOCache setUrl:URL_HEROKU_MY_APPS withTimeoutInterval:self.cacheTimeInSeconds onSuccessPerform:^(NSString *content, BOOL isNew, NSError *error) {
        if (error == nil && (isNew || self.apps == nil)) {
            NSDictionary *dic = [content objectFromJSONString];
            
            for (NSDictionary *item in [dic objectForKey:@"apps"]) {
                PGApps *app = [[PGApps alloc] initWithDictionary:item];
                
                if (![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:app.bundle]) {
                    [tmpAppsArray addObject:app];
                }
            }
        }
    }];
    
    self.apps = tmpAppsArray;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.apps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyAppCell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    	cell = (UITableViewCell *)[nib objectAtIndex:0];
    }
    
    PGApps *app = [self.apps objectAtIndex:[indexPath row]];
    
    UIImageView *imageView = (UIImageView *) [cell viewWithTag:5];
    UILabel *nameApp = (UILabel *) [cell viewWithTag:2];
    UILabel *category = (UILabel *) [cell viewWithTag:3];
    
    [imageView setImageWithURL:[NSURL URLWithString:app.icon]];
    imageView.layer.cornerRadius = 10.0;
    imageView.layer.masksToBounds = YES;
    
    nameApp.text = app.name;
    
    category.text = app.category;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = ([indexPath row] % 2 == 0) ? [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f] : [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    PGApps *app = [self.apps objectAtIndex:[indexPath row]];
    
    NSString *url = app.url;
    
    NSString *scheme = app.bundle;
    scheme = [[scheme componentsSeparatedByString:@"."] lastObject];
    scheme = [NSString stringWithFormat:@"%@://", scheme];
    
    NSString *urlToOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]] ? scheme : url;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToOpen]];
}

@end
