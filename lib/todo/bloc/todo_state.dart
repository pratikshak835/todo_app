import 'package:equatable/equatable.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  const TodosLoaded({
    this.todos = const <Todo>[],
  });

  @override
  List<Object> get props => [todos];
}

class TodosError extends TodosState {}
