//
//  StagingDetailViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import <UIKit/UIKit.h>

@interface StagingDetailViewController : UITableViewController {
}

@property (nonatomic, retain) UITableView *stageDetailTableView;
@property (strong, nonatomic) NSString *t_code;
@property (strong, nonatomic) NSString *t_desc;
@property (strong, nonatomic) NSString *n_code;
@property (strong, nonatomic) NSString *n_desc;
@property (strong, nonatomic) NSString *m_code;
@property (strong, nonatomic) NSString *m_desc;
@property (strong, nonatomic) NSString *stage;
@property (strong, nonatomic) NSString *note;


@end
