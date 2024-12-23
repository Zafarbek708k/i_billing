

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/feature/contracts/presentation/bloc/contract_bloc/contract_bloc.dart';

import '../../../../core/common/app_colors.dart';

class DateSelection extends StatelessWidget {
  const DateSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractBloc, ContractState>(
      builder: (context, state) {
        return Row(
          children: [
            DateBox(
              label: "Begin Date",
              date: state.beginDate,
              onDateSelected: (selectedData) => context.read<ContractBloc>().add(BeginDateSelectEvent(beginTime: selectedData)),
            ),
            const SizedBox(width: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.remove, color: Colors.white),
            ),
            const SizedBox(width: 12),
            DateBox(
              label: "End Date",
              date: state.endDate,
              onDateSelected: (selectedData) => context.read<ContractBloc>().add(EndDateSelectEvent(endTime: selectedData)),
            ),
          ],
        );
      },
    );
  }
}

class DateBox extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onDateSelected;

  const DateBox({
    super.key,
    required this.label,
    required this.date,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
          initialDate: date ?? DateTime.now(),
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      },
      child: DecoratedDateBox(
        date: date,
        label: label,
      ),
    );
  }
}

class DecoratedDateBox extends StatelessWidget {
  final String label;
  final DateTime? date;

  const DecoratedDateBox({
    super.key,
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = date != null ? DateFormat("dd.MM.yyyy").format(date!) : label;

    return SizedBox(
      height: 37.h,
      width: 122.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xff2A2A2D),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayText,
                  style: context.textTheme.displaySmall?.copyWith(color: AppColors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              12.horizontalSpace,
              const Icon(Icons.calendar_month, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}