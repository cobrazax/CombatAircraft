//
// VirtualGood.h
// Created by Applicasa 
// 6/24/2013
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiKitFacebook.h>
#import <LiCore/LiKitIAP.h>
#import <LiCore/UpdateObject.h>



//*************
//
// VirtualGood Class
//
//

#define kVirtualGoodNotificationString @"VirtualGoodConflictFound"
#define kShouldVirtualGoodWorkOffline YES
@class VirtualGoodCategory;
@interface VirtualGood : LiObject <LiCoreRequestDelegate,LiKitIAPDelegate> {
}

@property (nonatomic, strong) NSString *virtualGoodID;
@property (nonatomic, strong) NSString *virtualGoodTitle;
@property (nonatomic, strong) NSString *virtualGoodDescription;
@property (nonatomic, strong) NSString *virtualGoodAppleIdentifier;
@property (nonatomic, strong) NSString *virtualGoodGoogleIdentifier;
@property (nonatomic, assign) int virtualGoodMainCurrency;
@property (nonatomic, assign) int virtualGoodSecondaryCurrency;
@property (nonatomic, strong) NSString *virtualGoodRelatedVirtualGood;
@property (nonatomic, assign) float virtualGoodStoreItemPrice;
@property (nonatomic, assign) float virtualGoodIOSBundleMin;
@property (nonatomic, assign) float virtualGoodIOSBundleMax;
@property (nonatomic, assign) float virtualGoodAndroidBundleMin;
@property (nonatomic, assign) float virtualGoodAndroidBundleMax;
@property (nonatomic, assign, readonly) int virtualGoodPos;
@property (nonatomic, assign) int virtualGoodMaxForUser;
@property (nonatomic, assign) int virtualGoodUserInventory;
@property (nonatomic, assign) int virtualGoodQuantity;
@property (nonatomic, strong) NSURL *virtualGoodImageA;
@property (nonatomic, strong) NSURL *virtualGoodImageB;
@property (nonatomic, strong) NSURL *virtualGoodImageC;
@property (nonatomic, assign) BOOL virtualGoodIsDeal;
@property (nonatomic, assign) BOOL virtualGoodConsumable;
@property (nonatomic, assign) BOOL virtualGoodIsStoreItem;
@property (nonatomic, assign) BOOL virtualGoodInAppleStore;
@property (nonatomic, assign) BOOL virtualGoodInGoogleStore;
@property (nonatomic, strong, readonly) NSDate *virtualGoodLastUpdate;
@property (nonatomic, strong) VirtualGoodCategory *virtualGoodMainCategory;
@property (nonatomic, retain) SKProduct *product;
@property (nonatomic, retain) NSDecimalNumber *itunesPrice;

#pragma mark - End of Basic SDK

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/

+ (void) getLocalArrayWithQuery:(LiQuery *)query andBlock:(GetVirtualGoodArrayFinished)block;
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetVirtualGoodArrayFinished)block;

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type withBlock:(GetVirtualGoodArrayFinished)block;

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type andCategory:(VirtualGoodCategory *)category withBlock:(GetVirtualGoodArrayFinished)block;

- (void) buyQuantity:(NSInteger)quantity withCurrencyKind:(LiCurrency)currencyKind andBlock:(LiBlockAction)block;

- (void) giveQuantity:(NSInteger)quantity withBlock:(LiBlockAction)block;

- (void) useQuantity:(NSInteger)quantity withBlock:(LiBlockAction)block;

- (void) buyWithRealMoneyAndBlock:(LiBlockAction)block;

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type byCategoryPosition:(int)position withBlock:(GetVirtualGoodArrayFinished)block;


@end
