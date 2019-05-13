//
//  StagingTNMCell.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "StagingTNMCell.h"

@implementation StagingTNMCell

@synthesize codeLabel, descLabel;
@synthesize dataDictionary;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.displayCode = TRUE;
    self.displayHtml = FALSE;
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
	
    if (self.displayCode) {
        // update value in subviews
        self.codeLabel.hidden = FALSE;
        self.codeLabel.text = [dataDictionary objectForKey:@"code"];
        self.descLabel.numberOfLines = 0;
        self.descLabel.text = [dataDictionary objectForKey:@"description"];
        [self.descLabel sizeToFit];

        // adjust the height of labels

        if (self.descLabel.frame.size.height < 34.0) {
            CGRect descFrame = CGRectMake(self.descLabel.frame.origin.x,self.descLabel.frame.origin.y, self.descLabel.frame.size.width, 34.0);
            self.descLabel.frame = descFrame;
        }
        CGRect codeFrame = CGRectMake(self.codeLabel.frame.origin.x,self.codeLabel.frame.origin.y, self.codeLabel.frame.size.width, self.descLabel.frame.size.height);
        self.codeLabel.frame = codeFrame;
    }
    else {
        self.codeLabel.hidden = TRUE;
        self.descLabel.numberOfLines = 0;
        self.descLabel.text = [dataDictionary objectForKey:@"description"];
        [self.descLabel sizeToFit];
        CGRect descFrame = CGRectMake(self.codeLabel.frame.origin.x + 5,self.codeLabel.frame.origin.y, self.descLabel.frame.size.width, 34.0);
        if (self.descLabel.frame.size.height > 34.0) {
            descFrame = CGRectMake(self.codeLabel.frame.origin.x + 5,self.codeLabel.frame.origin.y, self.descLabel.frame.size.width, self.descLabel.frame.size.height);
        }
        self.descLabel.frame = descFrame;
    }
    //self.descLabel.backgroundColor = [UIColor redColor];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
