import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/common/app_route_name.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/data_select.dart';
import 'package:i_billing/feature/history/presentation/bloc/history_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(GetAllContractEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkest,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.darkest,
        leading: const Padding(padding: EdgeInsets.only(left: 18.0), child: CircleAvatar(radius: 10)),
        title: const Text("History", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, AppRouteName.filter), icon: SvgPicture.asset("assets/icons/Filter.svg")),
          const Text("|", style: TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(onPressed: () => Navigator.pushNamed(context, AppRouteName.search), icon: const Icon(Icons.search, color: AppColors.white)),
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state.status == HistoryStatus.error) {
            return Center(child: Text(state.errorMsg!, style: context.textTheme.displayMedium?.copyWith(color: Colors.red)));
          }
          if (state.status == HistoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HistoryStatus.init) {
            return const SizedBox.shrink();
          }
          if (state.status == HistoryStatus.loaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text("Date", style: context.textTheme.displayMedium?.copyWith(color: Colors.white))),
                  Row(
                    children: [
                      DateBox(
                        label: "Start Time",
                        date: state.startTime,
                        onDateSelected: (data) {
                          log("Date ==> 2022, 12, 30 i need but data = $data");
                          final year = data.year;
                          final month = data.month;
                          final day = data.day;
                          context.read<HistoryBloc>().add(StartTimeEvent(startTime: DateTime(year, month, day)));
                        }
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                      DateBox(
                        label: "End Time",
                        date: state.endTime,
                        onDateSelected: (data){
                          final year = data.year;
                          final month = data.month;
                          final day = data.day;
                          context.read<HistoryBloc>().add(EndTimeEvent(endTime: DateTime(year, month, day)));
                        },
                      ),
                    ],
                  ),
                  state.contracts!.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            children: [
                              ...List.generate(
                                state.contracts!.length,
                                (index) {
                                  final model = state.contracts![index];
                                  return ContractWidget(model: model, onTap: () {});
                                },
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              SvgPicture.asset("assets/icons/empty_history.svg"),
                              const SizedBox(height: 10),
                              const Text("No history for this period", style: TextStyle(color: Color(0xffE7E7E7)))
                            ],
                          ),
                        ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
