import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_billing/feature/contracts/data/model/full_contract_model.dart';
import 'package:i_billing/feature/contracts/data/repository_implementation/contract_repository_implementation.dart';
import 'package:meta/meta.dart';

import '../../../../../core/service/api_const.dart';
import '../../../../../core/service/network_service.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc() : super(ContractState.initial()) {
    on<ContractEvent>((event, emit) {});
    on<GetAllContractEvent>((event, emit) => getAllContract(event, emit));
    on<FilterEvent>((event, emit) => filterEvent(event, emit));
    on<BeginDateSelectEvent>((event, emit) => beginDateSelect(event, emit));
    on<EndDateSelectEvent>((event, emit) => endDateSelect(event, emit));
    on<AuthorContractsEvent>((event, emit) => authorContracts(event, emit));
    on<SaveContractEvent>((event, emit) => saveContract(event, emit));
    on<DeleteContractEvent>((event, emit) => deleteContract(event, emit));
    initial();
  }

  Future<void> deleteContract(DeleteContractEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    String? onePerson = await NetworkService.get("${ApiConst.apiBilling}/1", ApiConst.emptyParam());
    if (onePerson != null) {
      final person = personFromJson(onePerson);
      if (person.fullName == event.authorName) {
        // delete from saved api
        for (var value in person.contracts!) {
          if (value.contractId == event.contractId && value.saved!) {
            log("delete api ${ApiConst.apiSavedData}/${value.contractId}");
            String? deleteSavedContract = await NetworkService.delete(
              "${ApiConst.apiSavedData}/${value.contractId}",
              ApiConst.emptyParam(),
            );
            if(deleteSavedContract != null){
              log("Apidan ham o'chdi");
            }
          }
        }
        // delete from list after that update to Mock api
        person.contracts!.removeWhere((value) {
          return value.contractId == event.contractId;
        });
        String? updateNetworkData = await NetworkService.put(ApiConst.apiBilling, "1", person.toJson());
        if(updateNetworkData != null){
          emit(state.copyWith(status: HomeStatus.loaded, authorContracts: person.contracts));
        }else{
          emit(state.copyWith(status: HomeStatus.error, errorMsg: "Something went wrong at Update data"));
        }
      } else {
        emit(state.copyWith(status: HomeStatus.error, errorMsg: "Another user data", contractList: state.contractList));
      }
    } else {
      emit(state.copyWith(status: HomeStatus.error, errorMsg: "Something went wrong at Delete data"));
    }
  }

  Future<void> saveContract(SaveContractEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    String? onePersonData = await NetworkService.get("${ApiConst.apiBilling}/1", ApiConst.emptyParam());
    if (onePersonData != null) {
      final onePerson = personFromJson(onePersonData);
      if (onePerson.fullName == event.authorName) {
        Contract oldCon = onePerson.contracts!.firstWhere(
          (value) => event.contractId == value.contractId,
          orElse: () => throw Exception('Contract not found'),
        );
        log("bloc => ${onePerson.fullName} == ${event.authorName} \n old contract save? => ${oldCon.saved}");
        final index = onePerson.contracts!.indexWhere((item) => item.contractId == event.contractId);
        final updatedContract = Contract(
          author: oldCon.author,
          status: oldCon.status,
          contractId: oldCon.contractId,
          amount: oldCon.amount,
          lastInvoice: oldCon.lastInvoice,
          numberOfInvoice: oldCon.numberOfInvoice,
          addresOrganization: oldCon.addresOrganization,
          innOrganization: oldCon.innOrganization,
          dateTime: oldCon.dateTime,
          saved: true,
        );
        onePerson.contracts![index] = updatedContract;
        String? update = await NetworkService.put(ApiConst.apiBilling, "1", onePerson.toJson());
        String? result = await NetworkService.post(ApiConst.apiSavedData, updatedContract.toJson());
        if (result != null && update != null) {
          log("post boldi updated contract save value => ${onePerson.contracts![index].saved}");
          emit(state.copyWith(status: HomeStatus.loaded, authorContracts: onePerson.contracts));
        } else {
          log("post bolmadi");
          emit(state.copyWith(status: HomeStatus.error, errorMsg: "Failed to save data"));
        }
      } else {
        emit(state.copyWith(status: HomeStatus.error, errorMsg: "This user is not you"));
      }
    } else {
      emit(state.copyWith(status: HomeStatus.error, errorMsg: "Something went wrong at save data"));
    }
  }

  Future<void> authorContracts(AuthorContractsEvent event, Emitter<ContractState> emit) async {
    List<Contract> authorContracts = [];
    final contracts = state.contractList;
    String authorName = event.authorName;
    emit(state.copyWith(status: HomeStatus.loading));
    authorContracts = contracts!.where((contract) => contract.author != null && contract.author!.toLowerCase() == authorName.toLowerCase()).toList();
    emit(state.copyWith(status: HomeStatus.loaded, authorContracts: authorContracts));
  }

  Future<void> filterEvent(FilterEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    // Extract filter parameters
    bool paid = event.paid;
    bool process = event.process;
    bool rejectIq = event.rejectIq;
    bool rejectPay = event.rejectPay;
    DateTime startTime = event.start;
    DateTime endTime = event.end;

    final DateFormat inputFormat = DateFormat("HH:mm, d MMMM, yyyy");

    List<Contract> items = state.contractList!;
    List<Contract> filteredList = [];

    // Apply filtering
    filteredList = items.where((item) {
      // Parse the `dateTime` string to a DateTime object
      DateTime? itemDateTime;
      try {
        itemDateTime = item.dateTime != null ? inputFormat.parse(item.dateTime!) : null;
      } catch (e) {
        emit(state.copyWith(status: HomeStatus.error, errorMsg: "Something went wrong at filter data\n error: $e"));
        return false;
      }

      // Filter based on status
      bool statusFilter = (paid && item.status == 'paid') ||
          (process && item.status == 'inProgress') ||
          (rejectIq && item.status == 'rejectByIQ') ||
          (rejectPay && item.status == 'rejectByPayme');

      // Filter based on date range
      bool dateFilter = itemDateTime != null && itemDateTime.isAfter(startTime) && itemDateTime.isBefore(endTime);

      return statusFilter && dateFilter;
    }).toList();

    // Emit the new state with the filtered list
    log("filtered list count ${filteredList.length}");
    log("all list count ${items.length}");
    emit(state.copyWith(status: HomeStatus.loaded, filterList: filteredList));
  }

  Future<void> getAllContract(GetAllContractEvent event, Emitter<ContractState> emit) async {
    List<Contract>? allList = <Contract>[];
    List<Contract>? countList = <Contract>[];
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      ContractRepositoryImplementation repo = ContractRepositoryImplementation();
      List<FullContractModel> modelList = await repo.getContracts();

      for (var o in modelList) {
        allList.addAll(o.contracts as Iterable<Contract>);
      }
      if (allList.length > 10) {
        for (int i = 0; i < 10; i++) {
          countList.add(allList[i]);
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

  void search(String text) {
    final list = state.contractList;

    final filteredList = list!.where((contract) {
      return contract.author.toString().toLowerCase().contains(text.toLowerCase());
    }).toList();
    emit(state.copyWith(status: HomeStatus.loaded, filterList: filteredList));
  }
}
