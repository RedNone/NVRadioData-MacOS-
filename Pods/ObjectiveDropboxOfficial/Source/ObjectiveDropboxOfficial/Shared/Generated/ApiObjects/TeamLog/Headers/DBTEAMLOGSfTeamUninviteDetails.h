///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGSfTeamUninviteDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SfTeamUninviteDetails` struct.
///
/// Unshared a folder with a team member.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGSfTeamUninviteDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Target asset index.
@property (nonatomic, readonly) NSNumber *targetIndex;

/// Original shared folder name.
@property (nonatomic, readonly, copy) NSString *originalFolderName;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param targetIndex Target asset index.
/// @param originalFolderName Original shared folder name.
///
/// @return An initialized instance.
///
- (instancetype)initWithTargetIndex:(NSNumber *)targetIndex originalFolderName:(NSString *)originalFolderName;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `SfTeamUninviteDetails` struct.
///
@interface DBTEAMLOGSfTeamUninviteDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGSfTeamUninviteDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGSfTeamUninviteDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGSfTeamUninviteDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGSfTeamUninviteDetails *)instance;

///
/// Deserializes `DBTEAMLOGSfTeamUninviteDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGSfTeamUninviteDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGSfTeamUninviteDetails` object.
///
+ (DBTEAMLOGSfTeamUninviteDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
