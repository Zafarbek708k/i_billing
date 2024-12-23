import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_billing/core/service/api_const.dart';
import 'package:i_billing/core/service/network_service.dart';
import 'package:i_billing/core/service/utils_service.dart';
import 'package:i_billing/feature/new/data/models/one_user_model.dart';

part 'add_new_contract_event.dart';
part 'add_new_contract_state.dart';

class AddNewContractBloc extends Bloc<AddNewContractEvent, AddNewContractState> {
  AddNewContractBloc() : super(AddNewContractState.initial()) {
    on<AddNewContractEvent>(addNewContract);
  }

  Future<void> addNewContract(AddNewContractEvent event, Emitter<AddNewContractState> emit) async {
    emit(state.copyWith(status: NewContractStatus.loading));
    String? oneUserStringData = await NetworkService.get("${ApiConst.apiBilling}/1", ApiConst.emptyParam());
    if (oneUserStringData != null) {
      final oneUserModel = oneUserFromJson(oneUserStringData);
      final contract = Contract(
        status: event.status,
        numberOfInvoice: "6",
        lastInvoice: "256",
        innOrganization: event.inn,
        dateTime: "${DateTime.now().year}",
        amount: "456",
        addresOrganization: event.address,
        author: oneUserModel.fullName,
      );
      oneUserModel.contracts!.add(contract);
      String? putNewUserData = await NetworkService.put(ApiConst.apiBilling, oneUserModel.id!, oneUserModel.toJson());
      if (putNewUserData != null) {
        Utils.fireSnackBar("Successfully created new contract", event.context);
        emit(state.copyWith(status: NewContractStatus.loaded));
        event.clear();
      } else {
        emit(state.copyWith(status: NewContractStatus.error, errorMsg: "Something went wring at create function"));
        event.clear();
      }
    } else {
      emit(state.copyWith(status: NewContractStatus.error, errorMsg: "Something went wring at create function"));
      event.clear();
    }
  }
}
