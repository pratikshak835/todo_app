import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_event.dart';
import 'package:todo_flutter_app/todo/bloc/todo_state.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';
import 'package:todo_flutter_app/todo/toso_status/todo_status_state.dart';
import 'package:todo_flutter_app/todo/toso_status/toso_status_bloc.dart';
import 'package:todo_flutter_app/todo/views/add_todo_screen.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: To Dos'),
        actions: [
          IconButton(
            color: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodosStatusBloc, TodosStatusState>(
        builder: (context, state) {
          if (state is TodosStatusLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodosStatusLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _todo(
                    state.pendingTodos,
                    'Pending',
                  ),
                  _todo(
                    state.completedTodos,
                    'Completed',
                  ),
                ],
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }

  Column _todo(List<Todo> todos, String status) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Text(
                '$status To Dos: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return _todosCard(
              context,
              todos[index],
            );
          },
        ),
      ],
    );
  }

  Card _todosCard(
    BuildContext context,
    Todo todo,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<TodosBloc>().add(
                              UpdateTodo(
                                todo: todo.copyWith(isCompleted: true),
                              ),
                            );
                      },
                      icon: const Icon(Icons.add_task),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<TodosBloc>().add(
                              DeleteTodo(
                                todo: todo.copyWith(isCancelled: true),
                              ),
                            );
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
