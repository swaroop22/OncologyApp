//
//  Gen2BrandTableViewCell.m
//  OncAmigo
//
//  Created by Niranjan Kode on 3/10/16.
//
//

#import "Gen2BrandTableViewCell.h"

@implementation Gen2BrandTableViewCell


@synthesize genericLabel;
@synthesize brandLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
