part of 'list_bloc.dart';

@immutable
sealed class ListEvent {}

class ListGetEvent extends ListEvent {}
class ListRefreshEvent extends ListEvent {}