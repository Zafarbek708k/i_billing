import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/feature/saved/presentation/bloc/saved_bloc.dart';

import '../../../contracts/presentation/widgets/contract_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    context.read<SavedBloc>().add(GetAllSavedDataEvent());
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
        title: const Text("Saved", style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) {
          if (state.status == SavedStatus.error) {
            return Center(child: Text(state.errorMsg!, style: context.textTheme.bodyMedium?.copyWith(color: Colors.red)));
          }
          if (state.status == SavedStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == SavedStatus.init) {
            return Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<SavedBloc>().add(GetAllSavedDataEvent());
                },
                child: ListView(
                  children: [
                    SvgPicture.asset("assets/icons/empty_saved.svg"),
                    const SizedBox(height: 10),
                    const Text("No saved contracts", style: TextStyle(color: Color(0xffE7E7E7)))
                  ],
                ),
              ),
            );
          }
          if (state.status == SavedStatus.loaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<SavedBloc>().add(GetAllSavedDataEvent());
                },
                child: ListView(
                  children: [
                    state.savedContract!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 150),
                              SvgPicture.asset("assets/icons/empty_saved.svg"),
                              const SizedBox(height: 10),
                              const Text("No saved contracts", style: TextStyle(color: Color(0xffE7E7E7)))
                            ],
                          )
                        : const SizedBox.shrink(),
                    ...List.generate(
                      state.savedContract!.length,
                      (index) {
                        final model = state.savedContract![index];
                        return ContractWidget(model: model, onTap: () {});
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
