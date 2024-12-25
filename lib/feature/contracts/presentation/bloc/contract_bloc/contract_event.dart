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

class FilterEvent extends ContractEvent{
  final bool paid, process, rejectIq, rejectPay;
  final DateTime start, end;
  FilterEvent({required this.paid, required this.process, required this.rejectIq, required this.rejectPay, required this.end, required this.start});
}

class AuthorContractsEvent extends ContractEvent{
  final String authorName;
  AuthorContractsEvent({required this.authorName});
}

class SaveContractEvent extends ContractEvent{
  final String contractId;
  final String authorName;
  SaveContractEvent({required this.contractId, required this.authorName});
}

class DeleteContractEvent extends ContractEvent{
  final String contractId, authorName;
  DeleteContractEvent({required this.contractId, required this.authorName});
}
