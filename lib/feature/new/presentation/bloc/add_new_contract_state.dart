part of 'add_new_contract_bloc.dart';

enum NewContractStatus { initial, loading, loaded, error }

@immutable
class AddNewContractState {
  final NewContractStatus status;
  final String? errorMsg;

  const AddNewContractState({required this.status, this.errorMsg});

  static AddNewContractState initial() => const AddNewContractState(status: NewContractStatus.initial);

  AddNewContractState copyWith({NewContractStatus? status, String? errorMsg}) =>
      AddNewContractState(status: status ?? this.status, errorMsg: errorMsg ?? this.errorMsg);
}
