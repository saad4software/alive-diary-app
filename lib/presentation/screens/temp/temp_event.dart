part of 'temp_bloc.dart';

@immutable
sealed class TempEvent {}

class TempListEvent extends TempEvent {}
class TempRefreshEvent extends TempEvent {}


