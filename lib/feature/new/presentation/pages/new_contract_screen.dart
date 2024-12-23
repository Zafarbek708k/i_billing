import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/widgets/main_button.dart';
import 'package:i_billing/feature/new/presentation/widgets/build_custom_dropdown.dart';
import 'package:i_billing/feature/new/presentation/widgets/text_field.dart';

import '../bloc/add_new_contract_bloc.dart';

class NewContractScreen extends StatefulWidget {
  const NewContractScreen({super.key});

  @override
  State<NewContractScreen> createState() => _NewContractScreenState();
}

class _NewContractScreenState extends State<NewContractScreen> {
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  late final TextEditingController innController;
  late final FocusNode nameFocusNode;
  late final FocusNode addressFocusNode;
  late final FocusNode innFocusNode;
  String? personValue, statusValue;

  bool personValueSelected = false;
  bool statusValueSelected = false;

  @override
  void initState() {
    super.initState();
    innController = TextEditingController();
    nameFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    innFocusNode = FocusNode();
    personValue = null;
    statusValue = null;
    resetDropdownValues();
  }

  void resetDropdownValues() {
    setState(() {
      addressCtrl.clear();
      fNameCtrl.clear();
      innController.clear();
      personValue = null;
      statusValue = null;
      personValueSelected = false;
      statusValueSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkest,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.darkest,
        leading: const Padding(padding: EdgeInsets.only(left: 18.0), child: CircleAvatar(radius: 10)),
        title: const Text("New contracts", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            _buildDropdownLabel("Lico"),
            4.verticalSpace,
            BuildCustomDropdown(
              selectedValue: personValue,
              selected: personValueSelected,
              onChanged: (String? value) {
                setState(() {
                  personValue = value;
                  personValueSelected = true;
                });
              },
              items: [
                _buildDropdownItem("Jismoniy", personValue == "Jismoniy"),
                _buildDropdownItem("Yuridik", personValue == "Yuridik"),
              ],
              statusValue: personValue,
            ),
            14.verticalSpace,
            _buildDropdownLabel("Fresher's full name"),
            4.verticalSpace,
            TFWidget(controller: fNameCtrl),
            10.verticalSpace,
            const Text("Address of the organization", style: TextStyle(color: Color(0xffF1F1F1))),
            TFWidget(controller: addressCtrl),
            10.verticalSpace,
            const Text("INN", style: TextStyle(color: Color(0xffF1F1F1))),
            TFWidget(controller: innController, type: TextInputType.number),
            10.verticalSpace,
            _buildDropdownLabel("Status of the contract"),
            4.verticalSpace,
            BuildCustomDropdown(
              selectedValue: statusValue,
              selected: statusValueSelected,
              onChanged: (String? value) {
                setState(() {
                  statusValue = value;
                  statusValueSelected = true;
                  log("$statusValue");
                });
              },
              items: [
                _buildDropdownItem("Paid", statusValue == "Paid"),
                _buildDropdownItem("In Progress", statusValue == "In Progress"),
                _buildDropdownItem("Reject By IQ", statusValue == "Reject By IQ"),
                _buildDropdownItem("Reject By Payme", statusValue == "Reject By Payme"),
              ],
              statusValue: statusValue,
            ),
            16.verticalSpace,
            (statusValue != null && addressCtrl.text.isNotEmpty)
                ? BlocBuilder<AddNewContractBloc, AddNewContractState>(
                    builder: (context, state) {
                      final status = statusValue == "Paid" ? "paid" : statusValue == "In Progress"
                          ? "inProgress" : statusValue == "Reject By IQ" ? "rejectByIQ" : "rejectByPayme";
                      if (state.status == NewContractStatus.initial) {
                        return MainButton(
                          onPressed: () async => context.read<AddNewContractBloc>().add(
                                AddNewContractEvent(
                                    status: status,
                                    inn: innController.text.trim(),
                                    address: addressCtrl.text.trim(),
                                    context: context,
                                    clear: resetDropdownValues),
                              ),
                          title: "Save Contract",
                          bcgC: const Color(0xff008F7F),
                          select: true,
                          height: 50,
                        );
                      }
                      if (state.status == NewContractStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == NewContractStatus.loaded) {
                        return MainButton(
                          onPressed: () async => context.read<AddNewContractBloc>().add(
                                AddNewContractEvent(
                                    status: status,
                                    inn: innController.text.trim(),
                                    address: addressCtrl.text.trim(),
                                    context: context,
                                    clear: resetDropdownValues),
                              ),
                          title: "Save Contract",
                          bcgC: const Color(0xff008F7F),
                          select: true,
                          height: 50,
                        );
                      }
                      if (state.status == NewContractStatus.error) {
                        return Center(child: Text("Error: ${state.errorMsg}", style: const TextStyle(color: Colors.red)));
                      }
                      return const SizedBox.shrink();
                    },
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownLabel(String label) => Text(label, style: const TextStyle(color: Colors.white));

  DropdownMenuItem<String> _buildDropdownItem(String text, bool isSelected) => DropdownMenuItem(
        value: text,
        child: Row(
          children: [
            Text(text, style: const TextStyle(color: Colors.white)),
            const Spacer(),
            isSelected ? const Icon(Icons.done_all) : const SizedBox.shrink(),
          ],
        ),
      );
}
