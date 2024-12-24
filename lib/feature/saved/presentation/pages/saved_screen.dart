import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/common/app_route_name.dart';
import 'package:i_billing/feature/contracts/data/model/full_contract_model.dart';
import '../../../contracts/presentation/widgets/contract_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Contract> items = [];

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: items.isNotEmpty
            ? ListView(
                children: [
                  ...List.generate(
                    items.length,
                    (index) {
                      final model = items[index];
                      return ContractWidget(
                        model: model,
                        onTap: () {

                        },
                      );
                    },
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/icons/empty_saved.svg"),
                    const SizedBox(height: 10),
                    const Text("No saved contracts", style: TextStyle(color: Color(0xffE7E7E7)))
                  ],
                ),
              ),
      ),
    );
  }
}
