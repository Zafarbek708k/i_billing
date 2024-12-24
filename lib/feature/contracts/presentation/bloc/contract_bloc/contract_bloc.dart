import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_billing/feature/contracts/data/model/full_contract_model.dart';
import 'package:i_billing/feature/contracts/data/repository_implementation/contract_repository_implementation.dart';
import 'package:meta/meta.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc() : super(ContractState.initial()) {
    on<ContractEvent>((event, emit) {});
    on<GetAllContractEvent>((event, emit) {});
    on<BeginDateSelectEvent>((event, emit) => beginDateSelect(event, emit));
    on<EndDateSelectEvent>((event, emit) => endDateSelect(event, emit));
    initial();
  }

  Future<void> getAllContract(GetAllContractEvent event, Emitter<ContractState> emit) async {
    List<Contract> allList = <Contract>[];
    List<Contract> countList = <Contract>[];
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      ContractRepositoryImplementation repo = ContractRepositoryImplementation();
      List<FullContractModel> modelList = await repo.getContracts();

      for (var o in modelList) {
        allList.addAll(o.contracts as Iterable<Contract>);
      }
      if (allList.length > 10) {
        for (int i = 0; i < 10; i++) {
          countList.addAll(allList[i] as Iterable<Contract>);
        }
      } else {
        countList = allList;
      }
      emit(state.copyWith(status: HomeStatus.loaded, contractList: countList, fullContractModel: modelList));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.error, errorMsg: "Something went wring.\nError: $error"));
    }
  }

  Future<void> initial() async {
    List<FullContractModel> fullContractList = [];
    List<Contract> contractList = [];
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      ContractRepositoryImplementation repo = ContractRepositoryImplementation();
      fullContractList = await repo.getContracts();
      if (fullContractList.length > 10) {
        for (int i = 0; i < 10; i++) {
          contractList.addAll(fullContractList[i].contracts ?? []);
        }
      } else {
        for (var o in fullContractList) {
          contractList.addAll(o.contracts ?? []);
        }
      }
      emit(state.copyWith(status: HomeStatus.loaded, contractList: contractList));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.error, errorMsg: "Something went wrong \n Error: $error"));
    }
  }

  void beginDateSelect(BeginDateSelectEvent event, Emitter<ContractState> emit) {
    emit(state.copyWith(beginDate: event.beginTime));
  }

  void endDateSelect(EndDateSelectEvent event, Emitter<ContractState> emit) {
    emit(state.copyWith(endDate: event.endTime));
  }


  void search(String text){
    final list = state.contractList;

    final filteredList = list!.where((contract) {
      return contract.author
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase());
    }).toList();
    emit(state.copyWith(status: HomeStatus.loaded, filterList: filteredList));
  }
}
