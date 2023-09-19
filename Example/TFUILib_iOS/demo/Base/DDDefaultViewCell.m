//
//  DDDefaultViewCell.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDDefaultViewCell.h"

@implementation DDDefaultViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    };
    
    return self;
}

@end
