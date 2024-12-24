import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/common/app_router.dart';
import 'package:i_billing/feature/contracts/presentation/pages/contract_screen.dart';
import 'package:i_billing/feature/contracts/presentation/pages/filter.dart';
import 'package:i_billing/feature/contracts/presentation/pages/search.dart';
import 'package:i_billing/feature/history/presentation/pages/history_screen.dart';
import 'package:i_billing/feature/new/presentation/pages/new_contract_screen.dart';
import 'package:i_billing/feature/profile/presentation/pages/profile_screen.dart';
import 'package:i_billing/feature/saved/presentation/pages/saved_screen.dart';

class MainWrap extends StatefulWidget {
  const MainWrap({super.key});

  @override
  State<MainWrap> createState() => _MainWrapState();
}

class _MainWrapState extends State<MainWrap> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ContractScreen(),
    // Navigator(
    //   onGenerateRoute: (routeSettings) => MaterialPageRoute(
    //     builder: (context) => const ContractScreen(),
    //   ),
    // ),
    Navigator(
      // key: historyKey,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) {
          return const HistoryScreen();
        },
      ),
    ),
    Navigator(
      // key: createKey,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) {
          return const NewContractScreen();
        },
      ),
    ),
    Navigator(
      // key: saveKey,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) {
          return const SavedScreen();
        },
      ),
    ),
    Navigator(
      // key: profileKey,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) {
          return const ProfileScreen();
        },
      ),
    ),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      log(_currentIndex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          backgroundColor: AppColors.darker,
          type: BottomNavigationBarType.fixed,
          onTap: _onTabTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          selectedLabelStyle: const TextStyle(color: Colors.yellow),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          unselectedFontSize: 12,
          selectedFontSize: 14,
          selectedItemColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0 ? SvgPicture.asset("assets/icons/bold_contract.svg") : SvgPicture.asset("assets/icons/outline_contract.svg"),
              label: "contract".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1 ? SvgPicture.asset("assets/icons/bold_history.svg") : SvgPicture.asset("assets/icons/outline_history.svg"),
              label: "history".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2 ? SvgPicture.asset("assets/icons/bold_plus.svg") : SvgPicture.asset("assets/icons/outline_plus.svg"),
              label: "addNew".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3 ? SvgPicture.asset("assets/icons/bold_save.svg") : SvgPicture.asset("assets/icons/outline_save.svg"),
              label: "saved".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 4 ? SvgPicture.asset("assets/icons/bold_profile.svg") : SvgPicture.asset("assets/icons/outline_profile.svg"),
              label: "profile".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
