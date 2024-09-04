part of 'page_bloc.dart';

@immutable
sealed class PageState {}

final class PageChangeState extends PageState {
  int currentPage;
  PageChangeState(this.currentPage);
}
