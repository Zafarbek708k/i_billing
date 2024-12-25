import 'package:bloc/bloc.dart';
import 'package:i_billing/core/service/api_const.dart';
import 'package:i_billing/core/service/network_service.dart';
import 'package:i_billing/feature/contracts/data/model/full_contract_model.dart';
import 'package:meta/meta.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedState.init()) {
    on<SavedEvent>((event, emit) {});
    on<GetAllSavedDataEvent>((event, emit) => getAllSavedEvent(event, emit));
  }

  Future<void> getAllSavedEvent(GetAllSavedDataEvent event , Emitter<SavedState> emit)async{
    emit(state.copyWith(status: SavedStatus.loading));
    String? result = await NetworkService.get(ApiConst.apiSavedData, ApiConst.emptyParam());
    if(result != null){
      List<Contract> savedContracts = contractFromJson(result);
      emit(state.copyWith(status: SavedStatus.loaded, savedContract: savedContracts));
    }else{
      emit(state.copyWith(status: SavedStatus.error, errorMsg: "Something went wrong"));
    }
  }
}
