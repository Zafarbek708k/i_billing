// To parse this JSON data, do
//
//     final fullContractModel = fullContractModelFromJson(jsonString);

import 'dart:convert';

List<FullContractModel> fullContractModelFromJson(String str) =>
    List<FullContractModel>.from(json.decode(str).map((x) => FullContractModel.fromJson(x)));

String fullContractModelToJson(List<FullContractModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

FullContractModel personFromJson(String str) => FullContractModel.fromJson(json.decode(str));

List<Contract> contractFromJson(String str) => List<Contract>.from(json.decode(str).map((x) => Contract.fromJson(x)));

String contractToJson(List<Contract> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FullContractModel {
  final String? id;
  final String? fullName;
  final List<Contract>? contracts;

  FullContractModel({
    this.id,
    this.fullName,
    this.contracts,
  });

  FullContractModel copyWith({
    String? id,
    String? fullName,
    List<Contract>? contracts,
  }) =>
      FullContractModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        contracts: contracts ?? this.contracts,
      );

  factory FullContractModel.fromJson(Map<String, dynamic> json) => FullContractModel(
        id: json["id"],
        fullName: json["fullName"],
        contracts: json["contracts"] == null ? [] : List<Contract>.from(json["contracts"]!.map((x) => Contract.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "contracts": contracts == null ? [] : List<dynamic>.from(contracts!.map((x) => x.toJson())),
      };
}

class Contract {
  final String? author;
  final String? status;
  final String? amount;
  final String? lastInvoice;
  final String? numberOfInvoice;
  final String? addresOrganization;
  final String? innOrganization;
  final String? dateTime;
  final String? contractId;
  bool? saved;

  Contract(
      {this.contractId,
      this.author,
      this.status,
      this.amount,
      this.lastInvoice,
      this.numberOfInvoice,
      this.addresOrganization,
      this.innOrganization,
      this.dateTime,
      this.saved});

  Contract copyWith({
    String? author,
    String? contractId,
    String? status,
    String? amount,
    String? lastInvoice,
    String? numberOfInvoice,
    String? addresOrganization,
    String? innOrganization,
    String? dateTime,
    bool? saved,
  }) =>
      Contract(
        contractId: contractId ?? this.contractId,
        saved: saved ?? this.saved,
        author: author ?? this.author,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        lastInvoice: lastInvoice ?? this.lastInvoice,
        numberOfInvoice: numberOfInvoice ?? this.numberOfInvoice,
        addresOrganization: addresOrganization ?? this.addresOrganization,
        innOrganization: innOrganization ?? this.innOrganization,
        dateTime: dateTime ?? this.dateTime,
      );

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        contractId: json["contractId"],
        saved: json["saved"],
        author: json["author"],
        status: json["status"],
        amount: json["amount"],
        lastInvoice: json["lastInvoice"],
        numberOfInvoice: json["numberOfInvoice"],
        addresOrganization: json["addresOrganization"],
        innOrganization: json["INNOrganization"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "contractId": contractId,
        "saved": saved,
        "author": author,
        "status": status,
        "amount": amount,
        "lastInvoice": lastInvoice,
        "numberOfInvoice": numberOfInvoice,
        "addresOrganization": addresOrganization,
        "INNOrganization": innOrganization,
        "dateTime": dateTime,
      };
}
