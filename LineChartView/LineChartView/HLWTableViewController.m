//
//  HLWTableViewController.m
//  LineChartView
//
//  Created by tang on 2017/3/15.
//  Copyright © 2017年 tang. All rights reserved.
//

#import "HLWTableViewController.h"
#import "LineChartViewController.h"

static NSString *cellIdentifier = @"UITableView";

@interface HLWTableViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation HLWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    [self setupData];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [UIView new];
}

- (void)setupData
{
    [_dataArray addObject:@"折线图"];
    [_dataArray addObject:@"心型图"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LineChartViewController *vc = [LineChartViewController new];

    if (0 == indexPath.row) {
        NSMutableArray *points = [NSMutableArray array];
        [points addObject:@{@"x" : @0, @"y" : @0}];
        [points addObject:@{@"x" : @40, @"y" : @20}];
        [points addObject:@{@"x" : @80, @"y" : @60}];
        [points addObject:@{@"x" : @120, @"y" : @120}];
        [points addObject:@{@"x" : @200, @"y" : @120}];
        
        vc.dataPoints = points;
        
    } else if (1 == indexPath.row) {
        
        NSMutableArray *points = [NSMutableArray array];
        [points addObject:@{@"x" : @150, @"y" : @20}];
        [points addObject:@{@"x" : @210, @"y" : @80}];
        [points addObject:@{@"x" : @210, @"y" : @130}];
        [points addObject:@{@"x" : @190, @"y" : @150}];
        [points addObject:@{@"x" : @170, @"y" : @150}];
        
        [points addObject:@{@"x" : @150, @"y" : @120}];
        
        [points addObject:@{@"x" : @130, @"y" : @150}];
        [points addObject:@{@"x" : @110, @"y" : @150}];
        [points addObject:@{@"x" : @90, @"y" : @130}];
        [points addObject:@{@"x" : @90, @"y" : @80}];
        [points addObject:@{@"x" : @150, @"y" : @20}];



//        [points addObject:@{@"x" : @120, @"y" : @120}];
//        [points addObject:@{@"x" : @200, @"y" : @120}];
        vc.hideNodes = YES;

        vc.dataPoints = points;
        vc.lineColor = [UIColor redColor];
    }
    
    [self.navigationController pushViewController:vc animated:YES];

    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
