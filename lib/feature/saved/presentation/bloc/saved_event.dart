part of 'saved_bloc.dart';

@immutable
sealed class SavedEvent {}

class GetAllSavedDataEvent extends SavedEvent{}