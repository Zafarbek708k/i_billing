import 'package:i_billing/feature/contracts/data/model/full_contract_model.dart';

abstract class ContractRepository{
  Future<List<FullContractModel>> getContracts();
}