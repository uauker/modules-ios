//
//  TwitterSearchViewController.h
//  Projeto Modules
//
//  Created by Paulo Guilherme on 24/06/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterSearchViewController : UIViewController

// Obrigatorio

@property (nonatomic, copy) NSString *navTitle;


// Privado

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
