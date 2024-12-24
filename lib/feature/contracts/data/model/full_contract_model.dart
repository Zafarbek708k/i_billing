// To parse this JSON data, do
//
//     final fullContractModel = fullContractModelFromJson(jsonString);

import 'dart:convert';
enum Status{paid, inProgress, rejectByIQ, rejectByPayme}


List<FullContractModel> fullContractModelFromJson(String str) => List<FullContractModel>.from(json.decode(str).map((x) => FullContractModel.fromJson(x)));

String fullContractModelToJson(List<FullContractModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  Contract({
    this.author,
    this.status,
    this.amount,
    this.lastInvoice,
    this.numberOfInvoice,
    this.addresOrganization,
    this.innOrganization,
    this.dateTime,
  });

  Contract copyWith({
    String? author,
    String? status,
    String? amount,
    String? lastInvoice,
    String? numberOfInvoice,
    String? addresOrganization,
    String? innOrganization,
    String? dateTime,
  }) =>
      Contract(
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

