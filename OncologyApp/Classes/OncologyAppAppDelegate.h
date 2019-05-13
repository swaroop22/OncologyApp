//
//  OncologyAppAppDelegate.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/14/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Regimen.h"
#import "RegimenDetail.h"

@interface OncologyAppAppDelegate : NSObject <UIApplicationDelegate> {
	
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
	IBOutlet UINavigationBar *navigationBar;
	
	sqlite3 *database;
	NSMutableArray *regimens;
    
    //* TNM Arrays
    NSMutableArray *tnmList;
    NSMutableArray *tnmT;
    NSMutableArray *tnmN;
    NSMutableArray *tnmM;
    NSMutableArray *tnmStage;

}

- (NSMutableArray *)loadTNMList:(const char *)sql;
- (void)loadTNMByID:(int)listID;
- (NSMutableArray *)loadTNM:(const char *)sql;
- (void)loadTNMStage:(int)listID;


//- (void) getRegimenCancerList;
//- (void) getRegimensByListID: (NSInteger)listID;

- (RegimenDetail*)getRegimenDetailByID:(NSInteger)regimenID;
- (NSMutableArray*)getRegimenMedicationsByID:(NSInteger)regimenID;
- (NSString*)getCSS;
- (NSString*)getStagingByTNM:(NSString *)t_code n_code:(NSString *)n_code m_code:(NSString *)m_code;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UINavigationBar *navigationBar;

@property (nonatomic, retain) NSMutableArray *patientTypeList;
@property (nonatomic, retain) NSMutableArray *cancerTypeList;
@property (nonatomic, retain) NSMutableArray *subCancerTypeList1;
@property (nonatomic, retain) NSMutableArray *subCancerTypeList2;
@property (nonatomic, retain) NSMutableArray *regimenList;
//@property (nonatomic, retain) NSMutableArray *regimens;

- (void) removeDB;
- (void) getPatientTypeList;
- (void) getCancerTypesByPatientTypeID: (NSInteger)patientTypeID;
- (void) getSubCancerTypes1ByCancerTypeID: (NSInteger)cancerTypeID;
- (void) getSubCancerTypes2BySubCancerTypeID1: (NSInteger)subCancerTypeID1;
- (void) getRegimensBySubCancerTypeID2: (NSInteger)subCancerTypeID2;
- (void) displayDisclaimer;

@property (nonatomic, retain) NSMutableArray *tnmList;
@property (nonatomic, retain) NSMutableArray *tnmT;
@property (nonatomic, retain) NSMutableArray *tnmN;
@property (nonatomic, retain) NSMutableArray *tnmM;
@property (nonatomic, retain) NSMutableArray *tnmStage;
@property (nonatomic) int tnmListId;

@property (nonatomic, retain) NSMutableArray *ECOGTCGroup;
@property (nonatomic, retain) NSMutableArray *gen2brandArray;

//@property (nonatomic, retain) NSMutableArray *ECOGTCSubGroup;

- (void)loadECOGTCGroup;
- (void)loadGen2Brand;
- (NSMutableArray*)loadECOGTCSubGroup:(int)groupId;
- (NSMutableArray*)loadECOGTCOptions:(int)subGroupId;

@end

