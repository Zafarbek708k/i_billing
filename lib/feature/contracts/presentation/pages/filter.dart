import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/core/widgets/main_button.dart';
import 'package:i_billing/feature/contracts/presentation/pages/contract_detail.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/check_box_custom.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/contract_widget.dart';

import '../../../../core/common/app_colors.dart';
import '../bloc/contract_bloc/contract_bloc.dart';
import '../widgets/data_select.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool paid = false, inProcess = false, rejectByIQ = false, rejectByPayme = false;

  @override
  void initState() {
    context.read<ContractBloc>().add(
          FilterEvent(
            paid: paid,
            process: inProcess,
            rejectIq: rejectByIQ,
            rejectPay: rejectByPayme,
            end: DateTime.now(),
            start: DateTime.now(),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkest,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Filters", style: context.textTheme.displayLarge?.copyWith(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status", style: context.textTheme.displayLarge?.copyWith(color: Colors.grey)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckBox(selected: paid, text: "Paid", onTap: () => setState(() => paid = !paid)),
                    CustomCheckBox(selected: rejectByIQ, text: "Rejected by IQ", onTap: () => setState(() => rejectByIQ = !rejectByIQ)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckBox(selected: inProcess, text: "In Precess", onTap: () => setState(() => inProcess = !inProcess)),
                    CustomCheckBox(selected: rejectByPayme, text: "Rejected by Payment", onTap: () => setState(() => rejectByPayme = !rejectByPayme)),
                  ],
                )
              ],
            ),
            15.verticalSpace,
            Text("Date", style: context.textTheme.displayLarge?.copyWith(color: Colors.grey)),
            const DateSelection(),
            BlocBuilder<ContractBloc, ContractState>(
              builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == HomeStatus.error) {
                  return Center(child: Text(state.errorMsg!, style: context.textTheme.bodyMedium?.copyWith(color: Colors.red)));
                }
                if (state.status == HomeStatus.initial) {}
                if (state.status == HomeStatus.loaded) {
                  return Expanded(
                    child: ListView(
                      children: [
                        ...List.generate(
                          state.filterList?.length ?? 0,
                          (index) {
                            return ContractWidget(
                              model: state.filterList![index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContractDetail(model: state.filterList![index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 50)
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                  onPressed: () {},
                  title: "Cancel",
                  bcgC: const Color(0xff008F7F).withOpacity(0.5),
                  textC: const Color(0xff008F7F).withOpacity(0.8),
                  select: true,
                  height: 35,
                  minWith: 125),
              const SizedBox(width: 25),
              BlocBuilder<ContractBloc, ContractState>(
                builder: (context, state) {
                  return MainButton(
                      onPressed: () {
                        log("begin ${state.beginDate}\n end ${state.endDate} \n paid = $paid \n process = $inProcess \n reject iq $rejectByIQ \n "
                            "reject payme $rejectByPayme \n");
                        context.read<ContractBloc>().add(
                              FilterEvent(
                                paid: paid,
                                process: inProcess,
                                rejectIq: rejectByIQ,
                                rejectPay: rejectByPayme,
                                end: state.endDate!,
                                start: state.beginDate!,
                              ),
                            );
                      },
                      title: "Apply Filters",
                      bcgC: const Color(0xff008F7F),
                      select: true,
                      height: 35,
                      minWith: 125);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: TextField(
//     onChanged: filterItems,
//     decoration: InputDecoration(
//       hintText: "Search by id, name, or date...",
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     ),
//   ),
// ),
// Expanded(
//   child: ListView.builder(
//     itemCount: filteredItems.length,
//     itemBuilder: (context, index) {
//       final item = filteredItems[index];
//       return ListTile(
//         title: Text(item.name),
//         subtitle: Text("${item.id} - ${item.dateTime}"),
//       );
//     },
//   ),
// ),
