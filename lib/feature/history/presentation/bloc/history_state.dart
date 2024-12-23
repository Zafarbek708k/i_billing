part of 'history_bloc.dart';

enum HistoryStatus { init, loading, loaded, error }

@immutable
class HistoryState {
  final HistoryStatus status;
  final String? errorMsg;
  final DateTime? startTime, endTime;
  final List<Contract>? contracts;
  final List<FullContractModel>? fullContractModel;

  const HistoryState({this.fullContractModel, required this.status, this.endTime, this.startTime, this.contracts, this.errorMsg});

  static HistoryState initial() => const HistoryState(status: HistoryStatus.init);

  HistoryState copyWith({
    HistoryStatus? status,
    DateTime? startTime,
    DateTime? endTime,
    List<Contract>? contracts,
    List<FullContractModel>? fullContractModel,
    String? errorMsg,
  }) =>
      HistoryState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? endTime,
        contracts: contracts ?? this.contracts,
        fullContractModel: fullContractModel ?? this.fullContractModel,
      );
}
