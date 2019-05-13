//
//  MyCustomCell2Cell.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/25/12.
//
//

#import "MyCustomCell2.h"
#import "Constants.h"

@implementation MyCustomCell2

@synthesize nameLabel;
@synthesize explainLabel;
@synthesize dataDictionary;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
	self.nameLabel.text = [dataDictionary objectForKey:kTitleKey];
	self.explainLabel.text = [dataDictionary objectForKey:kExplainKey];
}

@end
