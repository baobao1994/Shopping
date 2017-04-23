//
//  SearchPlaceViewController.m
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "SearchPlaceViewController.h"
#import "JVFloatLabeledTextField.h"
#import "NSString+Addition.h"
#import "PlaceBubbleView.h"
#import "PlaceView.h"

@interface SearchPlaceViewController ()<UITextFieldDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoSearch;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) PlaceView *placeView;
@property (nonatomic, strong) PlaceBubbleView *placeBubbleView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *placeTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation SearchPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapViewWithParam];
    [self setUpPlaceView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geoSearch.delegate = nil;
    [self removeNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geoSearch.delegate = self;
    self.navigationController.navigationBar.hidden = YES;
    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.placeTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
}

- (void)setUpPlaceView {
    WEAKSELF_SC;
    self.placeView = [[PlaceView alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:self.placeView];
    self.placeView.hidden = YES;
    [self.placeView setDidSelectPlace:^(BMKPoiInfo *poiInfo){
        weakSelf_SC.placeTextField.text = poiInfo.name;
        weakSelf_SC.selectedPlaceName = poiInfo.name;
        weakSelf_SC.placeView.hidden = YES;
        [weakSelf_SC.placeTextField resignFirstResponder];
        [weakSelf_SC.mapView setCenterCoordinate:poiInfo.pt];// 当前地图的中心点
        [weakSelf_SC accordingLocationCoordinate2D:poiInfo.pt];
        [weakSelf_SC.backButton setTitle:@"返回" forState:UIControlStateNormal];
    }];
    self.placeBubbleView = [[PlaceBubbleView alloc] initWithFrame:CGRectMake((UIScreenWidth - 180) / 2, (UIScreenHeight - 64) / 2 , 180, 40)];
    [self.view addSubview:_placeBubbleView];
    [self.placeBubbleView setDidSurePlace:^{
        CLLocationCoordinate2D locationCoordinate2D = CLLocationCoordinate2DMake(weakSelf_SC.mapView.region.center.latitude, weakSelf_SC.mapView.region.center.longitude);
        BMKPoiInfo *poiInfo = [[BMKPoiInfo alloc] init];
        poiInfo.pt = locationCoordinate2D;
        poiInfo.name = weakSelf_SC.placeTextField.text;
        NSArray *addressArr = [weakSelf_SC.placeBubbleView.addressLabel.text componentsSeparatedByString:@"\n"];
        if (weakSelf_SC.placeTextField.text.length == 0) {
            NSString *addressString = @"";
            for (NSInteger i = addressArr.count - 1; i >= 0 ; i -- ) {
                addressString = [NSString stringWithFormat:@"%@%@",addressString,addressArr[i]];
            }
            poiInfo.address = addressString;
        } else {
            poiInfo.address = addressArr[1];
        }
        weakSelf_SC.didSelectedPlace(poiInfo);
        [weakSelf_SC.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 设置百度地图

-(void)setupMapViewWithParam {
    _userLocation = [[BMKUserLocation alloc] init];
    _geoSearch = [[BMKGeoCodeSearch alloc] init];
    _locService = [[BMKLocationService alloc] init];
    _locService.distanceFilter = 200;//设定定位的最小更新距离，这里设置 200m 定位一次，频繁定位会增加耗电量
    _locService.desiredAccuracy = kCLLocationAccuracyHundredMeters;//设定定位精度
    //开启定位服务
    [_locService startUserLocationService];
    //初始化BMKMapView
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight - 64)];
    _mapView.buildingsEnabled = YES;//设定地图是否现显示3D楼块效果
    _mapView.overlookEnabled = YES; //设定地图View能否支持俯仰角
    _mapView.showMapScaleBar = YES; // 设定是否显式比例尺
    _mapView.zoomLevel = 15;//设置放大级别
    [self.view addSubview:_mapView];
    
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    BMKLocationViewDisplayParam *userlocationStyle = [[BMKLocationViewDisplayParam alloc] init];
    userlocationStyle.isRotateAngleValid = YES;
    userlocationStyle.isAccuracyCircleShow = NO;
    userlocationStyle.locationViewOffsetX = 0.5;
    userlocationStyle.locationViewOffsetY = 0.5;
    [_mapView updateLocationViewWithParam:userlocationStyle];
    
    _locationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _locationButton.center = CGPointMake(_mapView.center.x, _mapView.center.y - 9);
    [_locationButton setImage:[UIImage imageNamed:@"user_location"] forState:UIControlStateNormal];
    [_locationButton addTarget:self action:@selector(didSelectLocationBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_locationButton];
}

- (void)didSelectLocationBtn:(UIButton *)sender {
    
}

- (IBAction)didSelectBackBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"返回"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.placeTextField resignFirstResponder];
        self.placeView.hidden = YES;
        [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    }
}

#pragma mark - BMKLocationServiceDelegate 用户位置更新后，会调用此函数
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];// 动态更新我的位置数据
    self.userLocation = userLocation;
    [_mapView setCenterCoordinate:userLocation.location.coordinate];// 当前地图的中心点
    [self accordingLocationCoordinate2D:userLocation.location.coordinate];
}

/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self.placeTextField resignFirstResponder];
    self.placeBubbleView.hidden = YES;
}
/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self accordingLocationCoordinate2D:mapView.region.center];
}

#pragma mark 根据新坐标进行位置定位

- (void)accordingLocationCoordinate2D:(CLLocationCoordinate2D)centerCoordinate {
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = centerCoordinate;
    BOOL flag = [_geoSearch reverseGeoCode:reverseGeoCodeOption];
    if (!flag) {
        [MBProgrossManagerInstance showOnlyText:@"定位失败,请重试" HudHiddenCallBack:nil];
    }
}

#pragma mark 根据坐标返回反地理编码搜索结果

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    BMKAddressComponent *addressComponent = result.addressDetail;
    if (self.selectedPlaceName.length) {
        self.placeBubbleView.addressLabel.text = [NSString stringWithFormat:@"%@\n%@%@%@",self.selectedPlaceName,addressComponent.district,addressComponent.streetName,addressComponent.streetNumber];
    } else {
        if (isEmptyString(addressComponent.streetName)) {
            self.placeBubbleView.addressLabel.text = [NSString stringWithFormat:@"%@%@",addressComponent.district,addressComponent.streetNumber];
        } else {
            self.placeBubbleView.addressLabel.text = [NSString stringWithFormat:@"%@%@\n%@",addressComponent.streetName,addressComponent.streetNumber,addressComponent.district];
        }
    }
    self.placeBubbleView.hidden = NO;
    self.selectedPlaceName = @"";
    [self searchNearbyPlace:addressComponent.streetName];
//    NSLog(@"%s -- %@", __func__, title);
}

#pragma mark TextFieldDelegate

- (void)textFiledEditChanged:(NSNotification *)notification {
    [self searchNearbyPlace:self.placeTextField.text];
}

- (void)searchNearbyPlace:(NSString *)place {
    [[BaiduMapManager shareInstance] searchNearByString:place withUserLocation:_mapView.region.center withResultCallBack:^(BMKPoiResult *poiResult, BOOL searchSuccess) {
        if (poiResult) {
            [self.placeView setPlacePoiInfoArr: poiResult.poiInfoList];
        }else{
            [self.placeView setPlacePoiInfoArr: @[@"抱歉，未找到结果，请重新输入"]];
        }
    }];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    //创建自带来获取穿过来的对象的info配置信息
    NSDictionary *userInfo = [aNotification userInfo];
    //创建value来获取 userinfo里的键盘frame大小
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //创建cgrect 来获取键盘的值
    CGRect keyboardRect = [aValue CGRectValue];
    //最后获取高度 宽度也是同理可以获取
    int height = keyboardRect.size.height;
    CGRect theRect = self.placeView.frame;
    theRect.size.height = UIScreenHeight - 64 - height;
    theRect.size.width = UIScreenWidth;
    self.placeView.frame = theRect;
    self.placeView.hidden = NO;
    self.placeBubbleView.hidden = YES;
    [self.backButton setTitle:@"取消" forState:UIControlStateNormal];
}

@end
