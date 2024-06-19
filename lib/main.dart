import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_bloc.dart';
import 'package:todo_flutter_app/todo/bloc/todo_event.dart';
import 'package:todo_flutter_app/todo/model/todo_model.dart';
import 'package:todo_flutter_app/todo/toso_status/todo_status_event.dart';
import 'package:todo_flutter_app/todo/toso_status/toso_status_bloc.dart';
import 'package:todo_flutter_app/todo/views/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //   const MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   home: App(),
        // );

        MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodos(
                todos: [
                  Todo(
                    id: '1',
                    task: 'BloC Pattern Video',
                    description: 'Explain what is the BloC Pattern',
                  ),
                  Todo(
                    id: '2',
                    task: 'BloC Pattern Video #2',
                    description: 'Explain what is the BloC Pattern',
                  ),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodosStatusBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          )..add(const UpdateTodosStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'BloC Pattern - Todos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
