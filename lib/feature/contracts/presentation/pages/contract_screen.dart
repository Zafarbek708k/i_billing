import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/feature/contracts/presentation/bloc/contract_bloc/contract_bloc.dart';
import 'package:i_billing/feature/contracts/presentation/pages/filter.dart';
import 'package:i_billing/feature/contracts/presentation/pages/search.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/pagination.dart';

import '../../../new/presentation/bloc/add_new_contract_bloc.dart';
import '../widgets/calendar.dart';

bool one = true;

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkest,
      appBar: AppBar(
        backgroundColor: AppColors.darkest,
        forceMaterialTransparency: true,
        leading: const Padding(padding: EdgeInsets.only(left: 18.0), child: CircleAvatar(radius: 10)),
        title: const Text("Contracts", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Filter())),
            icon: SvgPicture.asset("assets/icons/Filter.svg"),
          ),
          const Text("|", style: TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Search())),
            icon: const Icon(Icons.search, color: AppColors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomCalendarWidget(pressData: (){}),
            BlocBuilder<ContractBloc, ContractState>(
              builder: (context, state) {
                dynamic addScreenStatus = context.select((AddNewContractBloc bloc) => bloc.state).status;
                if (addScreenStatus == NewContractStatus.loaded && one) {
                  context.read<ContractBloc>().add(GetAllContractEvent());
                  one = false;
                }
                if (state.status == HomeStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == HomeStatus.error) {
                  return RefreshIndicator(
                    onRefresh: ()async{
                      context.read<ContractBloc>().add(GetAllContractEvent());
                    },
                    child: Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 250),
                          Center(child: Text(state.errorMsg ?? "something went wrong", style: const TextStyle(color: Colors.red))),
                        ],
                      ),
                    ),
                  );
                }
                if (state.status == HomeStatus.loaded) {
                  return PaginationExample(contractList: state.contractList!);
                }
                return Center(
                  child: Card(
                    child: ListTile(
                      title: Text("default state ${state.status}"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
