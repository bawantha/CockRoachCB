import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clipboard_models.freezed.dart';
part 'clipboard_models.g.dart';

enum ClipboardContentType { text, html, image }

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    if (json == null) return null;
    return Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    if (object == null) return null;
    return object.toList();
  }
}

class NonNullUint8ListConverter implements JsonConverter<Uint8List, List<int>> {
  const NonNullUint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    return object.toList();
  }
}

@freezed
class ClipboardEntry with _$ClipboardEntry {
  const factory ClipboardEntry({
    required String id,
    required ClipboardContentType type,
    @Uint8ListConverter() Uint8List? content,
    required String deviceId,
    required DateTime timestamp,
  }) = _ClipboardEntry;

  factory ClipboardEntry.fromJson(Map<String, dynamic> json) =>
      _$ClipboardEntryFromJson(json);
}

@freezed
class ClipboardEntryMeta with _$ClipboardEntryMeta {
  const factory ClipboardEntryMeta({
    required String id,
    required ClipboardContentType type,
    required String preview,
    required String deviceId,
    required DateTime timestamp,
  }) = _ClipboardEntryMeta;

  factory ClipboardEntryMeta.fromJson(Map<String, dynamic> json) =>
      _$ClipboardEntryMetaFromJson(json);
}

@freezed
class EncryptedEntry with _$EncryptedEntry {
  const factory EncryptedEntry({
    required String id,
    required String userId,
    required String deviceId,
    required DateTime timestamp,
    @NonNullUint8ListConverter() required Uint8List iv,
    @NonNullUint8ListConverter() required Uint8List ciphertext,
    required ClipboardContentType type,
  }) = _EncryptedEntry;

  factory EncryptedEntry.fromJson(Map<String, dynamic> json) =>
      _$EncryptedEntryFromJson(json);
}

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String deviceId,
    required String platform,
    required String deviceName,
    required DateTime registeredAt,
    required DateTime lastActiveAt,
    required bool isRevoked,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

@freezed
class OfflineQueue with _$OfflineQueue {
  const OfflineQueue._();
  const factory OfflineQueue({
    @Default([]) List<ClipboardEntry> pending,
  }) = _OfflineQueue;

  factory OfflineQueue.fromJson(Map<String, dynamic> json) =>
      _$OfflineQueueFromJson(json);

  bool get isFull => pending.length >= 20;
}
