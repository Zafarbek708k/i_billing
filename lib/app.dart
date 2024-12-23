import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/common/app_route_name.dart';
import 'package:i_billing/core/common/app_router.dart';
import 'package:i_billing/core/setting/localization_cubit.dart';
import 'package:i_billing/feature/contracts/presentation/bloc/contract_bloc/contract_bloc.dart';
import 'package:i_billing/feature/history/presentation/bloc/history_bloc.dart';
import 'package:i_billing/feature/new/presentation/bloc/add_new_contract_bloc.dart';
import 'package:i_billing/feature/profile/presentation/bloc/profile_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  static void run() => runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LocalizationCubit()),
            BlocProvider(create: (_) => ContractBloc()),
            BlocProvider(create: (_) => ProfileBloc()),
            BlocProvider(create: (_) => AddNewContractBloc()),
            BlocProvider(create: (_) => HistoryBloc()),
          ],
          child: const App(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [  Locale('uz'),   Locale('en'),  Locale('ru')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) => BlocBuilder<LocalizationCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              title: "I Billing",
              routes: AppRouter.router,
              initialRoute: AppRouteName.initial,
              onGenerateRoute: AppRouter.onGenerateRoute,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.darkest,
                bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.darker),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
