//
// File:	   MyCustomCell.h
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomCell : UITableViewCell
{
	NSDictionary	*dataDictionary;
	UILabel			*nameLabel;
	UILabel			*explainLabel;
}

@property (nonatomic, retain) NSDictionary *dataDictionary;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *explainLabel;

@end
