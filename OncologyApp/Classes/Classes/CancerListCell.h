//
//  CancerListCell.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>

@interface CancerListCell : UITableViewCell
{
    NSDictionary	*dataDictionary;
    //UILabel *nameLabel;
}

@property (nonatomic, retain) NSDictionary *dataDictionary;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;

@end
