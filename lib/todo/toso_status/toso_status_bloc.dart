import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_state.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';
import 'package:todo_flutter_app/todo/toso_status/todo_status_event.dart';
import 'package:todo_flutter_app/todo/toso_status/todo_status_state.dart';

class TodosStatusBloc extends Bloc<TodosStatusEvent, TodosStatusState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosStatusBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosStatusLoading()) {
    on<UpdateTodosStatus>(_onUpdateTodosStatus);

    _todosSubscription = _todosBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        add(
          UpdateTodosStatus(todos: state.todos),
        );
      }
    });
  }

  void _onUpdateTodosStatus(
    UpdateTodosStatus event,
    Emitter<TodosStatusState> emit,
  ) {
    List<Todo> pendingTodos = event.todos
        .where((todo) => todo.isCancelled == false && todo.isCompleted == false)
        .toList();
    List<Todo> completedTodos = event.todos
        .where((todo) => todo.isCompleted == true && todo.isCancelled == false)
        .toList();
    List<Todo> cancelledTodos =
        event.todos.where((todo) => todo.isCancelled == false).toList();

    emit(
      TodosStatusLoaded(
        pendingTodos: pendingTodos,
        completedTodos: completedTodos,
        cancelledTodos: cancelledTodos,
      ),
    );
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
