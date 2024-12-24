import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/core/widgets/main_button.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/contract_widget.dart';

import '../../data/model/full_contract_model.dart';

class ContractDetail extends StatefulWidget {
  const ContractDetail({super.key, required this.model, this.items});

  final Contract model;
  final List<Contract>? items;

  @override
  State<ContractDetail> createState() => _ContractDetailState();
}

class _ContractDetailState extends State<ContractDetail> {
  String paymentStatus = '';

  void selectType(String type) {
    switch (type) {
      case "paid":
        paymentStatus = "paid".tr();
      case "inProgress":
        paymentStatus = "inProcess".tr();
      case "rejectByPayme":
        paymentStatus = "rejectByPayme".tr();
      case "rejectByIQ":
        paymentStatus = "rejectByIQ".tr();
    }
  }

  @override
  void initState() {
    log("status == > ${widget.model.status}");
    selectType(widget.model.status!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///    backgroundColor: AppColors.darkest,
    //       appBar: AppBar(
    //         backgroundColor: AppColors.darkest,
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkest,
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/contract.svg"),
            SvgPicture.asset(
              "assets/icons/number.svg",
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(Color(0xffE7E7E7), BlendMode.modulate),
            ),
            Text(
              widget.model.numberOfInvoice!,
              style: const TextStyle(color: Color(0xffE7E7E7), fontSize: 19),
            )
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/icons/outline_save.svg")), const SizedBox(width: 10)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.dark,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text("Fisher's full name: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Text("${widget.model.author}", style: const TextStyle(color: Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Status of the contract: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Text(paymentStatus, style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Amount: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Text("${widget.model.amount}",style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Last Invoice: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Text("${widget.model.lastInvoice}",style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Number of invoices: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Text("${widget.model.numberOfInvoice}",style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      children: [
                        Text("Address of the organization: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Expanded(child: Text("${widget.model.addresOrganization}",style: context.textTheme.bodyMedium?.copyWith(color: const Color
                          (0xff999999)))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("ITN/IEC of the organization: ", style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                        Text("${widget.model.innOrganization}",style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text("Created at: ", style: TextStyle(color: Color(0xffE7E7E7))),
                        Text("${widget.model.dateTime}",style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xff999999))),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    onPressed: () {},
                    title: "Delete contract",
                    bcgC: Colors.red.withOpacity(0.2),
                    textC: Colors.red,
                    select: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MainButton(
                    onPressed: () {},
                    title: "Save contract",
                    bcgC: AppColors.primary.withOpacity(0.2),
                    textC: AppColors.primary,
                    select: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Other contracts with \n ${widget.model.author}",
                style: const TextStyle(color: Color(0xffE7E7E7), fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (widget.items != null)
                    ...List.generate(
                      widget.items!.length,
                      (index) {
                        final model = widget.items![index];
                        return ContractWidget(model: model, onTap: () {});
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
