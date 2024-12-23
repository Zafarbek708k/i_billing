part of 'profile_bloc.dart';

enum ProfileStatus{initial, loading, loaded, error}

@immutable
class ProfileState {
  final ProfileStatus status;
  final String? locale;
  final String? errorMsg;
  const ProfileState({required this.status, this.locale, this.errorMsg});

  static ProfileState initial()=> const ProfileState(status: ProfileStatus.initial);

  ProfileState copyWith({
    ProfileStatus? status,
    String? locale,
    String? errorMsg
})=> ProfileState(
    status: status ?? this.status,
    locale: locale?? this.locale,
    errorMsg: errorMsg?? this.errorMsg
  );

}

