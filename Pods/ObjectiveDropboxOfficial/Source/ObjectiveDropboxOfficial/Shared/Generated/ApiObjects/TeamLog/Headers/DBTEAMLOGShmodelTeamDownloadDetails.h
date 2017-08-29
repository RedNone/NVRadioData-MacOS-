///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGShmodelTeamDownloadDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ShmodelTeamDownloadDetails` struct.
///
/// Downloaded a team member's file/folder from a link.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGShmodelTeamDownloadDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ShmodelTeamDownloadDetails` struct.
///
@interface DBTEAMLOGShmodelTeamDownloadDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGShmodelTeamDownloadDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGShmodelTeamDownloadDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGShmodelTeamDownloadDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGShmodelTeamDownloadDetails *)instance;

///
/// Deserializes `DBTEAMLOGShmodelTeamDownloadDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGShmodelTeamDownloadDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGShmodelTeamDownloadDetails`
/// object.
///
+ (DBTEAMLOGShmodelTeamDownloadDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
