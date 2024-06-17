import 'package:equatable/equatable.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';

abstract class TodosStatusEvent extends Equatable {
  const TodosStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateTodosStatus extends TodosStatusEvent {
  final List<Todo> todos;

  const UpdateTodosStatus({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
