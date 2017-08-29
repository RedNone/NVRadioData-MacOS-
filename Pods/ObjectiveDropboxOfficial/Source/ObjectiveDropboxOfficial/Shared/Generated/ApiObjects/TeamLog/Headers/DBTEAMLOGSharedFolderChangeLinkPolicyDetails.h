///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGSharedFolderChangeLinkPolicyDetails;
@class DBTEAMLOGSharedFolderLinkPolicy;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SharedFolderChangeLinkPolicyDetails` struct.
///
/// Changed who can access the shared folder via a link.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGSharedFolderChangeLinkPolicyDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Target asset index.
@property (nonatomic, readonly) NSNumber *targetIndex;

/// Original shared folder name.
@property (nonatomic, readonly, copy) NSString *originalFolderName;

/// Shared folder type. Might be missing due to historical data gap.
@property (nonatomic, readonly, copy, nullable) NSString *sharedFolderType;

/// New shared folder link policy.
@property (nonatomic, readonly) DBTEAMLOGSharedFolderLinkPolicy *dNewValue;

/// Previous shared folder link policy. Might be missing due to historical data
/// gap.
@property (nonatomic, readonly, nullable) DBTEAMLOGSharedFolderLinkPolicy *previousValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param targetIndex Target asset index.
/// @param originalFolderName Original shared folder name.
/// @param dNewValue New shared folder link policy.
/// @param sharedFolderType Shared folder type. Might be missing due to
/// historical data gap.
/// @param previousValue Previous shared folder link policy. Might be missing
/// due to historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithTargetIndex:(NSNumber *)targetIndex
                 originalFolderName:(NSString *)originalFolderName
                          dNewValue:(DBTEAMLOGSharedFolderLinkPolicy *)dNewValue
                   sharedFolderType:(nullable NSString *)sharedFolderType
                      previousValue:(nullable DBTEAMLOGSharedFolderLinkPolicy *)previousValue;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param targetIndex Target asset index.
/// @param originalFolderName Original shared folder name.
/// @param dNewValue New shared folder link policy.
///
/// @return An initialized instance.
///
- (instancetype)initWithTargetIndex:(NSNumber *)targetIndex
                 originalFolderName:(NSString *)originalFolderName
                          dNewValue:(DBTEAMLOGSharedFolderLinkPolicy *)dNewValue;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `SharedFolderChangeLinkPolicyDetails`
/// struct.
///
@interface DBTEAMLOGSharedFolderChangeLinkPolicyDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGSharedFolderChangeLinkPolicyDetails` instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGSharedFolderChangeLinkPolicyDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedFolderChangeLinkPolicyDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGSharedFolderChangeLinkPolicyDetails *)instance;

///
/// Deserializes `DBTEAMLOGSharedFolderChangeLinkPolicyDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedFolderChangeLinkPolicyDetails` API object.
///
/// @return An instantiation of the
/// `DBTEAMLOGSharedFolderChangeLinkPolicyDetails` object.
///
+ (DBTEAMLOGSharedFolderChangeLinkPolicyDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END