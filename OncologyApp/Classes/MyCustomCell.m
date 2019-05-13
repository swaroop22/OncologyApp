//
// File:	   MyCustomCell.m
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "MyCustomCell.h"
#import "Constants.h"

@implementation MyCustomCell

@synthesize dataDictionary;
@synthesize nameLabel;
@synthesize explainLabel;

#define LEFT_COLUMN_OFFSET		10
#define LEFT_COLUMN_WIDTH		270
		
#define UPPER_ROW_TOP			0

#define CELL_HEIGHT				50
	

- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
{
	self = [super initWithFrame:aRect reuseIdentifier:identifier];
	if (self)
	{
		// you can do this here specifically or at the table level for all cells
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		// Create label views to contain the various pieces of text that make up the cell.
		// Add these as subviews.
		nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];	// layoutSubViews will decide the final frame
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.opaque = NO;
		nameLabel.textColor = [UIColor purpleColor];
		//nameLabel.textColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1.0];
		nameLabel.highlightedTextColor = [UIColor whiteColor];
		nameLabel.font = [UIFont boldSystemFontOfSize:16];
		[self.contentView addSubview:nameLabel];
		
		explainLabel = [[UILabel alloc] initWithFrame:CGRectZero];	// layoutSubViews will decide the final frame
		explainLabel.backgroundColor = [UIColor clearColor];
		explainLabel.opaque = NO;
		explainLabel.textColor = [UIColor grayColor];
		explainLabel.highlightedTextColor = [UIColor whiteColor];
		explainLabel.font = [UIFont systemFontOfSize:14];
		[self.contentView addSubview:explainLabel];
		
		//UIImageView *accessoryViewImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)]] autorelease];
		//UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		//[activityView startAnimating];
		//self.accessoryView = activityView;
		//[activityView release];
		//UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
		//imageView.userInteractionEnabled = YES;
		UIButton* accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
		accessoryButton.bounds = CGRectMake(0, 0, 28.0, 28.0);
		[accessoryButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
		[accessoryButton addTarget:self action:@selector( myAction: ) forControlEvents:UIControlEventTouchUpInside];
		//[accessoryButton setImage:imageView forState:UIControlStateNormal]; //imageView from above
		//[imageView release];
		
		self.accessoryView = accessoryButton;
}
	
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    CGRect contentRect = [self.contentView bounds];
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    CGRect frame = CGRectMake(contentRect.origin.x + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP, LEFT_COLUMN_WIDTH, CELL_HEIGHT);
	nameLabel.frame = frame;
    nameLabel.backgroundColor = [UIColor redColor];
	
	frame = CGRectMake(contentRect.origin.x + 65.0 + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP, LEFT_COLUMN_WIDTH, CELL_HEIGHT);
	explainLabel.frame = frame;
}

- (void)dealloc
{
	[nameLabel release];
	[explainLabel release];
	[dataDictionary release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	// when the selected state changes, set the highlighted state of the lables accordingly
	nameLabel.highlighted = selected;
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
	nameLabel.text = [dataDictionary objectForKey:kTitleKey];
	explainLabel.text = [dataDictionary objectForKey:kExplainKey];
}

@end
