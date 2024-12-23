import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_billing/core/service/api_const.dart';
import 'package:i_billing/core/service/network_service.dart';
import 'package:meta/meta.dart';

import '../../../contracts/data/model/full_contract_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState.initial()) {
    on<HistoryEvent>((event, emit) {});
    on<StartTimeEvent>((event, emit) => startTimeEvent(event, emit));
    on<EndTimeEvent>((event, emit) => endTimeEvent(event, emit));
    on<GetAllContractEvent>((event, emit) => getAllContract(event, emit));
  }

  Future<void> getAllContract(GetAllContractEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: HistoryStatus.loading));
    String? allData = await NetworkService.get(ApiConst.apiBilling, ApiConst.emptyParam());
    if(allData != null){
      final list = <Contract>[];
      final model = fullContractModelFromJson(allData);
      for (var o in model) {
        list.addAll(o.contracts!);
      }
      log("\n\n\n\nhistory contracts length = ${list.length}");
      emit(state.copyWith(status: HistoryStatus.loaded, fullContractModel: model, contracts: list));
    }else{
      emit(state.copyWith(status: HistoryStatus.error, errorMsg: "Something went wrong to Load data"));
    }
  }

  Future<void> endTimeEvent(EndTimeEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(endTime: event.endTime));
    filterData(emit);
  }

  Future<void> startTimeEvent(StartTimeEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(startTime: event.startTime));
    filterData(emit);
  }

  Future<void> filterData(Emitter<HistoryState> emit) async {
    final dateFormat = DateFormat("HH:mm, d MMMM, yyyy"); // Adjusted to match the date format
    final filteredList = state.contracts!.where((contract) {
      try {
        final contractDate = dateFormat.parse(contract.dateTime!); // Parse the contract's date
        final isAfterFromDate = state.startTime == null || !contractDate.isBefore(state.startTime!);
        final isBeforeToDate = state.endTime == null || !contractDate.isAfter(state.endTime!);
        return isAfterFromDate && isBeforeToDate;
      } catch (e) {
        // Log or handle parsing errors
        print("Error parsing date: ${contract.dateTime}, Error: $e");
        return false; // Exclude contracts with invalid dates
      }
    }).toList();

    log("Filtered list count: ${filteredList.length}");
    emit(state.copyWith(contracts: filteredList));
  }
}
