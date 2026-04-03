import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/history_bloc.dart';
import '../models/clipboard_models.dart';
import 'styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clipboard History', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.devices, color: AppTheme.textSecondary),
            tooltip: 'Devices',
            onPressed: () {
              context.go('/devices');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.error),
            tooltip: 'Logout / Lock',
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
          } else if (state is HistoryLoaded) {
            if (state.entries.isEmpty) {
              return _buildEmptyState();
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = state.entries[index];
                return _ClipboardCard(entry: entry);
              },
            );
          }
          return const Center(child: Text('Unknown State', style: TextStyle(color: AppTheme.textSecondary)));
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.content_paste_off, size: 64, color: AppTheme.surfaceHighlight),
          SizedBox(height: 16),
          Text(
            'No clipboard history yet',
            style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
          ),
          SizedBox(height: 8),
          Text(
            'Copy something to sync across devices!',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ClipboardCard extends StatelessWidget {
  final ClipboardEntryMeta entry;

  const _ClipboardCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (entry.type == 'image') {
      icon = Icons.image;
    } else if (entry.type == 'file') {
      icon = Icons.insert_drive_file;
    } else {
      icon = Icons.text_snippet;
    }

    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Copy back to clipboard
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceHighlight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.primaryLight, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.preview,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: AppTheme.textPrimary,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.devices, size: 12, color: AppTheme.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          entry.deviceId,
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                        ),
                        const Spacer(),
                        const Icon(Icons.access_time, size: 12, color: AppTheme.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(entry.timestamp),
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
