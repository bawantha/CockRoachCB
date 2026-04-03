import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/clipboard_models.dart';
import '../interfaces/history_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/auth_service.dart';
import '../../utils/app_logger.dart';

class AppHistoryService implements HistoryService {
  final SharedPreferences _prefs;
  final AuthService _authService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _historyKey = 'clipboard_history';
  
  List<ClipboardEntryMeta> _history = [];
  
  AppHistoryService(this._prefs, this._authService) {
    appLogger.d('Initializing AppHistoryService...');
    _loadFromLocal();
  }

  void _loadFromLocal() {
    final historyJsonStr = _prefs.getString(_historyKey);
    if (historyJsonStr != null) {
      final List<dynamic> decoded = jsonDecode(historyJsonStr);
      _history = decoded.map((e) => ClipboardEntryMeta.fromJson(e as Map<String, dynamic>)).toList();
      appLogger.i('Loaded ${_history.length} history entries from local storage.');
    } else {
      appLogger.d('No local history found.');
    }
  }

  Future<void> _saveToLocal() async {
    final historyJson = _history.map((e) => e.toJson()).toList();
    await _prefs.setString(_historyKey, jsonEncode(historyJson));
  }

  @override
  List<ClipboardEntryMeta> get history => List.unmodifiable(_history);

  @override
  Future<ClipboardEntry> fetchFullContent(String entryId) async {
    final userId = _authService.currentUserId;
    if (userId == null) throw StateError("Not signed in");
    
    // We would fetch the EncryptedEntry, decrypt it, and return.
    // Assuming decryption happens at the caller level or within a combined history fetcher.
    throw UnimplementedError("fetchFullContent needs EncryptionService access");
  }

  @override
  Future<void> addEntry(ClipboardEntryMeta meta) async {
    appLogger.d('Adding new history entry: ${meta.id}');
    // Avoid duplicates
    _history.removeWhere((e) => e.id == meta.id);
    _history.insert(0, meta);
    if (_history.length > 50) {
      _history = _history.sublist(0, 50);
    }
    await _saveToLocal();
    appLogger.v('History updated and saved locally.');
  }

  @override
  Future<void> deleteEntry(String entryId) async {
    appLogger.w('Deleting local history entry: $entryId');
    _history.removeWhere((h) => h.id == entryId);
    await _saveToLocal();
  }

  @override
  Future<void> restoreFromRemote() async {
    // Would fetch top 50 from Firestore if local is empty or user requests sync
  }
}
