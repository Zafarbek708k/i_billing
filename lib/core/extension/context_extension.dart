
import 'package:flutter/material.dart';

import '../common/app_styles.dart';

extension CustomContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => const AppTextStyle();
  // AppLocalizations get localized => AppLocalizations.of(this)!;
}
