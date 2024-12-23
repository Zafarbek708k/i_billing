part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ChangeLocaleInProfile extends ProfileEvent{
  final String locale;
  ChangeLocaleInProfile(this.locale);
}
