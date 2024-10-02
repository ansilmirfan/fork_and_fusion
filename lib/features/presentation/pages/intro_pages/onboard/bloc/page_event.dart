part of 'page_bloc.dart';

@immutable
sealed class PageEvent {}

class PageChangeEvent extends PageEvent {
  int pageIndex;
  PageChangeEvent(this.pageIndex);
}

class PageSkipEvent extends PageEvent {}

class PageNextEvent extends PageEvent {}

class PagePrevEvent extends PageEvent {}
