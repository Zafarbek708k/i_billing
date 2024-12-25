import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/core/extension/context_extension.dart';
import 'package:i_billing/feature/contracts/presentation/pages/contract_detail.dart';
import 'package:i_billing/feature/contracts/presentation/widgets/contract_widget.dart';

import '../../data/model/full_contract_model.dart';
import '../bloc/contract_bloc/contract_bloc.dart';

class PaginationExample extends StatefulWidget {
  final List<Contract> contractList;

  const PaginationExample({required this.contractList, super.key});

  @override
  PaginationExampleState createState() => PaginationExampleState();
}

class PaginationExampleState extends State<PaginationExample> {
  late List<Contract> items;
  List<Contract> displayedItems = [];
  final ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  final int itemsPerPage = 3;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    items = widget.contractList;

    _loadMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() {
    if (isLoading) return;

    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;

    if (startIndex < items.length) {
      setState(() => isLoading = true);

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          displayedItems.addAll(
            items.sublist(startIndex, endIndex > items.length ? items.length : endIndex),
          );
          currentPage++;
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_loadMoreData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: displayedItems.isEmpty && !isLoading
            ? const Center(
                child: Text(
                  "No items available",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<ContractBloc>().add(GetAllContractEvent());
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: displayedItems.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < displayedItems.length) {
                      return ContractWidget(
                        model: displayedItems[index],
                        onTap: () {
                          context.read<ContractBloc>().add(AuthorContractsEvent(authorName: displayedItems[index].author ?? "Ali Valiyev"));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContractDetail(model: displayedItems[index])));
                        },
                      );
                    } else {
                      return  Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Load more item...", style: context.textTheme.bodyMedium?.copyWith(color: Colors.green)),
                        ),
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}
