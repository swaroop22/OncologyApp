//
//  MyCustomCell2Cell.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/25/12.
//
//

#import <UIKit/UIKit.h>

@interface MyCustomCell2 : UITableViewCell
{
    NSDictionary	*dataDictionary;
    UILabel *nameLable;
    UILabel *explainLabel;
}

@property (nonatomic, retain) NSDictionary *dataDictionary;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *explainLabel;

@end
