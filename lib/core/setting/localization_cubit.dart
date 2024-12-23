import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:i_billing/core/service/storage_service.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(const Locale('uz')){
   log("localization cubit constructor");
  }

  Future<void> loadLocale(BuildContext context) async {
    final savedLocale = await AppStorage.$read(key: StorageKey.locale);
    if (savedLocale != null) {
      final locale = _getLocaleFromCode(savedLocale);
      log("load locale = $locale");
      emit(locale);
      context.setLocale(locale);
    }
  }

  Future<void> changeLocale(Locale locale, BuildContext context) async {
    log("$locale");
    emit(locale);
    context.setLocale(locale);
    await AppStorage.$write(key: StorageKey.locale, value: locale.languageCode);
    log("change locale = $locale");
  }

  Locale _getLocaleFromCode(String code) {
    switch (code) {
      case "ru":
        return const Locale("ru");
      case "en":
        return const Locale("en");
      default:
        return const Locale("uz");
    }
  }
}
