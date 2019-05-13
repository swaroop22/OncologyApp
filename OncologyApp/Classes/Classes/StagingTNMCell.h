//
//  StagingTNMCell.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>

@interface StagingTNMCell : UITableViewCell
{
    NSDictionary	*dataDictionary;
    //UILabel *codeLabel;
    //UITextView *descTextView;
}

@property (nonatomic, retain) NSDictionary *dataDictionary;
@property (nonatomic, retain) IBOutlet UILabel *codeLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic) boolean_t displayCode;
@property (nonatomic) boolean_t displayHtml;
//@property (nonatomic, retain) IBOutlet UITextView *descTextView;

@end
