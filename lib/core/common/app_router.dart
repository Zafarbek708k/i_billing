import 'package:flutter/material.dart';
import 'package:i_billing/core/common/app_route_name.dart';
import 'package:i_billing/feature/contracts/presentation/pages/contract_screen.dart';
import 'package:i_billing/feature/contracts/presentation/pages/filter.dart';
import 'package:i_billing/feature/contracts/presentation/pages/search.dart';
import 'package:i_billing/feature/history/presentation/pages/history_screen.dart';
import 'package:i_billing/feature/main_wrap.dart';
import 'package:i_billing/feature/new/presentation/pages/new_contract_screen.dart';
import 'package:i_billing/feature/profile/presentation/pages/profile_screen.dart';
import 'package:i_billing/feature/saved/presentation/pages/saved_screen.dart';
import 'package:i_billing/feature/splash/presentation/pages/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class AppRouter {
  AppRouter._();

  static final Map<String, WidgetBuilder> router = {
    AppRouteName.initial: (context) => const SplashScreen(),
    AppRouteName.mainWrap: (context) => const MainWrap(),
    AppRouteName.contract: (context) => const ContractScreen(),
    AppRouteName.history: (context) => const HistoryScreen(),
    AppRouteName.addNew: (context) => const NewContractScreen(),
    AppRouteName.saved: (context) => const SavedScreen(),
    AppRouteName.profile: (context) => const ProfileScreen(),
    AppRouteName.search: (context) => const Search(),
    AppRouteName.filter: (context) => const Filter(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.mainWrap:
        return MaterialPageRoute(
          builder: (context) => const MainWrap(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }

}


