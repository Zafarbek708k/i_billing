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

  String monthChecker(int day) {
    switch (day) {
      case 1:return "January";
      case 2:return "February";
      case 3:return "March";
      case 4:return "April";
      case 5:return "May";
      case 6:return "June";
      case 7:return "July";
      case 8:return "August";
      case 9:return "September";
      case 10:return "October";
      case 11:return "November";
      case 12:return "December";
      default:return "January";
    }
  }

  Future<void> addNewContract(AddNewContractEvent event, Emitter<AddNewContractState> emit) async {
    emit(state.copyWith(status: NewContractStatus.loading));
    String? oneUserStringData = await NetworkService.get("${ApiConst.apiBilling}/1", ApiConst.emptyParam());
    if (oneUserStringData != null) {
      final oneUserModel = oneUserFromJson(oneUserStringData);
      String month = monthChecker(DateTime.now().month);
      final contract = Contract(
        status: event.status,
        numberOfInvoice: "6",
        lastInvoice: "256",
        innOrganization: event.inn,
        dateTime: "12:30, ${DateTime.now().day} $month, ${DateTime.now().year}",
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
