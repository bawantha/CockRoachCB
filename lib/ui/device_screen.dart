import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/device_bloc.dart';
import 'styles.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeviceBloc>().add(LoadDevices());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Connected Devices', style: textTheme.headlineSmall?.copyWith(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.go('/'),
        ),
      ),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state is DeviceLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            );
          } else if (state is DeviceLoaded) {
            final devices = state.devices;
            if (devices.isEmpty) {
              return Center(
                child: Text('No other devices connected.', style: textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppTheme.surfaceHighlight),
                  ),
                  color: AppTheme.surface,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.primary,
                      child: Icon(Icons.devices, color: Colors.white),
                    ),
                    title: Text(device.deviceName, style: textTheme.titleMedium?.copyWith(color: AppTheme.textPrimary)),
                    subtitle: Text(
                      'Last Active: ${_formatDate(device.lastActiveAt)}',
                      style: textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppTheme.error),
                      onPressed: () {
                        // We would call context.read<DeviceBloc>().add(RevokeDevice(device.deviceId));
                        // But wait, the bloc doesn't have it defined right now. Skip for now.
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
