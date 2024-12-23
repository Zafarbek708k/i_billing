// enum PaymentType { paid, inProgress, rejectedByPayme, rejectedByIQ }
//
// class ContractModel {
//   String? number, name, lastName, dateTime, addressOfTheOrganization, itnIceOfTheOrganization;
//   double? amount, lastInvoice, numberOfInvoice;
//   PaymentType? type;
//
//   ContractModel({
//     this.number,
//     this.name,
//     this.lastName,
//     this.dateTime,
//     this.amount,
//     this.lastInvoice,
//     this.numberOfInvoice,
//     this.type,
//     this.addressOfTheOrganization,
//     this.itnIceOfTheOrganization
//   });
// }
//
// class DefaultContracts {
//   static final List<ContractModel> contracts = [
//     ContractModel(
//       number: "C001",
//       name: "John",
//       lastName: "Doe",
//       dateTime: "2024-12-01",
//       amount: 5000.0,
//       lastInvoice: 1000.0,
//       numberOfInvoice: 5,
//       type: PaymentType.paid,
//     ),
//     ContractModel(
//       number: "C002",
//       name: "Jane",
//       lastName: "Smith",
//       dateTime: "2024-11-15",
//       amount: 3000.0,
//       lastInvoice: 500.0,
//       numberOfInvoice: 6,
//       type: PaymentType.inProgress,
//     ),
//     ContractModel(
//       number: "C003",
//       name: "Michael",
//       lastName: "Brown",
//       dateTime: "2024-10-10",
//       amount: 1200.0,
//       lastInvoice: 200.0,
//       numberOfInvoice: 4,
//       type: PaymentType.rejectedByPayme,
//     ),
//     ContractModel(
//       number: "C004",
//       name: "Emily",
//       lastName: "Davis",
//       dateTime: "2024-09-25",
//       amount: 800.0,
//       lastInvoice: 150.0,
//       numberOfInvoice: 2,
//       type: PaymentType.rejectedByIQ,
//     ),
//     ContractModel(
//       number: "C005",
//       name: "David",
//       lastName: "Miller",
//       dateTime: "2024-08-30",
//       amount: 4500.0,
//       lastInvoice: 900.0,
//       numberOfInvoice: 3,
//       type: PaymentType.paid,
//     ),
//     ContractModel(
//       number: "C006",
//       name: "Sophia",
//       lastName: "Wilson",
//       dateTime: "2024-07-20",
//       amount: 2500.0,
//       lastInvoice: 500.0,
//       numberOfInvoice: 5,
//       type: PaymentType.inProgress,
//     ),
//     ContractModel(
//       number: "C007",
//       name: "Daniel",
//       lastName: "Moore",
//       dateTime: "2024-06-10",
//       amount: 3200.0,
//       lastInvoice: 800.0,
//       numberOfInvoice: 4,
//       type: PaymentType.rejectedByPayme,
//     ),
//     ContractModel(
//       number: "C008",
//       name: "Chloe",
//       lastName: "Taylor",
//       dateTime: "2024-05-15",
//       amount: 1700.0,
//       lastInvoice: 400.0,
//       numberOfInvoice: 6,
//       type: PaymentType.rejectedByIQ,
//     ),
//     ContractModel(
//       number: "C009",
//       name: "Liam",
//       lastName: "Anderson",
//       dateTime: "2024-04-05",
//       amount: 1000.0,
//       lastInvoice: 250.0,
//       numberOfInvoice: 4,
//       type: PaymentType.paid,
//     ),
//     ContractModel(
//       number: "C010",
//       name: "Olivia",
//       lastName: "Thomas",
//       dateTime: "2024-03-15",
//       amount: 500.0,
//       lastInvoice: 100.0,
//       numberOfInvoice: 2,
//       type: PaymentType.inProgress,
//     ),
//   ];
// }
