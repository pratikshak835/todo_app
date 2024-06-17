import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_event.dart';
import 'package:todo_flutter_app/todo/bloc/todo_state.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: Add a To Do'),
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodosLoaded) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _inputField('ID', controllerId),
                    _inputField('Task', controllerTask),
                    _inputField('Description', controllerDescription),
                    ElevatedButton(
                      onPressed: () {
                        var todo = Todo(
                          id: controllerId.value.text,
                          task: controllerTask.value.text,
                          description: controllerDescription.value.text,
                        );
                        context.read<TodosBloc>().add(AddTodo(todo: todo));
                        Navigator.pop(context);
                      },
                      // style: ElevatedButton.styleFrom(
                      //   // primary: Theme.of(context).primaryColor,
                      // ),
                      child: const Text('Add To Do'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }

  Column _inputField(
    String field,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
