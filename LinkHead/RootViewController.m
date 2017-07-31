//
//  RootViewController.m
//  LinkHead
//
//  Created by maqing on 2017/7/26.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "RootViewController.h"
#import "UINavigationBar+Awesome.h"
#import "KNBannerView.h"
#import "MainTouchTableView.h"
#import "HeadView.h"


//屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define KGColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >>8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
#define MQColor(r, g, b, t) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:t]

static CGFloat const headViewHeight = 300;

@interface RootViewController ()<KNBannerViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *newsTableView;
@property (nonatomic, strong) UILabel *topTitleView;//导航标题
@property (nonatomic, strong) MainTouchTableView *mainTableView;
@property (nonatomic, strong) KNBannerView *headScrollView;
@property (nonatomic, strong) UIView *sencondeView;
@property (nonatomic, strong) HeadView *headview;


//处理视图联动定义的类型
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@end

@implementation RootViewController
@synthesize mainTableView;
- (UITableView *)mainTableView
{
    if (mainTableView == nil)
    {
        mainTableView= [[MainTouchTableView alloc]initWithFrame:CGRectMake(0,-64,SCREEN_WIDTH,SCREEN_HEIGHT + 64)];
        mainTableView.delegate=self;
        mainTableView.dataSource=self;
        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return mainTableView;
}
- (UIView *)sencondeView
{
    if (_sencondeView == nil)
    {
        _sencondeView= [[UIView alloc]init];
        _sencondeView.backgroundColor = [UIColor whiteColor];
        _sencondeView.frame=CGRectMake(0, 0 ,SCREEN_WIDTH,headViewHeight/2+30);
        _sencondeView.userInteractionEnabled = YES;
        
    }
    return _sencondeView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIColor * color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //
    
    UIColor * color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
    UIImage *shadowImage = self.navigationController.navigationBar.shadowImage;
    self.navigationController.navigationBar.shadowImage = shadowImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动测试";
    [self setLunBoTuUI];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView =self.sencondeView;
    
    [self setTitleViewText];
    /*
     *接收离开顶部的通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    [self.mainTableView reloadData];
    
}
#pragma mark 设置导航栏
- (void)setTitleViewText {
    UILabel *topTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    topTitleView.text = @"GAMEFANS";
    topTitleView.font = [UIFont fontWithName:@"Microsoft Yahei" size:18];
    topTitleView.backgroundColor = [UIColor clearColor];
    topTitleView.textColor = KGColorFromHex(0x9b9b9b);
    topTitleView.textAlignment = NSTextAlignmentCenter;
    [topTitleView sizeToFit];
    self.navigationItem.titleView = topTitleView;
    self.topTitleView = topTitleView;
}
#pragma mark 绘制头部轮播图
- (void)setLunBoTuUI  {
    NSArray *picArray = @[@"1.jpeg",@"2.png",@"3.jpeg"];
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithObjects:@"风景",@"游戏",@"美女", nil];
    
//    _headScrollView = [KNBannerView bannerViewWithNetWorkImagesArr:picArray frame:CGRectMake(0,0,self.view.width, 180)];//网络请求图片初始化方式
    
    _headScrollView = [KNBannerView bannerViewWithLocationImagesArr:picArray frame:CGRectMake(0,0,self.view.width, 180)];
    _headScrollView.delegate = self;
    _headScrollView.placeHolder = @"3";
    _headScrollView.textShowStyle = KNTextShowStyleStay;
    _headScrollView.tag = 100;
    _headScrollView.IntroduceStringArr = titleArray;
    _headScrollView.timeInterval = 2; // 图片轮播的时间间隔
    _headScrollView.IntroduceTextFont = [UIFont fontWithName:@"Arial" size:14];; //介绍文字字体大小
    _headScrollView.IntroduceBackGroundAlpha = 1.0;// 介绍文字的透明度
    _headScrollView.IntroduceBackGroundColor = MQColor(0, 0, 0, 0.4); //介绍文字的背景色
    //bannerView.IntroduceHeight = 60;  //介绍文字的高度
    _headScrollView.IntroduceTextColor = [UIColor whiteColor];  //介绍文字的颜色
    _headScrollView.PageIndicatorTintColor = [UIColor whiteColor]; //pageControl的 其他'点'的颜色
    _headScrollView.CurrentPageIndicatorTintColor = KGColorFromHex(0xe34449); //pageControl的 当前'点'的颜色
    _headScrollView.pageControlStyle = KNPageControlStyleLeft; //pageControl 对其方式
    _headScrollView.IntroduceStyle = KNIntroduceStyleRight; //介绍文字的对其方式
    _headScrollView.textShowStyle = KNTextShowStyleFadeOut; //介绍文字的 显示样式 : 滚动 || 显现 || 直接切换
    _headScrollView.delegate = self;
    _headScrollView.tag = 200;
    [self.sencondeView addSubview:_headScrollView];
}
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"%zd---%zd",bannerView.tag,index);
    NSArray *urlArray = @[@"https://www.baidu.com",@"http://www.jianshu.com/p/c8152d6ce957",@"http://www.jianshu.com/p/5e2c3eefd0a5"];
    NSString *urlStr = urlArray[index];
    if ([urlStr isEqualToString:@"#"]) {
        NSLog(@"不做跳转");
    }
    else {
        NSLog(@"跳转到详情");
        
    }
    
}


-(void)acceptMsg : (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //导航栏渐变效果设置
    UIColor * color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat minAlphaOffset = - 64;
    CGFloat maxAlphaOffset = 52;
    CGFloat alpha = (offsetY - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    self.topTitleView.alpha = alpha;
    
    /**
     * 处理联动
     */
    //获取滚动视图y值的偏移量
    CGFloat tabOffsetY = [mainTableView rectForSection:0].origin.y;
    
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY >=tabOffsetY  - 60.5 - 64) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY - 60.5 - 64);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            //到达顶部，置初始y向下偏移20像素
            _canScroll = NO;
            
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
    
    
}

#pragma marl -tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //添加pageView
    [cell.contentView addSubview:self.setPageViewControllers];
    return cell;
}

/*
 * 这里可以任意替换你喜欢的pageView
 */
-(UIView *)setPageViewControllers
{
    
    if (!_headview) {
        
        HeadView *head = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)  ParentController:self DataArray:nil];
        _headview = head;
        head.userInteractionEnabled = YES;
        self.headview = head;
    }
    return _headview;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"leaveTop" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
