///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGRemoveSsoUrlDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `RemoveSsoUrlDetails` struct.
///
/// Changed the sign-out URL for SSO.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGRemoveSsoUrlDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Previous single sign-on logout URL.
@property (nonatomic, readonly, copy) NSString *previousValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param previousValue Previous single sign-on logout URL.
///
/// @return An initialized instance.
///
- (instancetype)initWithPreviousValue:(NSString *)previousValue;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `RemoveSsoUrlDetails` struct.
///
@interface DBTEAMLOGRemoveSsoUrlDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGRemoveSsoUrlDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGRemoveSsoUrlDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGRemoveSsoUrlDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGRemoveSsoUrlDetails *)instance;

///
/// Deserializes `DBTEAMLOGRemoveSsoUrlDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGRemoveSsoUrlDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGRemoveSsoUrlDetails` object.
///
+ (DBTEAMLOGRemoveSsoUrlDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
