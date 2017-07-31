//
//  inforListCell.m
//  GYouZiXun
//
//  Created by 马卿 on 2017/2/4.
//  Copyright © 2017年 马卿. All rights reserved.
//

#import "inforListCell.h"


//屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define KGColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >>8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
#define MQColor(r, g, b, t) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:t]

@interface inforListCell()
@property (nonatomic, strong) UIImageView *inforImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *classLabel;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UILabel *chatLabel;

@end

@implementation inforListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setInforListCellSubViews];
    }
    return self;
}
- (void)setInforListCellSubViews {
    UIImageView *inforImageView = [[UIImageView alloc]init];
    inforImageView.frame = CGRectMake(15, 10, 100, 80);
    inforImageView.image = [UIImage imageNamed:@"1"];
    [self.contentView addSubview:inforImageView];
    self.inforImageView = inforImageView;
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectMake(CGRectGetMaxX(inforImageView.frame) + 10, 15, SCREEN_WIDTH -CGRectGetMaxX(inforImageView.frame) - 10 -15 , 21);
    titlelabel.text = @"微软确认《龙灵化身》项目取消";
    titlelabel.font = [UIFont fontWithName:@"Arial" size:12];
    NSLog(@"%@",[UIFont familyNames]);
    titlelabel.textColor = KGColorFromHex(0x686868);
    [self.contentView addSubview:titlelabel];
    self.titleLabel = titlelabel;
    
    UILabel *describeLabel = [[UILabel alloc]init];
    describeLabel.frame = CGRectMake(CGRectGetMaxX(inforImageView.frame) + 10, CGRectGetMaxY(titlelabel.frame) + 5, SCREEN_WIDTH -CGRectGetMaxX(inforImageView.frame) - 10 -15 , 21);
    describeLabel.text = @"微软发言人向媒体确认《龙灵化身》项目取消";
    describeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    describeLabel.textColor = KGColorFromHex(0x7f7f7f);
    [self.contentView addSubview:describeLabel];
    self.describeLabel = describeLabel;
    
    UILabel *classLabel = [[UILabel alloc]init];
    classLabel.frame = CGRectMake(CGRectGetMaxX(inforImageView.frame) + 10, CGRectGetMaxY(describeLabel.frame) + 5, 50 , 21);
    classLabel.text = @"资讯头条";
    classLabel.font = [UIFont fontWithName:@"Arial" size:12];
    classLabel.textColor = KGColorFromHex(0x7f7f7f);
    [self.contentView addSubview:classLabel];
    self.classLabel = classLabel;
    
    UIImageView *likeImageView = [[UIImageView alloc]init];
    likeImageView.frame = CGRectMake(CGRectGetMaxX(classLabel.frame) , CGRectGetMaxY(describeLabel.frame) + 8, 15, 15);
    likeImageView.image = [UIImage imageNamed:@"home_like"];
    [self.contentView addSubview:likeImageView];
    
    UILabel *likeLabel = [[UILabel alloc]init];
    likeLabel.frame = CGRectMake(CGRectGetMaxX(likeImageView.frame) +2, CGRectGetMaxY(describeLabel.frame) + 5, 50 , 21);
    likeLabel.text = @"4500";
    likeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    likeLabel.textColor = KGColorFromHex(0x7f7f7f);
    [self.contentView addSubview:likeLabel];
    self.likeLabel = likeLabel;
    
    
    UIImageView *chatImageView = [[UIImageView alloc]init];
    chatImageView.frame = CGRectMake(CGRectGetMaxX(likeLabel.frame) , CGRectGetMaxY(describeLabel.frame) + 8, 15, 15);
    chatImageView.image = [UIImage imageNamed:@"home_chat"];
    [self.contentView addSubview:chatImageView];
    
    UILabel *chatLabel = [[UILabel alloc]init];
    chatLabel.frame = CGRectMake(CGRectGetMaxX(chatImageView.frame)+2, CGRectGetMaxY(describeLabel.frame) + 5, 50 , 21);
    chatLabel.text = @"4500";
    chatLabel.font = [UIFont fontWithName:@"Arial" size:12];
    chatLabel.textColor = KGColorFromHex(0x7f7f7f);
    [self.contentView addSubview:chatLabel];
    self.chatLabel = chatLabel;

}
+(id)cellWithTable:(UITableView *)table {
    static NSString *cellID = @"inforListCell";
    inforListCell *cell = [table dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[inforListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
