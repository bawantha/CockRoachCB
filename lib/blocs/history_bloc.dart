import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/clipboard_models.dart';
import '../services/interfaces/history_service.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object> get props => [];
}

class LoadHistory extends HistoryEvent {}

abstract class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  final List<ClipboardEntryMeta> entries;
  const HistoryLoaded(this.entries);
  @override
  List<Object> get props => [entries];
}

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryService _historyService;

  HistoryBloc(this._historyService) : super(HistoryLoading()) {
    on<LoadHistory>((event, emit) async {
       emit(HistoryLoading());
       // Normally we listen to a stream, but since history returns a list,
       // we can just emit what we have.
       emit(HistoryLoaded(_historyService.history));
    });
  }
}
