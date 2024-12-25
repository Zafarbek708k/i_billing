// To parse this JSON data, do
//
//     final oneUser = oneUserFromJson(jsonString);

import 'dart:convert';

OneUser oneUserFromJson(String str) => OneUser.fromJson(json.decode(str));

String oneUserToJson(OneUser data) => json.encode(data.toJson());

class OneUser {
  final String? id;
  final String? fullName;
  final List<Contract>? contracts;

  OneUser({
    this.id,
    this.fullName,
    this.contracts,
  });

  OneUser copyWith({
    String? id,
    String? fullName,
    List<Contract>? contracts,
  }) =>
      OneUser(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        contracts: contracts ?? this.contracts,
      );

  factory OneUser.fromJson(Map<String, dynamic> json) => OneUser(
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
      {this.author,
      this.status,
      this.amount,
      this.lastInvoice,
      this.numberOfInvoice,
      this.addresOrganization,
      this.innOrganization,
      this.dateTime,
      this.contractId,
      this.saved});

  Contract copyWith(
          {String? author,
          String? status,
          String? amount,
          String? lastInvoice,
          String? numberOfInvoice,
          String? addresOrganization,
          String? innOrganization,
          String? dateTime,
          String? contractId,
          bool? saved}) =>
      Contract(
        author: author ?? this.author,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        contractId: contractId ?? this.contractId,
        saved: saved ?? this.saved,
        lastInvoice: lastInvoice ?? this.lastInvoice,
        numberOfInvoice: numberOfInvoice ?? this.numberOfInvoice,
        addresOrganization: addresOrganization ?? this.addresOrganization,
        innOrganization: innOrganization ?? this.innOrganization,
        dateTime: dateTime ?? this.dateTime,
      );

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        author: json["author"],
        contractId: json["contractId"],
        status: json["status"],
        saved: json["saved"],
        amount: json["amount"],
        lastInvoice: json["lastInvoice"],
        numberOfInvoice: json["numberOfInvoice"],
        addresOrganization: json["addresOrganization"],
        innOrganization: json["INNOrganization"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "contractId": contractId,
        "status": status,
        "amount": amount,
        "saved": saved,
        "lastInvoice": lastInvoice,
        "numberOfInvoice": numberOfInvoice,
        "addresOrganization": addresOrganization,
        "INNOrganization": innOrganization,
        "dateTime": dateTime,
      };
}
