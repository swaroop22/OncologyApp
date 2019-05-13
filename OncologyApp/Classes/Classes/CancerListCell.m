//
//  CancerListCell.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "CancerListCell.h"

@implementation CancerListCell

@synthesize nameLabel;
@synthesize dataDictionary;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setDataDictionary:(NSDictionary *)newDictionary
{
	if (dataDictionary == newDictionary)
	{
		return;
	}
	[dataDictionary release];
	dataDictionary = [newDictionary retain];
	
	// update value in subviews
    self.nameLabel.font = [UIFont fontWithName:@"Helvitica" size:15.0];
	self.nameLabel.text = [[[dataDictionary objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
