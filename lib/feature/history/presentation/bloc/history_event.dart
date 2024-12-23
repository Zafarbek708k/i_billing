part of 'history_bloc.dart';

@immutable
class HistoryEvent {}

class GetAllContractEvent extends HistoryEvent{}

class StartTimeEvent extends HistoryEvent{
  final DateTime startTime;
  StartTimeEvent({required this.startTime});
}

class EndTimeEvent extends HistoryEvent{
  final DateTime endTime;
  EndTimeEvent({required this.endTime});
}
