///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESGetCopyReferenceArg;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `GetCopyReferenceArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESGetCopyReferenceArg : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The path to the file or folder you want to get a copy reference to.
@property (nonatomic, readonly, copy) NSString *path;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param path The path to the file or folder you want to get a copy reference
/// to.
///
/// @return An initialized instance.
///
- (instancetype)initWithPath:(NSString *)path;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `GetCopyReferenceArg` struct.
///
@interface DBFILESGetCopyReferenceArgSerializer : NSObject

///
/// Serializes `DBFILESGetCopyReferenceArg` instances.
///
/// @param instance An instance of the `DBFILESGetCopyReferenceArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESGetCopyReferenceArg` API object.
///
+ (NSDictionary *)serialize:(DBFILESGetCopyReferenceArg *)instance;

///
/// Deserializes `DBFILESGetCopyReferenceArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESGetCopyReferenceArg` API object.
///
/// @return An instantiation of the `DBFILESGetCopyReferenceArg` object.
///
+ (DBFILESGetCopyReferenceArg *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
