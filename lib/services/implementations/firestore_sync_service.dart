import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/clipboard_models.dart';
import '../interfaces/sync_service.dart';
import '../interfaces/auth_service.dart';

class FirestoreSyncService implements SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;
  
  FirestoreSyncService(this._authService);

  CollectionReference get _entriesRef {
    final userId = _authService.currentUserId;
    if (userId == null) throw StateError("User not signed in");
    return _firestore.collection('users').doc(userId).collection('entries');
  }

  @override
  Future<void> upload(EncryptedEntry entry) async {
    await _entriesRef.doc(entry.id).set(entry.toJson());
  }

  @override
  Stream<EncryptedEntry> get incomingEntries {
    final userId = _authService.currentUserId;
    if (userId == null) return const Stream.empty();
    
    return _entriesRef
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          final newChanges = snapshot.docChanges
             .where((c) => c.type == DocumentChangeType.added);
          if (newChanges.isNotEmpty) {
            return EncryptedEntry.fromJson(newChanges.first.doc.data() as Map<String, dynamic>);
          }
          return null;
        })
        .where((entry) => entry != null)
        .cast<EncryptedEntry>();
  }

  @override
  Future<void> deleteEntry(String entryId) async {
    await _entriesRef.doc(entryId).delete();
  }

  @override
  void dispose() {}
}
