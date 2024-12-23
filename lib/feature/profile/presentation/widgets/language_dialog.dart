


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/core/common/app_colors.dart';
import 'package:i_billing/core/widgets/main_button.dart';
import 'package:i_billing/feature/profile/presentation/bloc/profile_bloc.dart';

import 'custom_radio_button.dart';

class LangSelect extends StatefulWidget {
  const LangSelect({
    super.key,
    required this.locale,
  });

  final String locale;

  @override
  State<LangSelect> createState() => _LangSelectState();
}

class _LangSelectState extends State<LangSelect> {
  bool uz = false, ru = false, en = false;

  void select(String locale) {
    setState(
          () => locale == "uz"
          ? (uz = true, ru = false, en = false)
          : locale == "ru"
          ? (ru = true, uz = false, en = false)
          : (en = true, ru = false, uz = false),
    );
  }

  @override
  void initState() {
    select(widget.locale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff2A2A2D),
      title: const Align(alignment: Alignment.center, child: Text("Select Language", style: TextStyle(color: AppColors.white))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/uz.svg"),
              const Text("Uz", style: TextStyle(color: AppColors.white)),
              const Spacer(),
              CustomRadioButton(
                  selected: uz,
                  onTap: () {
                    uz = true;
                    ru = false;
                    en = false;
                    setState(() {});
                  })
            ],
          ),
          Row(
            children: [
              SvgPicture.asset("assets/icons/ru.svg"),
              const Text("Ru", style: TextStyle(color: AppColors.white)),
              const Spacer(),
              CustomRadioButton(
                  selected: ru,
                  onTap: () {
                    ru = true;
                    uz = false;
                    en = false;
                    setState(() {});
                  })
            ],
          ),
          Row(
            children: [
              SvgPicture.asset("assets/icons/en.svg"),
              const Text("En", style: TextStyle(color: AppColors.white)),
              const Spacer(),
              CustomRadioButton(
                  selected: en,
                  onTap: () {
                    uz = false;
                    ru = false;
                    en = true;
                    setState(() {});
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                  onPressed: () => Navigator.pop(context),
                  title: "Cancel",
                  bcgC: const Color(0xff008F7F).withOpacity(0.5),
                  textC: const Color(0xff0008F7F).withOpacity(0.7),
                  select: true),
              MainButton(
                onPressed: () async {
                  if (uz) {
                    await context.read<ProfileBloc>().changeLocaleInProfile(context, "uz");
                  } else if (ru) {
                    await context.read<ProfileBloc>().changeLocaleInProfile(context, "ru");
                  } else {
                    await context.read<ProfileBloc>().changeLocaleInProfile(context, "en");
                  }
                  Navigator.pop(context);
                },
                title: "Done",
                bcgC: const Color(0xff008F7F),
                select: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
