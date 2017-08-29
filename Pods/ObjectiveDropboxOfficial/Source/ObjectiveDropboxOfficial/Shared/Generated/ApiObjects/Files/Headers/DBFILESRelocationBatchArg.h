///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESRelocationBatchArg;
@class DBFILESRelocationPath;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `RelocationBatchArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESRelocationBatchArg : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// List of entries to be moved or copied. Each entry is RelocationPath.
@property (nonatomic, readonly) NSArray<DBFILESRelocationPath *> *entries;

/// If true, `dCopyBatch` will copy contents in shared folder, otherwise
/// `cantCopySharedFolder` in `DBFILESRelocationError` will be returned if
/// `fromPath` in `DBFILESRelocationPath` contains shared folder.  This field is
/// always true for `moveBatch`.
@property (nonatomic, readonly) NSNumber *allowSharedFolder;

/// If there's a conflict with any file, have the Dropbox server try to
/// autorename that file to avoid the conflict.
@property (nonatomic, readonly) NSNumber *autorename;

/// Allow moves by owner even if it would result in an ownership transfer for
/// the content being moved. This does not apply to copies.
@property (nonatomic, readonly) NSNumber *allowOwnershipTransfer;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param entries List of entries to be moved or copied. Each entry is
/// RelocationPath.
/// @param allowSharedFolder If true, `dCopyBatch` will copy contents in shared
/// folder, otherwise `cantCopySharedFolder` in `DBFILESRelocationError` will be
/// returned if `fromPath` in `DBFILESRelocationPath` contains shared folder.
/// This field is always true for `moveBatch`.
/// @param autorename If there's a conflict with any file, have the Dropbox
/// server try to autorename that file to avoid the conflict.
/// @param allowOwnershipTransfer Allow moves by owner even if it would result
/// in an ownership transfer for the content being moved. This does not apply to
/// copies.
///
/// @return An initialized instance.
///
- (instancetype)initWithEntries:(NSArray<DBFILESRelocationPath *> *)entries
              allowSharedFolder:(nullable NSNumber *)allowSharedFolder
                     autorename:(nullable NSNumber *)autorename
         allowOwnershipTransfer:(nullable NSNumber *)allowOwnershipTransfer;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param entries List of entries to be moved or copied. Each entry is
/// RelocationPath.
///
/// @return An initialized instance.
///
- (instancetype)initWithEntries:(NSArray<DBFILESRelocationPath *> *)entries;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `RelocationBatchArg` struct.
///
@interface DBFILESRelocationBatchArgSerializer : NSObject

///
/// Serializes `DBFILESRelocationBatchArg` instances.
///
/// @param instance An instance of the `DBFILESRelocationBatchArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESRelocationBatchArg` API object.
///
+ (NSDictionary *)serialize:(DBFILESRelocationBatchArg *)instance;

///
/// Deserializes `DBFILESRelocationBatchArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESRelocationBatchArg` API object.
///
/// @return An instantiation of the `DBFILESRelocationBatchArg` object.
///
+ (DBFILESRelocationBatchArg *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
