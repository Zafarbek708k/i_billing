part of 'saved_bloc.dart';

enum SavedStatus { init, loading, loaded, error }

@immutable
class SavedState {
  final String? errorMsg;
  final SavedStatus status;
  final List<Contract>? savedContract;

  const SavedState({required this.status, this.errorMsg, this.savedContract});

  static SavedState init() => const SavedState(status: SavedStatus.init);

  SavedState copyWith({
    required SavedStatus status,
    String? errorMsg,
    List<Contract>? savedContract,
  }) =>
      SavedState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        savedContract: savedContract ?? this.savedContract,
      );
}
