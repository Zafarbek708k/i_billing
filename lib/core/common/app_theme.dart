import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:i_billing/core/common/app_styles.dart";

import "color_schema.dart";

@immutable
final class AppThemes {
  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData lightTheme;
  final BuildContext context;

  AppThemes(this.context, {required this.mode})
      : darkTheme = ThemeData(
          brightness: Brightness.dark,
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
          textTheme: const AppTextStyle(),
        ),
        lightTheme = ThemeData(
            brightness: Brightness.light, colorScheme: lightColorScheme, scaffoldBackgroundColor: Colors.white, textTheme: const AppTextStyle());

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: Colors.white,
      );

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: Colors.black,
      );

  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }
}
