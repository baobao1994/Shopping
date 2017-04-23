//
//  PlaceView.m
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "PlaceView.h"
#import "UITableViewCell+Addition.h"
#import "PlaceTableViewCell.h"
#import "BaiduMapApiHeader.h"

@interface PlaceView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *placeTableView;
@property (nonatomic, strong) NSArray *placeArr;

@end

@implementation PlaceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PlaceView" owner:self options:nil] firstObject];
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.placeArr = [[NSArray alloc] init];
    }
    return self;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.didSelectPlace(self.placeArr[indexPath.row]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.placeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceTableViewCell *cell = [PlaceTableViewCell dequeOrCreateInTable:tableView selectedBackgroundViewColor:UIColorFromHexColor(0xccc2c2)];
    if ([self.placeArr[indexPath.row] isKindOfClass:[BMKPoiInfo class]]) {
        BMKPoiInfo *poiInfo = self.placeArr[indexPath.row];
        cell.addressLabel.text = [NSString stringWithFormat:@"%@ - %@",poiInfo.name,poiInfo.address];
    } else {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@",self.placeArr[indexPath.row]];
    }
    
    return cell;
}

- (void)setPlacePoiInfoArr:(NSArray *)placeArr {
    self.placeArr = placeArr;
    [self.placeTableView reloadData];
}

@end
