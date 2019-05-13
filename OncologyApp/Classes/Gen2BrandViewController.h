//
//  Gen2BrandViewController.h
//  OncAmigo
//
//  Created by Niranjan Kode on 2/6/16.
//
//

#import <UIKit/UIKit.h>
#import "Gen2BrandTableViewCell.h"

@interface Gen2BrandViewController : UITableViewController <UISearchDisplayDelegate>
{
    UINib *cellLoader;
}

@property (nonatomic, strong) NSMutableArray *searchResult;
@property (nonatomic, strong) NSMutableArray *tableData;

@end
