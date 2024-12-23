import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/app.dart';
import 'package:i_billing/core/service/storage_service.dart';
import 'package:i_billing/core/setting/localization_cubit.dart';
import 'package:i_billing/feature/contracts/presentation/bloc/contract_bloc/contract_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) {});
    on<ChangeLocaleInProfile>((event, emit) {});
    getLanguage();
  }

  Future<void> changeLocaleInProfile(BuildContext context, String locale) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await AppStorage.$write(key: StorageKey.locale, value: locale);
    context.read<LocalizationCubit>().changeLocale(_getLocaleFromCode(locale), context);
    emit(state.copyWith(status: ProfileStatus.loaded, locale: locale));
  }

  Future<void> getLanguage()async{
    emit(state.copyWith(status: ProfileStatus.loading));
    String? result = await AppStorage.$read(key: StorageKey.locale);
    if(result != null){
      log("profile loaded locale $result");
      emit(state.copyWith(status: ProfileStatus.loaded, locale: result));
    }else{
      log("profile error");
      emit(state.copyWith(status: ProfileStatus.error, errorMsg: "Locale is not find"));
    }
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
