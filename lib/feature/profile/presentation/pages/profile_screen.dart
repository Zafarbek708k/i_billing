import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:i_billing/feature/profile/presentation/widgets/lang_ui.dart';
import 'package:i_billing/feature/profile/presentation/widgets/language_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().getLanguage();
    return Scaffold(
      backgroundColor: AppColors.darkest,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.darkest,
        leading: const Padding(padding: EdgeInsets.only(left: 18.0), child: CircleAvatar(radius: 10)),
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.dark),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          CircleAvatar(backgroundColor: AppColors.primary, child: Icon(Icons.person)),
                          SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Otabek Abdusamatov", style: TextStyle(color: AppColors.primary)),
                              Text("Graphic Designer IQ Education", style: TextStyle(color: Color(0xff999999))),
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text("Date of birth: ", style: TextStyle(color: Color(0xffE7E7E7))),
                          Text("16.09.2001", style: TextStyle(color: Color(0xff999999)))
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text("Phone number ", style: TextStyle(color: Color(0xffE7E7E7))),
                          Text("+998 97 625 29 79", style: TextStyle(color: Color(0xff999999)))
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text("E-mail ", style: TextStyle(color: Color(0xffE7E7E7))),
                          Text("predatorhunter041@gmail.com", style: TextStyle(color: Color(0xff999999)))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                log("state status => ${state.status}");
                if (state.status == ProfileStatus.initial) {
                  return MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LangSelect(locale: state.locale!);
                        },
                      );
                    },
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.dark,
                    child: const LangUi(locale: "uz"),
                  );
                }
                if (state.status == ProfileStatus.loaded) {
                  return MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LangSelect(locale: state.locale!);
                        },
                      );
                    },
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.dark,
                    child: LangUi(locale: state.locale!),
                  );
                }
                if (ProfileStatus.loading == state.status) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == ProfileStatus.error) {
                  return Center(child: Text("Error ${state.errorMsg}", style: const TextStyle(color: Colors.red)));
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
