//
// CombatAircraft.m
// Created by Applicasa 
// 6/24/2013
//

#import "CombatAircraft.h"

#define kClassName                  @"CombatAircraft"

#define KEY_combatAircraftID				@"CombatAircraftID"
#define KEY_combatAircraftLastUpdate				@"CombatAircraftLastUpdate"
#define KEY_combatAircraftAircraftName				@"CombatAircraftAircraftName"
#define KEY_combatAircraftAircraftImage				@"CombatAircraftAircraftImage"
#define KEY_combatAircraftDescription				@"CombatAircraftDescription"
#define KEY_combatAircraftDetails				@"CombatAircraftDetails"
#define KEY_combatAircraftVideoURL				@"CombatAircraftVideoURL"

@interface CombatAircraft (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation CombatAircraft

@synthesize combatAircraftID;
@synthesize combatAircraftLastUpdate;
@synthesize combatAircraftAircraftName;
@synthesize combatAircraftAircraftImage;
@synthesize combatAircraftDescription;
@synthesize combatAircraftDetails;
@synthesize combatAircraftVideoURL;

enum CombatAircraftIndexes {
	CombatAircraftIDIndex = 0,
	CombatAircraftLastUpdateIndex,
	CombatAircraftAircraftNameIndex,
	CombatAircraftAircraftImageIndex,
	CombatAircraftDescriptionIndex,
	CombatAircraftDetailsIndex,
	CombatAircraftVideoURLIndex,};
#define NUM_OF_COMBATAIRCRAFT_FIELDS 7



#pragma mark - Save

- (void) saveWithBlock:(LiBlockAction)block{
	LiObjRequest *request = [LiObjRequest requestWithAction:Add ClassName:kClassName];
	request.shouldWorkOffline = kShouldCombatAircraftWorkOffline;

	[request setBlock:(__bridge void *)(block)];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.combatAircraftID]){
		request.action = Update;
		[request addValue:combatAircraftID forKey:KEY_combatAircraftID];
		if (self.increaseDictionary.count){
			[request.requestParameters setValue:self.increaseDictionary forKey:@"$inc"];
			self.increaseDictionary = nil;
		}
	} 	
	request.delegate = self;
	[request startSync:NO];
}

- (void) updateField:(LiFields)field withValue:(NSNumber *)value{
	switch (field) {
		default:
			break;
	}
}

#pragma mark - Increase

- (void) increaseField:(LiFields)field byValue:(NSNumber *)value{
    if (!self.increaseDictionary)
        self.increaseDictionary = [[NSMutableDictionary alloc] init];
    [self.increaseDictionary setValue:value forKey:[[self class] getFieldName:field]];
    [self updateField:field withValue:value];
}

#pragma mark - Delete

- (void) deleteWithBlock:(LiBlockAction)block{        
	LiObjRequest *request = [LiObjRequest requestWithAction:Delete ClassName:kClassName];
	request.shouldWorkOffline = kShouldCombatAircraftWorkOffline;
	[request setBlock:(__bridge void *)(block)];
	request.delegate = self;
	[request addValue:combatAircraftID forKey:KEY_combatAircraftID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetCombatAircraftFinished)block{
    __block CombatAircraft *item = [CombatAircraft instance];

    LiFilters *filters = [LiBasicFilters filterByField:CombatAircraftID Operator:Equal Value:idString];
    LiQuery *query = [[LiQuery alloc]init];
    [query setFilters:filters];
    
    [self getArrayWithQuery:query queryKind:queryKind withBlock:^(NSError *error, NSArray *array) {
        item = nil;
        if (array.count)
            item = [array objectAtIndex:0];
        block(error,item);
    }];	 
}


#pragma mark - Get Array

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetCombatAircraftArrayFinished)block{
    CombatAircraft *item = [CombatAircraft instance];
    
 query = [self setFieldsNameToQuery:query];
    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:(__bridge void *)(block)];
    [request addIntValue:queryKind forKey:@"DbGetKind"];
    [request setDelegate:item];
    [request addValue:query forKey:@"query"];
    request.shouldWorkOffline = (queryKind == LOCAL);
    
    [request startSync:(queryKind == LOCAL)];
    
    if (queryKind == LOCAL)
        [item requestDidFinished:request];
}

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetCombatAircraftArrayFinished)block{
    CombatAircraft *item = [CombatAircraft instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:(__bridge void *)(block)];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    CombatAircraft *item = [CombatAircraft instance];
    
    query = [self setFieldsNameToQuery:query];
    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
    [request addIntValue:queryKind forKey:@"DbGetKind"];
    [request setDelegate:item];
    [request addValue:query forKey:@"query"];
    request.shouldWorkOffline = YES;
    
    [request startSync:YES];
    
    NSInteger responseType = request.response.responseType;   
    
    if (responseType == 1)
    {
        sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
    
        NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
    
        return [CombatAircraft getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
    }
    return nil;
}

+ (void) getArrayWithFilter:(LiFilters *)filter withBlock:(UpdateObjectFinished)block
{
    LiQuery *query = [[LiQuery alloc] initWithFilter:filter];
    query = [self setFieldsNameToQuery:query];
    [UpdateObject getArrayWithQuery:query andWithClassName:kClassName withBlock:block];
}

#pragma mark - Upload File

- (void) uploadFile:(NSData *)data toField:(LiFields)field withFileType:(AMAZON_FILE_TYPES)fileType extension:(NSString *)ext andBlock:(LiBlockAction)block{

    LiObjRequest *request = [LiObjRequest requestWithAction:UploadFile ClassName:kClassName];
    request.delegate = self;

	[request addValue:combatAircraftID forKey:KEY_combatAircraftID];
    [request addValue:ext forKey:@"ext"];
    [request addValue:data forKey:@"data"];
    [request addIntValue:fileType forKey:@"fileType"];
	[request addIntValue:field forKey:@"fileField"];
    [request addValue:[[self class] getFieldName:field] forKey:@"field"];
	[request setBlock:(__bridge void *)(block)];
    [request startSync:NO];
}

/*
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
*/
#pragma mark - Applicasa Delegate Methods


- (void) requestDidFinished:(LiObjRequest *)request{
    Actions action = request.action;
    NSInteger responseType = request.response.responseType;
    NSString *responseMessage = request.response.responseMessage;
    NSDictionary *responseData = request.response.responseData;
    
    switch (action) {
         case UploadFile:{
            LiFields fileField = [[request.requestParameters objectForKey:@"fileField"] intValue];
            [self setField:fileField toValue:[responseData objectForKey:kResult]];
        }
        case Add:
        case Update:
        case Delete:{
            NSString *itemID = [responseData objectForKey:KEY_combatAircraftID];
            if (itemID)
                self.combatAircraftID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.combatAircraftID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[CombatAircraft getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    CombatAircraft *instace = [[CombatAircraft alloc] init];
    instace.combatAircraftID = ID;
    return instace;
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetCombatAircraftArrayFinished _block = (__bridge GetCombatAircraftArrayFinished)block;
    _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case CombatAircraftID:
		self.combatAircraftID = value;
		break;
	case CombatAircraftAircraftName:
		self.combatAircraftAircraftName = value;
		break;
	case CombatAircraftAircraftImage:
		self.combatAircraftAircraftImage = value;
		break;
	case CombatAircraftDescription:
		self.combatAircraftDescription = value;
		break;
	case CombatAircraftDetails:
		self.combatAircraftDetails = value;
		break;
	case CombatAircraftVideoURL:
		self.combatAircraftVideoURL = value;
		break;
	default:
	break;
	}
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.combatAircraftID				= @"0";
		combatAircraftLastUpdate				= [[NSDate alloc] initWithTimeIntervalSince1970:0];
		self.combatAircraftAircraftName				= @"";
		self.combatAircraftAircraftImage				= [NSURL URLWithString:@""];
		self.combatAircraftDescription				= @"";
		self.combatAircraftDetails				= @"";
		self.combatAircraftVideoURL				= @"";
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.combatAircraftID               = [item objectForKey:KeyWithHeader(KEY_combatAircraftID, header)];
		combatAircraftLastUpdate               = [item objectForKey:KeyWithHeader(KEY_combatAircraftLastUpdate, header)];
		self.combatAircraftAircraftName               = [item objectForKey:KeyWithHeader(KEY_combatAircraftAircraftName, header)];
		self.combatAircraftAircraftImage               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_combatAircraftAircraftImage, header)]];
		self.combatAircraftDescription               = [item objectForKey:KeyWithHeader(KEY_combatAircraftDescription, header)];
		self.combatAircraftDetails               = [item objectForKey:KeyWithHeader(KEY_combatAircraftDetails, header)];
		self.combatAircraftVideoURL               = [item objectForKey:KeyWithHeader(KEY_combatAircraftVideoURL, header)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(CombatAircraft *)object {
	if (self = [super init]) {

		self.combatAircraftID               = object.combatAircraftID;
		combatAircraftLastUpdate               = object.combatAircraftLastUpdate;
		self.combatAircraftAircraftName               = object.combatAircraftAircraftName;
		self.combatAircraftAircraftImage               = object.combatAircraftAircraftImage;
		self.combatAircraftDescription               = object.combatAircraftDescription;
		self.combatAircraftDetails               = object.combatAircraftDetails;
		self.combatAircraftVideoURL               = object.combatAircraftVideoURL;

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:combatAircraftID forKey:KEY_combatAircraftID];
	[dictionary addDateValue:combatAircraftLastUpdate forKey:KEY_combatAircraftLastUpdate];
	[dictionary addValue:combatAircraftAircraftName forKey:KEY_combatAircraftAircraftName];
	[dictionary addValue:combatAircraftAircraftImage.absoluteString forKey:KEY_combatAircraftAircraftImage];	[dictionary addValue:combatAircraftDescription forKey:KEY_combatAircraftDescription];
	[dictionary addValue:combatAircraftDetails forKey:KEY_combatAircraftDetails];
	[dictionary addValue:combatAircraftVideoURL forKey:KEY_combatAircraftVideoURL];

	return dictionary;
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_combatAircraftID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_combatAircraftLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_combatAircraftAircraftName];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_combatAircraftAircraftImage];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_combatAircraftDescription];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_combatAircraftDetails];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_combatAircraftVideoURL];
	
	return fieldsDic;
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	
	return foreignKeysDic;
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case CombatAircraft_None:
			fieldName = @"pos";
			break;
	
		case CombatAircraftID:
			fieldName = KEY_combatAircraftID;
			break;

		case CombatAircraftLastUpdate:
			fieldName = KEY_combatAircraftLastUpdate;
			break;

		case CombatAircraftAircraftName:
			fieldName = KEY_combatAircraftAircraftName;
			break;

		case CombatAircraftAircraftImage:
			fieldName = KEY_combatAircraftAircraftImage;
			break;

		case CombatAircraftDescription:
			fieldName = KEY_combatAircraftDescription;
			break;

		case CombatAircraftDetails:
			fieldName = KEY_combatAircraftDetails;
			break;

		case CombatAircraftVideoURL:
			fieldName = KEY_combatAircraftVideoURL;
			break;

		default:
			NSLog(@"Wrong LiFields numerator for %@ Class",kClassName);
			fieldName = nil;
			break;
	}
	
	return fieldName;
}

+ (NSString *) getGeoFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case CombatAircraft_None:
			fieldName = @"pos";
			break;
	
		default:
			NSLog(@"Wrong Geo LiFields numerator for %@ Class",kClassName);
			fieldName = nil;
			break;
	}
	
	return fieldName;
}


- (void) addValuesToRequest:(LiObjRequest **)request{
	[*request addValue:combatAircraftAircraftName forKey:KEY_combatAircraftAircraftName];
	[*request addValue:combatAircraftAircraftImage.absoluteString forKey:KEY_combatAircraftAircraftImage];
	[*request addValue:combatAircraftDescription forKey:KEY_combatAircraftDescription];
	[*request addValue:combatAircraftDetails forKey:KEY_combatAircraftDetails];
	[*request addValue:combatAircraftVideoURL forKey:KEY_combatAircraftVideoURL];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.combatAircraftID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftIDIndex])];
			combatAircraftLastUpdate = [[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftLastUpdateIndex])]];
			self.combatAircraftAircraftName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftAircraftNameIndex])];
			self.combatAircraftAircraftImage = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftAircraftImageIndex])]];
			self.combatAircraftDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftDescriptionIndex])];
			self.combatAircraftDetails = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftDetailsIndex])];
			self.combatAircraftVideoURL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CombatAircraftVideoURLIndex])];
		
		}
	return self;
}

+ (NSArray *) getArrayFromStatement:(sqlite3_stmt *)stmt IDsList:(NSArray *)idsList resultFromServer:(BOOL)resultFromServer{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	
	NSMutableArray *columnsArray = [[NSMutableArray alloc] init];
	int columns = sqlite3_column_count(stmt);
	for (int i=0; i<columns; i++) {
		char *columnName = (char *)sqlite3_column_name(stmt, i);
		[columnsArray addObject:[NSString stringWithUTF8String:columnName]];
	}
	
	int **indexes = (int **)malloc(1*sizeof(int *));
	indexes[0] = (int *)malloc(NUM_OF_COMBATAIRCRAFT_FIELDS*sizeof(int));

	indexes[0][CombatAircraftIDIndex] = [columnsArray indexOfObject:KEY_combatAircraftID];
	indexes[0][CombatAircraftLastUpdateIndex] = [columnsArray indexOfObject:KEY_combatAircraftLastUpdate];
	indexes[0][CombatAircraftAircraftNameIndex] = [columnsArray indexOfObject:KEY_combatAircraftAircraftName];
	indexes[0][CombatAircraftAircraftImageIndex] = [columnsArray indexOfObject:KEY_combatAircraftAircraftImage];
	indexes[0][CombatAircraftDescriptionIndex] = [columnsArray indexOfObject:KEY_combatAircraftDescription];
	indexes[0][CombatAircraftDetailsIndex] = [columnsArray indexOfObject:KEY_combatAircraftDetails];
	indexes[0][CombatAircraftVideoURLIndex] = [columnsArray indexOfObject:KEY_combatAircraftVideoURL];

	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][CombatAircraftIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			CombatAircraft *item  = [[CombatAircraft alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
			[result addObject:item];
		}
	}

	[LiObjRequest removeIDsList:blackList FromObject:kClassName];
	
	for (int i=0; i<1; i++) {
		free(indexes[i]);
	}
	free(indexes);
	
	return result;
}


#pragma mark - End of Basic SDK

@end
