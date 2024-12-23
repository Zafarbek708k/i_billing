import 'package:i_billing/core/service/api_const.dart';
import 'package:i_billing/core/service/network_service.dart';
import 'package:i_billing/feature/contracts/data/model/full_contract_model.dart';
import 'package:i_billing/feature/contracts/domain/repositories/contract_repository.dart';

class ContractRepositoryImplementation extends ContractRepository{
  @override
  Future<List<FullContractModel>> getContracts() async{
    String? result = await NetworkService.get(ApiConst.apiBilling, ApiConst.emptyParam());
    if(result != null){
      final fullContractModel = fullContractModelFromJson(result);
      return fullContractModel;
    }else {
      return [];
    }
  }

}