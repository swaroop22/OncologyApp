//
//  RegimenMedicationCell.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegimenMedicationCell : UITableViewCell {
	
	UILabel *medicationLabel;
	UILabel *dosageLabel;
	
}

- (void)setMLabel:(NSString*)aString;
- (void)setDLabel:(NSString*)aString;

@property (nonatomic, retain) UILabel *medicationLabel;
@property (nonatomic, retain) UILabel *dosageLabel;

@end
