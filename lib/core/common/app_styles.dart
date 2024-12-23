
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

@immutable
class AppTextStyle extends TextTheme {
  const AppTextStyle();



  @override
  TextStyle? get displayLarge => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.size20,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get displayMedium => TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: FontSize.size14,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get displaySmall => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.size14,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get headlineMedium => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.size18,
    fontFamily: "Ubuntu",
    color: Colors.white,
  );

  @override
  TextStyle? get headlineSmall => TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.size14,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get titleLarge => TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.size14,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get titleMedium => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.size12,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get titleSmall => TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.size16,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get bodyLarge => TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.size18,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get bodyMedium => TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: FontSize.size11,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get bodySmall => TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.size11,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get labelLarge => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.size15,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );

  @override
  TextStyle? get labelSmall => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSize.size10,
    fontFamily: "Ubuntu",
    color: Colors.black,
  );
}

@immutable
class FontSize {
  const FontSize._();

  static double size7 = 7.sp;
  static double size8 = 8.sp;
  static double size10 = 10.sp;
  static double size11 = 11.sp;
  static double size12 = 12.sp;
  static double size14 = 14.sp;
  static double size15 = 15.sp;
  static double size16 = 16.sp;
  static double size18 = 18.sp;
  static double size20 = 20.sp;
  static double size24 = 24.sp;
  static double size30 = 30.sp;
  static double size34 = 34.sp;
  static double size48 = 48.sp;
  static double size60 = 60.sp;
  static double size96 = 96.sp;
}
