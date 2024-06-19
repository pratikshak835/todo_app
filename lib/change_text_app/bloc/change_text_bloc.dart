import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/change_text_app/bloc/change_text_event.dart';
import 'package:todo_flutter_app/change_text_app/bloc/change_text_states.dart';

class AppBlocBloc extends Bloc<AppBlocEvent, AppState> {
  final List textList = [
    'Initial Text',
    'Changed Text',
    'Changed Again',
  ];
  AppBlocBloc() : super(const AppState.empty()) {
    on((event, emit) {
      try {
        int newIndex = state.index + 1;
        if (newIndex >= textList.length) {
          newIndex = 0;
        }
        emit(
          AppState(
            index: newIndex,
            text: textList[newIndex],
          ),
        );
      } on Exception catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
  }
}
