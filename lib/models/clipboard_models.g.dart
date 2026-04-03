// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClipboardEntry _$ClipboardEntryFromJson(Map<String, dynamic> json) =>
    _ClipboardEntry(
      id: json['id'] as String,
      type: $enumDecode(_$ClipboardContentTypeEnumMap, json['type']),
      content: const Uint8ListConverter().fromJson(
        json['content'] as List<int>?,
      ),
      deviceId: json['deviceId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ClipboardEntryToJson(_ClipboardEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ClipboardContentTypeEnumMap[instance.type]!,
      'content': const Uint8ListConverter().toJson(instance.content),
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$ClipboardContentTypeEnumMap = {
  ClipboardContentType.text: 'text',
  ClipboardContentType.html: 'html',
  ClipboardContentType.image: 'image',
};

_ClipboardEntryMeta _$ClipboardEntryMetaFromJson(Map<String, dynamic> json) =>
    _ClipboardEntryMeta(
      id: json['id'] as String,
      type: $enumDecode(_$ClipboardContentTypeEnumMap, json['type']),
      preview: json['preview'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ClipboardEntryMetaToJson(_ClipboardEntryMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ClipboardContentTypeEnumMap[instance.type]!,
      'preview': instance.preview,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_EncryptedEntry _$EncryptedEntryFromJson(Map<String, dynamic> json) =>
    _EncryptedEntry(
      id: json['id'] as String,
      userId: json['userId'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      iv: const NonNullUint8ListConverter().fromJson(json['iv'] as List<int>),
      ciphertext: const NonNullUint8ListConverter().fromJson(
        json['ciphertext'] as List<int>,
      ),
      type: $enumDecode(_$ClipboardContentTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$EncryptedEntryToJson(
  _EncryptedEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'deviceId': instance.deviceId,
  'timestamp': instance.timestamp.toIso8601String(),
  'iv': const NonNullUint8ListConverter().toJson(instance.iv),
  'ciphertext': const NonNullUint8ListConverter().toJson(instance.ciphertext),
  'type': _$ClipboardContentTypeEnumMap[instance.type]!,
};

_DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => _DeviceInfo(
  deviceId: json['deviceId'] as String,
  platform: json['platform'] as String,
  deviceName: json['deviceName'] as String,
  registeredAt: DateTime.parse(json['registeredAt'] as String),
  lastActiveAt: DateTime.parse(json['lastActiveAt'] as String),
  isRevoked: json['isRevoked'] as bool,
);

Map<String, dynamic> _$DeviceInfoToJson(_DeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'platform': instance.platform,
      'deviceName': instance.deviceName,
      'registeredAt': instance.registeredAt.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt.toIso8601String(),
      'isRevoked': instance.isRevoked,
    };

_OfflineQueue _$OfflineQueueFromJson(Map<String, dynamic> json) =>
    _OfflineQueue(
      pending:
          (json['pending'] as List<dynamic>?)
              ?.map((e) => ClipboardEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OfflineQueueToJson(_OfflineQueue instance) =>
    <String, dynamic>{'pending': instance.pending};
