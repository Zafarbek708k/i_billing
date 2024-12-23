import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/core/widgets/main_button.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/check_box_custom.dart';

import '../../../../core/common/app_colors.dart';
import '../widgets/data_select.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class A {
  final String id;
  final String name;
  final String dateTime;

  A({required this.id, required this.name, required this.dateTime});
}

class _FilterState extends State<Filter> {
  bool paid = false, inProcess = false, rejectByIQ = false, rejectByPayme = false;
  final List<A> items = List.generate(50, (index) => A(id: "$index", name: "Name $index", dateTime: "2024, ${index + 1} Fevral"));

  List<A> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = items.where((item) {
        final searchLower = query.toLowerCase();
        return item.id.contains(searchLower) || item.name.toLowerCase().contains(searchLower) || item.dateTime.toLowerCase().contains(searchLower);
      }).toList();
    });
  }

  DateTime selectedDate = DateTime.now();

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
        child: ListView(
          children: [
            Text("Status", style: context.textTheme.displayLarge?.copyWith(color: Colors.grey)),
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
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
            MainButton(onPressed: () {}, title: "Apply Filters", bcgC: const Color(0xff008F7F), select: true, height: 35, minWith: 125),
          ],
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
