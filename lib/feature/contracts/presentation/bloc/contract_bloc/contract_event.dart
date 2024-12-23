part of 'contract_bloc.dart';

@immutable
class ContractEvent {}

class GetAllContractEvent extends ContractEvent{}

class BeginDateSelectEvent extends ContractEvent{
  final DateTime beginTime;
  BeginDateSelectEvent({required this.beginTime});
}
class EndDateSelectEvent extends ContractEvent{
  final DateTime endTime;
  EndDateSelectEvent({required this.endTime});
}
