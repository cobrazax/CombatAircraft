//
// CombatAircraft.h
// Created by Applicasa 
// 6/24/2013
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiKitFacebook.h>
#import <LiCore/UpdateObject.h>



//*************
//
// CombatAircraft Class
//
//

#define kCombatAircraftNotificationString @"CombatAircraftConflictFound"
#define kShouldCombatAircraftWorkOffline YES
@interface CombatAircraft : LiObject <LiCoreRequestDelegate> {
}

@property (nonatomic, strong) NSString *combatAircraftID;
@property (nonatomic, strong, readonly) NSDate *combatAircraftLastUpdate;
@property (nonatomic, strong) NSString *combatAircraftAircraftName;
@property (nonatomic, strong) NSURL *combatAircraftAircraftImage;
@property (nonatomic, strong) NSString *combatAircraftDescription;
@property (nonatomic, strong) NSString *combatAircraftDetails;
@property (nonatomic, strong) NSString *combatAircraftVideoURL;

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/
 
// Save CombatAircraftitem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase CombatAircraft int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Delete CombatAircraft item from Applicasa DB
- (void) deleteWithBlock:(LiBlockAction)block;

// Get CombatAircraft item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetCombatAircraftFinished)block;

// Get CombatAircraft Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetCombatAircraftArrayFinished)block;

// Get CombatAircraft Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetCombatAircraftArrayFinished)block;

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind;

+ (void) getArrayWithFilter:(LiFilters *)filter withBlock:(UpdateObjectFinished)block;

// uploadFile
- (void) uploadFile:(NSData *)data toField:(LiFields)field withFileType:(AMAZON_FILE_TYPES)fileType extension:(NSString *)ext andBlock:(LiBlockAction)block;


#pragma mark - End of Basic SDK

@end
