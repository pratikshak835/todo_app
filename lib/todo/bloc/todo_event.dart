import 'package:equatable/equatable.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {
  final List<Todo> todos;

  const LoadTodos({
    this.todos = const <Todo>[],
  });

  @override
  List<Object> get props => [todos];
}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}
