//
//  RegimenCell.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/17/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegimenCell : UITableViewCell {
	
	NSInteger level;
	NSInteger parentID;
	IBOutlet UILabel *nameLabel;

}

- (void)setLabel:(NSString*)aString;

@property (nonatomic, retain) UILabel *nameLabel;
@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger parentID;

@end
