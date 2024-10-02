import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageChangeState(0)) {
    on<PageChangeEvent>(onPageChangeEvent);
    on<PageSkipEvent>(onPageSkipEvent);
    on<PageNextEvent>(onPageNextEvent);
    on<PagePrevEvent>(onPagePrevEvent);
  }

  FutureOr<void> onPageChangeEvent(
      PageChangeEvent event, Emitter<PageState> emit) {
    emit(PageChangeState(event.pageIndex));
  }

  FutureOr<void> onPageSkipEvent(PageSkipEvent event, Emitter<PageState> emit) {
    if (state is PageChangeState) {
      emit(PageChangeState(2));
    }
  }

  FutureOr<void> onPageNextEvent(PageNextEvent event, Emitter<PageState> emit) {
    if (state is PageChangeState) {
      final currentIndex = (state as PageChangeState).currentPage;
      emit(PageChangeState(currentIndex + 1));
    }
  }

  FutureOr<void> onPagePrevEvent(PagePrevEvent event, Emitter<PageState> emit) {
    if (state is PageChangeState) {
      final currentIndex = (state as PageChangeState).currentPage;
      emit(PageChangeState(currentIndex - 1));
    }
  }
}
