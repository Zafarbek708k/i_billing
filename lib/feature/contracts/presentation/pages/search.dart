import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:i_billing/core/common/app_colors.dart";
import "package:i_billing/core/extension/context_extension.dart";
import "package:i_billing/feature/contracts/presentation/pages/contract_detail.dart";

import "../bloc/contract_bloc/contract_bloc.dart";
import "../widgets/contract_widget.dart";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController srchCtrl = TextEditingController();

  @override
  void dispose() {
    srchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darker,
      appBar: AppBar(
        backgroundColor: AppColors.darker,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.close))],
        title: TextField(
          controller: srchCtrl,
          style: const TextStyle(color: Colors.white),
          onChanged: (value) => context.read<ContractBloc>().search(value),
        ),
      ),
      body: BlocBuilder<ContractBloc, ContractState>(
        builder: (context, state) {
          if (state.status == HomeStatus.error) {
            return Center(child: Text(state.errorMsg!, style: context.textTheme.displayMedium?.copyWith(color: Colors.red)));
          }
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.initial) {
            return const SizedBox.shrink();
          }
          if (state.status == HomeStatus.loaded) {
            return ListView(
              children: [
                ...List.generate(
                  state.filterList != null ? state.filterList!.length : 0,
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
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
