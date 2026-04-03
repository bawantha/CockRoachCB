// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clipboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClipboardEntry {

 String get id; ClipboardContentType get type;@Uint8ListConverter() Uint8List? get content; String get deviceId; DateTime get timestamp;
/// Create a copy of ClipboardEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClipboardEntryCopyWith<ClipboardEntry> get copyWith => _$ClipboardEntryCopyWithImpl<ClipboardEntry>(this as ClipboardEntry, _$identity);

  /// Serializes this ClipboardEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClipboardEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(content),deviceId,timestamp);

@override
String toString() {
  return 'ClipboardEntry(id: $id, type: $type, content: $content, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ClipboardEntryCopyWith<$Res>  {
  factory $ClipboardEntryCopyWith(ClipboardEntry value, $Res Function(ClipboardEntry) _then) = _$ClipboardEntryCopyWithImpl;
@useResult
$Res call({
 String id, ClipboardContentType type,@Uint8ListConverter() Uint8List? content, String deviceId, DateTime timestamp
});




}
/// @nodoc
class _$ClipboardEntryCopyWithImpl<$Res>
    implements $ClipboardEntryCopyWith<$Res> {
  _$ClipboardEntryCopyWithImpl(this._self, this._then);

  final ClipboardEntry _self;
  final $Res Function(ClipboardEntry) _then;

/// Create a copy of ClipboardEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? content = freezed,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ClipboardContentType,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Uint8List?,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ClipboardEntry].
extension ClipboardEntryPatterns on ClipboardEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClipboardEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClipboardEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClipboardEntry value)  $default,){
final _that = this;
switch (_that) {
case _ClipboardEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClipboardEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ClipboardEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ClipboardContentType type, @Uint8ListConverter()  Uint8List? content,  String deviceId,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClipboardEntry() when $default != null:
return $default(_that.id,_that.type,_that.content,_that.deviceId,_that.timestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ClipboardContentType type, @Uint8ListConverter()  Uint8List? content,  String deviceId,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ClipboardEntry():
return $default(_that.id,_that.type,_that.content,_that.deviceId,_that.timestamp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ClipboardContentType type, @Uint8ListConverter()  Uint8List? content,  String deviceId,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ClipboardEntry() when $default != null:
return $default(_that.id,_that.type,_that.content,_that.deviceId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClipboardEntry implements ClipboardEntry {
  const _ClipboardEntry({required this.id, required this.type, @Uint8ListConverter() this.content, required this.deviceId, required this.timestamp});
  factory _ClipboardEntry.fromJson(Map<String, dynamic> json) => _$ClipboardEntryFromJson(json);

@override final  String id;
@override final  ClipboardContentType type;
@override@Uint8ListConverter() final  Uint8List? content;
@override final  String deviceId;
@override final  DateTime timestamp;

/// Create a copy of ClipboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClipboardEntryCopyWith<_ClipboardEntry> get copyWith => __$ClipboardEntryCopyWithImpl<_ClipboardEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClipboardEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClipboardEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(content),deviceId,timestamp);

@override
String toString() {
  return 'ClipboardEntry(id: $id, type: $type, content: $content, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ClipboardEntryCopyWith<$Res> implements $ClipboardEntryCopyWith<$Res> {
  factory _$ClipboardEntryCopyWith(_ClipboardEntry value, $Res Function(_ClipboardEntry) _then) = __$ClipboardEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, ClipboardContentType type,@Uint8ListConverter() Uint8List? content, String deviceId, DateTime timestamp
});




}
/// @nodoc
class __$ClipboardEntryCopyWithImpl<$Res>
    implements _$ClipboardEntryCopyWith<$Res> {
  __$ClipboardEntryCopyWithImpl(this._self, this._then);

  final _ClipboardEntry _self;
  final $Res Function(_ClipboardEntry) _then;

/// Create a copy of ClipboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? content = freezed,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_ClipboardEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ClipboardContentType,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Uint8List?,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ClipboardEntryMeta {

 String get id; ClipboardContentType get type; String get preview; String get deviceId; DateTime get timestamp;
/// Create a copy of ClipboardEntryMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClipboardEntryMetaCopyWith<ClipboardEntryMeta> get copyWith => _$ClipboardEntryMetaCopyWithImpl<ClipboardEntryMeta>(this as ClipboardEntryMeta, _$identity);

  /// Serializes this ClipboardEntryMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClipboardEntryMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,preview,deviceId,timestamp);

@override
String toString() {
  return 'ClipboardEntryMeta(id: $id, type: $type, preview: $preview, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ClipboardEntryMetaCopyWith<$Res>  {
  factory $ClipboardEntryMetaCopyWith(ClipboardEntryMeta value, $Res Function(ClipboardEntryMeta) _then) = _$ClipboardEntryMetaCopyWithImpl;
@useResult
$Res call({
 String id, ClipboardContentType type, String preview, String deviceId, DateTime timestamp
});




}
/// @nodoc
class _$ClipboardEntryMetaCopyWithImpl<$Res>
    implements $ClipboardEntryMetaCopyWith<$Res> {
  _$ClipboardEntryMetaCopyWithImpl(this._self, this._then);

  final ClipboardEntryMeta _self;
  final $Res Function(ClipboardEntryMeta) _then;

/// Create a copy of ClipboardEntryMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? preview = null,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ClipboardContentType,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ClipboardEntryMeta].
extension ClipboardEntryMetaPatterns on ClipboardEntryMeta {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClipboardEntryMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClipboardEntryMeta() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClipboardEntryMeta value)  $default,){
final _that = this;
switch (_that) {
case _ClipboardEntryMeta():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClipboardEntryMeta value)?  $default,){
final _that = this;
switch (_that) {
case _ClipboardEntryMeta() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ClipboardContentType type,  String preview,  String deviceId,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClipboardEntryMeta() when $default != null:
return $default(_that.id,_that.type,_that.preview,_that.deviceId,_that.timestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ClipboardContentType type,  String preview,  String deviceId,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ClipboardEntryMeta():
return $default(_that.id,_that.type,_that.preview,_that.deviceId,_that.timestamp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ClipboardContentType type,  String preview,  String deviceId,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ClipboardEntryMeta() when $default != null:
return $default(_that.id,_that.type,_that.preview,_that.deviceId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClipboardEntryMeta implements ClipboardEntryMeta {
  const _ClipboardEntryMeta({required this.id, required this.type, required this.preview, required this.deviceId, required this.timestamp});
  factory _ClipboardEntryMeta.fromJson(Map<String, dynamic> json) => _$ClipboardEntryMetaFromJson(json);

@override final  String id;
@override final  ClipboardContentType type;
@override final  String preview;
@override final  String deviceId;
@override final  DateTime timestamp;

/// Create a copy of ClipboardEntryMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClipboardEntryMetaCopyWith<_ClipboardEntryMeta> get copyWith => __$ClipboardEntryMetaCopyWithImpl<_ClipboardEntryMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClipboardEntryMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClipboardEntryMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,preview,deviceId,timestamp);

@override
String toString() {
  return 'ClipboardEntryMeta(id: $id, type: $type, preview: $preview, deviceId: $deviceId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ClipboardEntryMetaCopyWith<$Res> implements $ClipboardEntryMetaCopyWith<$Res> {
  factory _$ClipboardEntryMetaCopyWith(_ClipboardEntryMeta value, $Res Function(_ClipboardEntryMeta) _then) = __$ClipboardEntryMetaCopyWithImpl;
@override @useResult
$Res call({
 String id, ClipboardContentType type, String preview, String deviceId, DateTime timestamp
});




}
/// @nodoc
class __$ClipboardEntryMetaCopyWithImpl<$Res>
    implements _$ClipboardEntryMetaCopyWith<$Res> {
  __$ClipboardEntryMetaCopyWithImpl(this._self, this._then);

  final _ClipboardEntryMeta _self;
  final $Res Function(_ClipboardEntryMeta) _then;

/// Create a copy of ClipboardEntryMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? preview = null,Object? deviceId = null,Object? timestamp = null,}) {
  return _then(_ClipboardEntryMeta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ClipboardContentType,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$EncryptedEntry {

 String get id; String get userId; String get deviceId; DateTime get timestamp;@NonNullUint8ListConverter() Uint8List get iv;@NonNullUint8ListConverter() Uint8List get ciphertext; ClipboardContentType get type;
/// Create a copy of EncryptedEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptedEntryCopyWith<EncryptedEntry> get copyWith => _$EncryptedEntryCopyWithImpl<EncryptedEntry>(this as EncryptedEntry, _$identity);

  /// Serializes this EncryptedEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptedEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.iv, iv)&&const DeepCollectionEquality().equals(other.ciphertext, ciphertext)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,deviceId,timestamp,const DeepCollectionEquality().hash(iv),const DeepCollectionEquality().hash(ciphertext),type);

@override
String toString() {
  return 'EncryptedEntry(id: $id, userId: $userId, deviceId: $deviceId, timestamp: $timestamp, iv: $iv, ciphertext: $ciphertext, type: $type)';
}


}

/// @nodoc
abstract mixin class $EncryptedEntryCopyWith<$Res>  {
  factory $EncryptedEntryCopyWith(EncryptedEntry value, $Res Function(EncryptedEntry) _then) = _$EncryptedEntryCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String deviceId, DateTime timestamp,@NonNullUint8ListConverter() Uint8List iv,@NonNullUint8ListConverter() Uint8List ciphertext, ClipboardContentType type
});




}
/// @nodoc
class _$EncryptedEntryCopyWithImpl<$Res>
    implements $EncryptedEntryCopyWith<$Res> {
  _$EncryptedEntryCopyWithImpl(this._self, this._then);

  final EncryptedEntry _self;
  final $Res Function(EncryptedEntry) _then;

/// Create a copy of EncryptedEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? deviceId = null,Object? timestamp = null,Object? iv = null,Object? ciphertext = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,iv: null == iv ? _self.iv : iv // ignore: cast_nullable_to_non_nullable
as Uint8List,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as Uint8List,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ClipboardContentType,
  ));
}

}


/// Adds pattern-matching-related methods to [EncryptedEntry].
extension EncryptedEntryPatterns on EncryptedEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EncryptedEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EncryptedEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EncryptedEntry value)  $default,){
final _that = this;
switch (_that) {
case _EncryptedEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EncryptedEntry value)?  $default,){
final _that = this;
switch (_that) {
case _EncryptedEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String deviceId,  DateTime timestamp, @NonNullUint8ListConverter()  Uint8List iv, @NonNullUint8ListConverter()  Uint8List ciphertext,  ClipboardContentType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EncryptedEntry() when $default != null:
return $default(_that.id,_that.userId,_that.deviceId,_that.timestamp,_that.iv,_that.ciphertext,_that.type);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String deviceId,  DateTime timestamp, @NonNullUint8ListConverter()  Uint8List iv, @NonNullUint8ListConverter()  Uint8List ciphertext,  ClipboardContentType type)  $default,) {final _that = this;
switch (_that) {
case _EncryptedEntry():
return $default(_that.id,_that.userId,_that.deviceId,_that.timestamp,_that.iv,_that.ciphertext,_that.type);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String deviceId,  DateTime timestamp, @NonNullUint8ListConverter()  Uint8List iv, @NonNullUint8ListConverter()  Uint8List ciphertext,  ClipboardContentType type)?  $default,) {final _that = this;
switch (_that) {
case _EncryptedEntry() when $default != null:
return $default(_that.id,_that.userId,_that.deviceId,_that.timestamp,_that.iv,_that.ciphertext,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EncryptedEntry implements EncryptedEntry {
  const _EncryptedEntry({required this.id, required this.userId, required this.deviceId, required this.timestamp, @NonNullUint8ListConverter() required this.iv, @NonNullUint8ListConverter() required this.ciphertext, required this.type});
  factory _EncryptedEntry.fromJson(Map<String, dynamic> json) => _$EncryptedEntryFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String deviceId;
@override final  DateTime timestamp;
@override@NonNullUint8ListConverter() final  Uint8List iv;
@override@NonNullUint8ListConverter() final  Uint8List ciphertext;
@override final  ClipboardContentType type;

/// Create a copy of EncryptedEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncryptedEntryCopyWith<_EncryptedEntry> get copyWith => __$EncryptedEntryCopyWithImpl<_EncryptedEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncryptedEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EncryptedEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.iv, iv)&&const DeepCollectionEquality().equals(other.ciphertext, ciphertext)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,deviceId,timestamp,const DeepCollectionEquality().hash(iv),const DeepCollectionEquality().hash(ciphertext),type);

@override
String toString() {
  return 'EncryptedEntry(id: $id, userId: $userId, deviceId: $deviceId, timestamp: $timestamp, iv: $iv, ciphertext: $ciphertext, type: $type)';
}


}

/// @nodoc
abstract mixin class _$EncryptedEntryCopyWith<$Res> implements $EncryptedEntryCopyWith<$Res> {
  factory _$EncryptedEntryCopyWith(_EncryptedEntry value, $Res Function(_EncryptedEntry) _then) = __$EncryptedEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String deviceId, DateTime timestamp,@NonNullUint8ListConverter() Uint8List iv,@NonNullUint8ListConverter() Uint8List ciphertext, ClipboardContentType type
});




}
/// @nodoc
class __$EncryptedEntryCopyWithImpl<$Res>
    implements _$EncryptedEntryCopyWith<$Res> {
  __$EncryptedEntryCopyWithImpl(this._self, this._then);

  final _EncryptedEntry _self;
  final $Res Function(_EncryptedEntry) _then;

/// Create a copy of EncryptedEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? deviceId = null,Object? timestamp = null,Object? iv = null,Object? ciphertext = null,Object? type = null,}) {
  return _then(_EncryptedEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,iv: null == iv ? _self.iv : iv // ignore: cast_nullable_to_non_nullable
as Uint8List,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as Uint8List,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ClipboardContentType,
  ));
}


}


/// @nodoc
mixin _$DeviceInfo {

 String get deviceId; String get platform; String get deviceName; DateTime get registeredAt; DateTime get lastActiveAt; bool get isRevoked;
/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<DeviceInfo> get copyWith => _$DeviceInfoCopyWithImpl<DeviceInfo>(this as DeviceInfo, _$identity);

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceInfo&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,platform,deviceName,registeredAt,lastActiveAt,isRevoked);

@override
String toString() {
  return 'DeviceInfo(deviceId: $deviceId, platform: $platform, deviceName: $deviceName, registeredAt: $registeredAt, lastActiveAt: $lastActiveAt, isRevoked: $isRevoked)';
}


}

/// @nodoc
abstract mixin class $DeviceInfoCopyWith<$Res>  {
  factory $DeviceInfoCopyWith(DeviceInfo value, $Res Function(DeviceInfo) _then) = _$DeviceInfoCopyWithImpl;
@useResult
$Res call({
 String deviceId, String platform, String deviceName, DateTime registeredAt, DateTime lastActiveAt, bool isRevoked
});




}
/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._self, this._then);

  final DeviceInfo _self;
  final $Res Function(DeviceInfo) _then;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? platform = null,Object? deviceName = null,Object? registeredAt = null,Object? lastActiveAt = null,Object? isRevoked = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastActiveAt: null == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceInfo].
extension DeviceInfoPatterns on DeviceInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceInfo value)  $default,){
final _that = this;
switch (_that) {
case _DeviceInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String platform,  String deviceName,  DateTime registeredAt,  DateTime lastActiveAt,  bool isRevoked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that.deviceId,_that.platform,_that.deviceName,_that.registeredAt,_that.lastActiveAt,_that.isRevoked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String platform,  String deviceName,  DateTime registeredAt,  DateTime lastActiveAt,  bool isRevoked)  $default,) {final _that = this;
switch (_that) {
case _DeviceInfo():
return $default(_that.deviceId,_that.platform,_that.deviceName,_that.registeredAt,_that.lastActiveAt,_that.isRevoked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String platform,  String deviceName,  DateTime registeredAt,  DateTime lastActiveAt,  bool isRevoked)?  $default,) {final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that.deviceId,_that.platform,_that.deviceName,_that.registeredAt,_that.lastActiveAt,_that.isRevoked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceInfo implements DeviceInfo {
  const _DeviceInfo({required this.deviceId, required this.platform, required this.deviceName, required this.registeredAt, required this.lastActiveAt, required this.isRevoked});
  factory _DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);

@override final  String deviceId;
@override final  String platform;
@override final  String deviceName;
@override final  DateTime registeredAt;
@override final  DateTime lastActiveAt;
@override final  bool isRevoked;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceInfoCopyWith<_DeviceInfo> get copyWith => __$DeviceInfoCopyWithImpl<_DeviceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceInfo&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,platform,deviceName,registeredAt,lastActiveAt,isRevoked);

@override
String toString() {
  return 'DeviceInfo(deviceId: $deviceId, platform: $platform, deviceName: $deviceName, registeredAt: $registeredAt, lastActiveAt: $lastActiveAt, isRevoked: $isRevoked)';
}


}

/// @nodoc
abstract mixin class _$DeviceInfoCopyWith<$Res> implements $DeviceInfoCopyWith<$Res> {
  factory _$DeviceInfoCopyWith(_DeviceInfo value, $Res Function(_DeviceInfo) _then) = __$DeviceInfoCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String platform, String deviceName, DateTime registeredAt, DateTime lastActiveAt, bool isRevoked
});




}
/// @nodoc
class __$DeviceInfoCopyWithImpl<$Res>
    implements _$DeviceInfoCopyWith<$Res> {
  __$DeviceInfoCopyWithImpl(this._self, this._then);

  final _DeviceInfo _self;
  final $Res Function(_DeviceInfo) _then;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? platform = null,Object? deviceName = null,Object? registeredAt = null,Object? lastActiveAt = null,Object? isRevoked = null,}) {
  return _then(_DeviceInfo(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastActiveAt: null == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OfflineQueue {

 List<ClipboardEntry> get pending;
/// Create a copy of OfflineQueue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineQueueCopyWith<OfflineQueue> get copyWith => _$OfflineQueueCopyWithImpl<OfflineQueue>(this as OfflineQueue, _$identity);

  /// Serializes this OfflineQueue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineQueue&&const DeepCollectionEquality().equals(other.pending, pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pending));

@override
String toString() {
  return 'OfflineQueue(pending: $pending)';
}


}

/// @nodoc
abstract mixin class $OfflineQueueCopyWith<$Res>  {
  factory $OfflineQueueCopyWith(OfflineQueue value, $Res Function(OfflineQueue) _then) = _$OfflineQueueCopyWithImpl;
@useResult
$Res call({
 List<ClipboardEntry> pending
});




}
/// @nodoc
class _$OfflineQueueCopyWithImpl<$Res>
    implements $OfflineQueueCopyWith<$Res> {
  _$OfflineQueueCopyWithImpl(this._self, this._then);

  final OfflineQueue _self;
  final $Res Function(OfflineQueue) _then;

/// Create a copy of OfflineQueue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pending = null,}) {
  return _then(_self.copyWith(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as List<ClipboardEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [OfflineQueue].
extension OfflineQueuePatterns on OfflineQueue {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfflineQueue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfflineQueue() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfflineQueue value)  $default,){
final _that = this;
switch (_that) {
case _OfflineQueue():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfflineQueue value)?  $default,){
final _that = this;
switch (_that) {
case _OfflineQueue() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ClipboardEntry> pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfflineQueue() when $default != null:
return $default(_that.pending);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ClipboardEntry> pending)  $default,) {final _that = this;
switch (_that) {
case _OfflineQueue():
return $default(_that.pending);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ClipboardEntry> pending)?  $default,) {final _that = this;
switch (_that) {
case _OfflineQueue() when $default != null:
return $default(_that.pending);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfflineQueue extends OfflineQueue {
  const _OfflineQueue({final  List<ClipboardEntry> pending = const []}): _pending = pending,super._();
  factory _OfflineQueue.fromJson(Map<String, dynamic> json) => _$OfflineQueueFromJson(json);

 final  List<ClipboardEntry> _pending;
@override@JsonKey() List<ClipboardEntry> get pending {
  if (_pending is EqualUnmodifiableListView) return _pending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pending);
}


/// Create a copy of OfflineQueue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineQueueCopyWith<_OfflineQueue> get copyWith => __$OfflineQueueCopyWithImpl<_OfflineQueue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflineQueueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineQueue&&const DeepCollectionEquality().equals(other._pending, _pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pending));

@override
String toString() {
  return 'OfflineQueue(pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$OfflineQueueCopyWith<$Res> implements $OfflineQueueCopyWith<$Res> {
  factory _$OfflineQueueCopyWith(_OfflineQueue value, $Res Function(_OfflineQueue) _then) = __$OfflineQueueCopyWithImpl;
@override @useResult
$Res call({
 List<ClipboardEntry> pending
});




}
/// @nodoc
class __$OfflineQueueCopyWithImpl<$Res>
    implements _$OfflineQueueCopyWith<$Res> {
  __$OfflineQueueCopyWithImpl(this._self, this._then);

  final _OfflineQueue _self;
  final $Res Function(_OfflineQueue) _then;

/// Create a copy of OfflineQueue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pending = null,}) {
  return _then(_OfflineQueue(
pending: null == pending ? _self._pending : pending // ignore: cast_nullable_to_non_nullable
as List<ClipboardEntry>,
  ));
}


}

// dart format on
