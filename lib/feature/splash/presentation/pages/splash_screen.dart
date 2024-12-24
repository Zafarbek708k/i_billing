import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/common/app_route_name.dart';
import 'package:i_billing/feature/main_wrap.dart';
import 'package:i_billing/feature/splash/presentation/widgets/custom_fade_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goNextPage() {
    Timer(const Duration(seconds: 3), () {
      log("message");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainWrap()));
    });
  }

  @override
  void initState() {
    goNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darker,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              CustomFadeAnimation(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Image.asset("assets/images/logo.png"),
              )),
              const Spacer(flex: 1)
              // SizedBox(
              //   height: 120,
              //   width: double.infinity,
              //   child: Center(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Text("hello".tr(), style:const  TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 20)),
              //         Text("rejectByPayme".tr(), style:const  TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 20)),
              //       ],
              //     ),
              //   ),
              // ),
              // MainButton(
              //   onPressed: () async {
              //     await context.read<LocalizationCubit>().changeLocale(const Locale("uz"), context);
              //   },
              //   title: "Uz",
              //   bcgC: Colors.green,
              //   select: true,
              // ),
              // MainButton(
              //   onPressed: () async {
              //     await context.read<LocalizationCubit>().changeLocale(const Locale("ru"), context);
              //   },
              //   title: "Ru",
              //   bcgC: Colors.green,
              //   select: true,
              // ),
              // MainButton(
              //   onPressed: () async {
              //     await context.read<LocalizationCubit>().changeLocale(const Locale("en"), context);
              //   },
              //   title: "En",
              //   bcgC: Colors.green,
              //   select: true,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
