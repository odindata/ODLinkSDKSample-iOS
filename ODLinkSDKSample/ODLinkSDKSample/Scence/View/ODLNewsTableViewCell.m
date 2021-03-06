//
//  ODLNewsTableViewCell.m
//  MobLinkProDemo
//
//  Created by youzu on 2017/10/25.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "ODLNewsTableViewCell.h"

@interface ODLNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *subTitleL;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@end

@implementation ODLNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.imageV.image = [UIImage imageNamed:dict[@"imageName"]];
    self.titleL.text = dict[@"title"];
    NSString *subStr = dict[@"subTitle"];
    self.subTitleL.text = subStr;
    NSMutableAttributedString *mAttriStr = nil;
    if ([subStr hasPrefix:@"置顶"]) {
        NSRange range = [subStr rangeOfString:@"置顶"];
        mAttriStr = [[NSMutableAttributedString alloc] initWithString:subStr];
        [mAttriStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        self.subTitleL.attributedText = mAttriStr;
    }
}

@end
