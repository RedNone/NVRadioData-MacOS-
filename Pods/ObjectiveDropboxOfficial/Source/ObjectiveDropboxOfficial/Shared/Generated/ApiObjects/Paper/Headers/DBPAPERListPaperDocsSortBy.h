///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBPAPERListPaperDocsSortBy;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ListPaperDocsSortBy` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBPAPERListPaperDocsSortBy : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBPAPERListPaperDocsSortByTag` enum type represents the possible tag
/// states with which the `DBPAPERListPaperDocsSortBy` union can exist.
typedef NS_ENUM(NSInteger, DBPAPERListPaperDocsSortByTag) {
  /// Sorts the Paper docs by the time they were last accessed.
  DBPAPERListPaperDocsSortByAccessed,

  /// Sorts the Paper docs by the time they were last modified.
  DBPAPERListPaperDocsSortByModified,

  /// Sorts the Paper docs by the creation time.
  DBPAPERListPaperDocsSortByCreated,

  /// (no description).
  DBPAPERListPaperDocsSortByOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBPAPERListPaperDocsSortByTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "accessed".
///
/// Description of the "accessed" tag state: Sorts the Paper docs by the time
/// they were last accessed.
///
/// @return An initialized instance.
///
- (instancetype)initWithAccessed;

///
/// Initializes union class with tag state of "modified".
///
/// Description of the "modified" tag state: Sorts the Paper docs by the time
/// they were last modified.
///
/// @return An initialized instance.
///
- (instancetype)initWithModified;

///
/// Initializes union class with tag state of "created".
///
/// Description of the "created" tag state: Sorts the Paper docs by the creation
/// time.
///
/// @return An initialized instance.
///
- (instancetype)initWithCreated;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "accessed".
///
/// @return Whether the union's current tag state has value "accessed".
///
- (BOOL)isAccessed;

///
/// Retrieves whether the union's current tag state has value "modified".
///
/// @return Whether the union's current tag state has value "modified".
///
- (BOOL)isModified;

///
/// Retrieves whether the union's current tag state has value "created".
///
/// @return Whether the union's current tag state has value "created".
///
- (BOOL)isCreated;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBPAPERListPaperDocsSortBy` union.
///
@interface DBPAPERListPaperDocsSortBySerializer : NSObject

///
/// Serializes `DBPAPERListPaperDocsSortBy` instances.
///
/// @param instance An instance of the `DBPAPERListPaperDocsSortBy` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBPAPERListPaperDocsSortBy` API object.
///
+ (NSDictionary *)serialize:(DBPAPERListPaperDocsSortBy *)instance;

///
/// Deserializes `DBPAPERListPaperDocsSortBy` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBPAPERListPaperDocsSortBy` API object.
///
/// @return An instantiation of the `DBPAPERListPaperDocsSortBy` object.
///
+ (DBPAPERListPaperDocsSortBy *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
