//
//  RegimenMedicationCell.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RegimenMedicationCell.h"


@implementation RegimenMedicationCell

@synthesize medicationLabel;
@synthesize dosageLabel;

#define LEFT_COLUMN_OFFSET		10
#define LEFT_COLUMN_WIDTH		270

#define UPPER_ROW_TOP			0

#define CELL_HEIGHT				100


- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
{
	self = [super initWithFrame:aRect reuseIdentifier:identifier];
	if (self)
	{
		// you can do this here specifically or at the table level for all cells
		self.accessoryType = UITableViewCellAccessoryNone;
		
		// Create label views to contain the various pieces of text that make up the cell.
		// Add these as subviews.
		medicationLabel = [[UILabel alloc] initWithFrame:CGRectZero];	// layoutSubViews will decide the final frame
		medicationLabel.backgroundColor = [UIColor clearColor];
		medicationLabel.opaque = NO;
		medicationLabel.textColor = [UIColor purpleColor];
		//nameLabel.textColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1.0];
		medicationLabel.highlightedTextColor = [UIColor whiteColor];
		medicationLabel.font = [UIFont boldSystemFontOfSize:13];
		[self.contentView addSubview:medicationLabel];
		
		dosageLabel = [[UILabel alloc] initWithFrame:CGRectZero];	// layoutSubViews will decide the final frame
		dosageLabel.backgroundColor = [UIColor clearColor];
		dosageLabel.opaque = NO;
		dosageLabel.textColor = [UIColor darkGrayColor];
		dosageLabel.highlightedTextColor = [UIColor whiteColor];
		dosageLabel.font = [UIFont italicSystemFontOfSize:12];
		dosageLabel.numberOfLines = 5;
		//dosageLabel.backgroundColor = [UIColor magentaColor];
		dosageLabel.lineBreakMode = UILineBreakModeWordWrap;
		[self.contentView addSubview:dosageLabel];
	}
	
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    CGRect contentRect = [self.contentView bounds];
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    CGRect frame = CGRectMake(contentRect.origin.x + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP, LEFT_COLUMN_WIDTH, 30);
	medicationLabel.frame = frame;
	
	frame = CGRectMake(contentRect.origin.x + 10.0 + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP+30, LEFT_COLUMN_WIDTH, CELL_HEIGHT-30);
	dosageLabel.frame = frame;
}

- (void)setMLabel:(NSString *)aString {
	medicationLabel.text = aString;
}

- (void)setDLabel:(NSString *)aString {
	dosageLabel.text = aString;
}

//- (void)setMedicationLabel:(NSString *)aString {
//    medicationLabel.text = aString;
//}

//- (void)setDosageLabel:(NSString *)aString {
//	dosageLabel.text = aString;
//}


- (void)dealloc
{
	[medicationLabel release];
	[dosageLabel release];
    [super dealloc];
}


@end
