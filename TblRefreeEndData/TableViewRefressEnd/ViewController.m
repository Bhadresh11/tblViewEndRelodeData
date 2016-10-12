//
//  ViewController.m
//  TableViewRefressEnd
//
//  Created by Bhadresh Patel on 12/10/16.
//  Copyright © 2016 Bhadresh Patoliya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [[NSMutableArray alloc]initWithObjects:@"One",@"two", nil];

    if (items.count < 10)
    {
        items = [[NSMutableArray alloc]initWithObjects:@"One",@"two",@"One",@"two",@"One",@"two",@"One",@"two",@"One",@"two", nil];

    }// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Standard TableView delegates


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    count = items.count;
    if ((items.count - 5) == indexPath.row)
    {
        for (int i = 0; i < 10; i++)
        {
            
            [items addObject:[NSString stringWithFormat:@"Add Row:%ldd",count + i]];
        }
        [tblView reloadData];
    }
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    return cell;
}
/*
#pragma mark - ScrollViewDidScroll And ScrollViewDidEndDecelerating Methods
-(void)scrollViewReload:(UIScrollView*)scrollView{
    if (scrollView == _tblrecipie) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height - 100){
            
            [self getallservices:[Global getcategory] second:[Global getsubcategory] third:startindex];
            
        }
    }}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    decelerate = decelerate;
    if (!decelerate)
        [self scrollViewReload:scrollView];
}
*/

- (void)getallservices:(NSString *)category second:(NSString *)subcategory third:(NSInteger)index{
    NSString *indexno =  [NSString stringWithFormat:@"%d", (int)index];
    NSDictionary *dicParams = @{@"request":@"GetAllRecipe",
                                category:subcategory,
                                @"Index":indexno
                                };
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://" parameters:dicParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject = %@ ", responseObject);
        [self performSegueWithIdentifier:@"StartWorkVc" sender:self];
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"error = %@ operation:%@", error,operation.responseObject);
              
          }];
    /*
    [WEBHELPER CallAPI:API_POST URL:DEV_SERVER_URL Params:dicParams OnCompletion:^(id response) {
        [GLOBAL hideLoader];
        NSLog(@"%@",response);
        
        NSArray *responseArray = [(NSArray *) response valueForKey:@"data"];
        if ([responseArray count] > 0){
            startindex++;
            
            for(int i = 0;i< responseArray.count;i++){
                AllRecipe=[[AllRecipes alloc]init];
                NSMutableArray *temparray = [[NSMutableArray alloc]init];
                
                AllRecipe.recipesname = [[responseArray objectAtIndex:i]  valueForKey:@"Name"];
                AllRecipe.abcd = [[responseArray objectAtIndex:i]  valueForKey:@"Rating"];
                AllRecipe.recipesid = [[responseArray objectAtIndex:i]  valueForKey:@"r_id"];
                AllRecipe.cusine = [[responseArray objectAtIndex:i]  valueForKey:@"Cusine"];
                AllRecipe.category = [[responseArray objectAtIndex:i]  valueForKey:@"Category"];
                AllRecipe.method = [[responseArray objectAtIndex:i]  valueForKey:@"Method"];
                AllRecipe.timerequired =[[responseArray objectAtIndex:i]  valueForKey:@"Time_Required"];
                AllRecipe.reviewcount = [[responseArray objectAtIndex:i]  valueForKey:@"Reviewcount"];
                
                AllRecipe.createddate = [[responseArray objectAtIndex:i]  valueForKey:@"Created_Date"];
                AllRecipe.Ratingg = [[responseArray objectAtIndex:i]  valueForKey:@"Rating"];
                NSLog(@" favrt %@",[[responseArray objectAtIndex:i] valueForKey:@"Favorites"]);
                if([[[responseArray objectAtIndex:i] valueForKey:@"Favorites"] isKindOfClass:[NSArray class]]){
                    
                    AllRecipe.favarray =  [[NSMutableArray alloc]init];
                    
                    [AllRecipe.favarray addObject: [[[responseArray objectAtIndex:i] valueForKey:@"Favorites"]  valueForKey:@"user_id"]];
                    [temparray addObject:[[[responseArray objectAtIndex:i] valueForKey:@"Favorites"]  valueForKey:@"user_id"]];
                    if([[[[responseArray objectAtIndex:i] valueForKey:@"Favorites"]  valueForKey:@"user_id"] containsObject:[Global getuserID]]){
                        NSLog(@"yes it is fav");
                        AllRecipe.isFav = YES;
                    }else{
                        AllRecipe.isFav = NO;
                    }
                }else{
                    NSLog(@"this is else");
                    AllRecipe.isFav = NO;
                }
                AllRecipe.integredients = [[responseArray objectAtIndex:i]  valueForKey:@"Integredients"];
                AllRecipe.mainintegredients = [[responseArray objectAtIndex:i]  valueForKey:@"Integredients_main"];
                AllRecipe.favourite = [[responseArray objectAtIndex:i]  valueForKey:@"Favorite"];
                AllRecipe.servingsize = [[responseArray objectAtIndex:i]  valueForKey:@"Serving_Size"];
                AllRecipe.rate = [[responseArray objectAtIndex:i]  valueForKey:@"Rate"];
                AllRecipe.username = [[responseArray objectAtIndex:i]  valueForKey:@"Username"];
                AllRecipe.image = [[responseArray objectAtIndex:i]  valueForKey:@"Image"];
                AllRecipe.profileimg = [[responseArray objectAtIndex:i]  valueForKey:@"filename"];
                AllRecipe.direction = [[responseArray objectAtIndex:i]  valueForKey:@"Directions"];
                //   [[[responseArray objectAtIndex:i]  valueForKey:@"Favorites"] valueForKey:@"user_id"];
                [RecipiesArray addObject:AllRecipe];
            }
            //   NSLog(@"%lu count",(unsigned long)RecipiesArray.count);
            [_tblrecipie reloadData];
        }
        else {
            if(startindex == 1){
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"There is no any recipe for selected type?"
                                                                    message:nil delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"Get All Recipe",nil];
                [alertView show];
            }
            
        }
        
    }OnError:^(id error) {
        
        [GLOBAL hideLoader];
        NSLog(@"response : %@",[error description]);
        if([error isKindOfClass:[NSDictionary class]])
        {
            NSString *strErrMessage = [error valueForKey:RESPONSE_MESSAGE];
            DISPLAY_CUSTOM_ALERT_MESSAGE(strErrMessage);
        }
    }];
    */
}

@end
