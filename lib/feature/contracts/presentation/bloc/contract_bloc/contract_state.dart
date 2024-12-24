part of 'contract_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

@immutable
final class ContractState {
  final HomeStatus status;
  final List<FullContractModel>? fullContractModel;
  final List<Contract>? contractList;
  final List<Contract>? filterList;
  final String? errorMsg;
  final DateTime? beginDate;
  final DateTime? endDate;

  const ContractState(
      {this.beginDate, this.endDate, required this.status, this.fullContractModel, this.contractList, this.filterList, this.errorMsg});

  static ContractState initial() => const ContractState(status: HomeStatus.initial, contractList: []);

  ContractState copyWith(
          {HomeStatus? status,
          List<FullContractModel>? fullContractModel,
          List<Contract>? contractList,
          List<Contract>? filterList,
          String? errorMsg,
          DateTime? beginDate,
          DateTime? endDate}) =>
      ContractState(
          status: status ?? this.status,
          fullContractModel: fullContractModel ?? this.fullContractModel,
          contractList: contractList ?? this.contractList,
          errorMsg: errorMsg ?? this.errorMsg,
          beginDate: beginDate ?? this.beginDate,
          endDate: endDate ?? this.endDate,
          filterList: filterList ?? this.filterList,
      );
}
