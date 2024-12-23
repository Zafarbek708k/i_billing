import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/common/app_route_name.dart';
import 'package:i_billing/feature/contracts/presentation/bloc/contract_bloc/contract_bloc.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/pagination.dart';

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
          IconButton(onPressed: () => Navigator.pushNamed(context, AppRouteName.filter), icon: SvgPicture.asset("assets/icons/Filter.svg")),
          const Text("|", style: TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRouteName.search),
            icon: const Icon(Icons.search, color: AppColors.white),
          ),
        ],
      ),
      body: BlocBuilder<ContractBloc, ContractState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.error) {
            return Center(child: Text(state.errorMsg ?? "something went wrong", style: const TextStyle(color: Colors.red)));
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
    );
  }
}
