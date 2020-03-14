# LLBarChart


Demo效果如下:

![LLBarChart.gif](LLBarChart.gif)

创建试图方法如下:
```
    NSArray *xLabels = @[@"Python", @"iOS", @"Java", @"C", @"C++", @"Android"];
    NSArray *yLabels = @[@20, @40, @60, @80, @100];
    NSArray *dataArray = @[@0, @30, @38, @100, @90, @50];
    
    _barChart = [[LLBarChart alloc] initWithFrame:CGRectMake(30, 100, 300, 300) offset:CGSizeMake(10, 7)];
    _barChart.xLabels = xLabels;
    _barChart.yLabels = yLabels;
    _barChart.dataArray = dataArray;
    _barChart.ySuffix = @"人";
    _barChart.barWidth = 30;
    _barChart.barBlank = 30;
    _barChart.delegate = self;
    _barChart.needAnimation = YES;
    [self.view addSubview:_barChart];
```
调用开始动画的方法一共有三种，任意一种都可以，最后一种除支持设置动画时间外，还支持动画完成回调：
```
/**
 * @brief 开始动画
 * @param duration 动画时间
 * @param completion 动画完成回调
 */
- (void)startAnimate;

- (void)startAnimateWithDuration:(NSTimeInterval)duration;

- (void)startAnimateWithDuration:(NSTimeInterval)duration completion:(void (^ __nullable)())completion;
```
点击bar的回调方法如下:
```
// 需要先设置delegate
- (void)barChartDidSelected:(LLBarChart *)barChart bar:(LLBar *)bar {
NSLog(@"点击柱形图回调");
}
```
详细API接口如下:
```
NS_ASSUME_NONNULL_BEGIN

@class LLBarChart;
@class LLBar;

@protocol LLBarChartDelegate <NSObject>

// 点击回调
- (void)barChartDidSelected:(LLBarChart *)barChart bar:(LLBar *)bar;

@end

@interface LLBarChart : UIView

/**
 * @brief init Method
 * @param offset offset.width y轴的偏移量
                 offset.height x轴的偏移量
 */
- (instancetype)initWithFrame:(CGRect)frame offset:(CGSize)offset;

// LLBarChartDelegate
@property (nonatomic, weak) id <LLBarChartDelegate>delegate;
// 渐变背景
@property (nonatomic, strong, readonly) CAGradientLayer *gradientLayer;
// x轴显示坐标内容(任意内容)
@property (nonatomic, strong) NSArray <NSString *>*xLabels;
// x轴显示坐标内容(具体值)
@property (nonatomic, strong) NSArray <NSNumber *>*yLabels;
// 数据源
@property (nonatomic, strong) NSArray <NSNumber *>*dataArray;
// y轴坐标后缀
@property (nonatomic, copy) NSString *ySuffix;
// bar宽度
@property (nonatomic, assign) CGFloat barWidth;
// bar之间的空隙
@property (nonatomic, assign) CGFloat barBlank;
// 是否需要动画显示(default is NO)
@property (nonatomic, assign) BOOL needAnimation;

/**
 * @brief 开始动画
 * @param duration 动画时间
 * @param completion 动画完成回调
 */
- (void)startAnimate;

- (void)startAnimateWithDuration:(NSTimeInterval)duration;

- (void)startAnimateWithDuration:(NSTimeInterval)duration completion:(void (^ __nullable)())completion;

@end

NS_ASSUME_NONNULL_END
```
