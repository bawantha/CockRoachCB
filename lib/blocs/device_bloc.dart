import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/clipboard_models.dart';
import '../services/interfaces/device_manager.dart';
import 'dart:async';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();
  @override
  List<Object> get props => [];
}

class LoadDevices extends DeviceEvent {}
class DevicesUpdated extends DeviceEvent {
  final List<DeviceInfo> devices;
  const DevicesUpdated(this.devices);
  @override
  List<Object> get props => [devices];
}

abstract class DeviceState extends Equatable {
  const DeviceState();
  @override
  List<Object> get props => [];
}

class DeviceLoading extends DeviceState {}
class DeviceLoaded extends DeviceState {
  final List<DeviceInfo> devices;
  const DeviceLoaded(this.devices);
  @override
  List<Object> get props => [devices];
}

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceManager _deviceManager;
  StreamSubscription? _deviceSub;

  DeviceBloc(this._deviceManager) : super(DeviceLoading()) {
    on<LoadDevices>((event, emit) {
       _deviceSub?.cancel();
       _deviceSub = _deviceManager.devices.listen((deviceList) {
           add(DevicesUpdated(deviceList));
       });
    });
    
    on<DevicesUpdated>((event, emit) {
       emit(DeviceLoaded(event.devices));
    });
  }
  
  @override
  Future<void> close() {
    _deviceSub?.cancel();
    return super.close();
  }
}
