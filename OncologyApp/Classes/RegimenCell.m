//
//  RegimenCell.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/17/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RegimenCell.h"
#import "Constants.h"


@implementation RegimenCell

@synthesize nameLabel, level, parentID;

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

- (void)setLabel:(NSString*) aString
{
    nameLabel.text = aString;    
}


//#define LEFT_COLUMN_OFFSET		10
//#define LEFT_COLUMN_WIDTH		270
//
//#define UPPER_ROW_TOP			0
//
//#define CELL_HEIGHT				40
//
//- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
//{
//	self = [super initWithFrame:aRect reuseIdentifier:identifier];
//	if (self)
//	{
//		// you can do this here specifically or at the table level for all cells
//		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//		
//		// Create label views to contain the various pieces of text that make up the cell.
//		// Add these as subviews.
//		nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];	// layoutSubViews will decide the final frame
//		nameLabel.backgroundColor = [UIColor clearColor];
//		nameLabel.opaque = NO;
//		nameLabel.textColor = [UIColor purpleColor];
//		//nameLabel.textColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1.0];
//		nameLabel.highlightedTextColor = [UIColor whiteColor];
//		nameLabel.font = [UIFont boldSystemFontOfSize:16];
//		nameLabel.numberOfLines = 2;
//		[self.contentView addSubview:nameLabel];
//		
//	}
//	
//	return self;
//}
//
//- (void)layoutSubviews
//{
//	[super layoutSubviews];
//    CGRect contentRect = [self.contentView bounds];
//	
//	// In this example we will never be editing, but this illustrates the appropriate pattern
//    CGRect frame = CGRectMake(contentRect.origin.x + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP, LEFT_COLUMN_WIDTH, CELL_HEIGHT);
//	nameLabel.frame = frame;
//	
//}
//
//- (void)setLabel:(NSString*) aString
//{
//	if (level == 1)
//	{
//		nameLabel.font = [UIFont boldSystemFontOfSize:16];
//	}
//	else if (level == 2)
//	{
//		nameLabel.font = [UIFont boldSystemFontOfSize:14];
//	}
//	else
//	{
//		nameLabel.font = [UIFont boldSystemFontOfSize:12];
//	}
//	nameLabel.text = aString;
//}
//
//- (void)setLevel:(NSInteger) aInt
//{
//	level = aInt;
//}
//
//- (NSInteger)parentID {
//    return parentID;
//}
//
//- (void)setParentID:(NSInteger) aInt
//{
//	parentID = aInt;
//}
//
//- (void)dealloc
//{
//	[nameLabel release];
//    [super dealloc];
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//	[super setSelected:selected animated:animated];
//	
//	// when the selected state changes, set the highlighted state of the lables accordingly
//	nameLabel.highlighted = selected;
//}

@end
