// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: struct.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(AIYOU_G_P_B_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define AIYOU_G_P_B_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if AIYOU_G_P_B_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/AIYOU_G_P_BProtocolBuffers.h>
#else
 #import "AIYOU_G_P_BProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class AIYOU_G_P_BListValue;
@class AIYOU_G_P_BStruct;
@class AIYOU_G_P_BValue;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum AIYOU_G_P_BNullValue

/**
 * `NullValue` is a singleton enumeration to represent the null value for the
 * `Value` type union.
 *
 *  The JSON representation for `NullValue` is JSON `null`.
 **/
typedef AIYOU_G_P_B_ENUM(AIYOU_G_P_BNullValue) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  AIYOU_G_P_BNullValue_AIYOU_G_P_BUnrecognizedEnumeratorValue = kAIYOU_G_P_BUnrecognizedEnumeratorValue,
  /** Null value. */
  AIYOU_G_P_BNullValue_NullValue = 0,
};

AIYOU_G_P_BEnumDescriptor *AIYOU_G_P_BNullValue_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL AIYOU_G_P_BNullValue_IsValidValue(int32_t value);

#pragma mark - AIYOU_G_P_BStructRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (AIYOU_G_P_BExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c AIYOU_G_P_BExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface AIYOU_G_P_BStructRoot : AIYOU_G_P_BRootObject
@end

#pragma mark - AIYOU_G_P_BStruct

typedef AIYOU_G_P_B_ENUM(AIYOU_G_P_BStruct_FieldNumber) {
  AIYOU_G_P_BStruct_FieldNumber_Fields = 1,
};

/**
 * `Struct` represents a structured data value, consisting of fields
 * which map to dynamically typed values. In some languages, `Struct`
 * might be supported by a native representation. For example, in
 * scripting languages like JS a struct is represented as an
 * object. The details of that representation are described together
 * with the proto support for the language.
 *
 * The JSON representation for `Struct` is JSON object.
 **/
@interface AIYOU_G_P_BStruct : AIYOU_G_P_BMessage

/** Unordered map of dynamically typed values. */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, AIYOU_G_P_BValue*> *fields;
/** The number of items in @c fields without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger fields_Count;

@end

#pragma mark - AIYOU_G_P_BValue

typedef AIYOU_G_P_B_ENUM(AIYOU_G_P_BValue_FieldNumber) {
  AIYOU_G_P_BValue_FieldNumber_NullValue = 1,
  AIYOU_G_P_BValue_FieldNumber_NumberValue = 2,
  AIYOU_G_P_BValue_FieldNumber_StringValue = 3,
  AIYOU_G_P_BValue_FieldNumber_BoolValue = 4,
  AIYOU_G_P_BValue_FieldNumber_StructValue = 5,
  AIYOU_G_P_BValue_FieldNumber_ListValue = 6,
};

typedef AIYOU_G_P_B_ENUM(AIYOU_G_P_BValue_Kind_OneOfCase) {
  AIYOU_G_P_BValue_Kind_OneOfCase_AIYOU_G_P_BUnsetOneOfCase = 0,
  AIYOU_G_P_BValue_Kind_OneOfCase_NullValue = 1,
  AIYOU_G_P_BValue_Kind_OneOfCase_NumberValue = 2,
  AIYOU_G_P_BValue_Kind_OneOfCase_StringValue = 3,
  AIYOU_G_P_BValue_Kind_OneOfCase_BoolValue = 4,
  AIYOU_G_P_BValue_Kind_OneOfCase_StructValue = 5,
  AIYOU_G_P_BValue_Kind_OneOfCase_ListValue = 6,
};

/**
 * `Value` represents a dynamically typed value which can be either
 * null, a number, a string, a boolean, a recursive struct value, or a
 * list of values. A producer of value is expected to set one of that
 * variants, absence of any variant indicates an error.
 *
 * The JSON representation for `Value` is JSON value.
 **/
@interface AIYOU_G_P_BValue : AIYOU_G_P_BMessage

/** The kind of value. */
@property(nonatomic, readonly) AIYOU_G_P_BValue_Kind_OneOfCase kindOneOfCase;

/** Represents a null value. */
@property(nonatomic, readwrite) AIYOU_G_P_BNullValue nullValue;

/** Represents a double value. */
@property(nonatomic, readwrite) double numberValue;

/** Represents a string value. */
@property(nonatomic, readwrite, copy, null_resettable) NSString *stringValue;

/** Represents a boolean value. */
@property(nonatomic, readwrite) BOOL boolValue;

/** Represents a structured value. */
@property(nonatomic, readwrite, strong, null_resettable) AIYOU_G_P_BStruct *structValue;

/** Represents a repeated `Value`. */
@property(nonatomic, readwrite, strong, null_resettable) AIYOU_G_P_BListValue *listValue;

@end

/**
 * Fetches the raw value of a @c AIYOU_G_P_BValue's @c nullValue property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t AIYOU_G_P_BValue_NullValue_RawValue(AIYOU_G_P_BValue *message);
/**
 * Sets the raw value of an @c AIYOU_G_P_BValue's @c nullValue property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetAIYOU_G_P_BValue_NullValue_RawValue(AIYOU_G_P_BValue *message, int32_t value);

/**
 * Clears whatever value was set for the oneof 'kind'.
 **/
void AIYOU_G_P_BValue_ClearKindOneOfCase(AIYOU_G_P_BValue *message);

#pragma mark - AIYOU_G_P_BListValue

typedef AIYOU_G_P_B_ENUM(AIYOU_G_P_BListValue_FieldNumber) {
  AIYOU_G_P_BListValue_FieldNumber_ValuesArray = 1,
};

/**
 * `ListValue` is a wrapper around a repeated field of values.
 *
 * The JSON representation for `ListValue` is JSON array.
 **/
@interface AIYOU_G_P_BListValue : AIYOU_G_P_BMessage

/** Repeated field of dynamically typed values. */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<AIYOU_G_P_BValue*> *valuesArray;
/** The number of items in @c valuesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger valuesArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)