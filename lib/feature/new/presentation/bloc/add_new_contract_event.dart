part of 'add_new_contract_bloc.dart';

@immutable
 class AddNewContractEvent {
  final String status, inn, address;
  final BuildContext context;
  final VoidCallback clear;
  //{required String status, required String inn, required String address
const AddNewContractEvent({required this.status, required this.address, required this.inn, required this.context, required this.clear});
}

