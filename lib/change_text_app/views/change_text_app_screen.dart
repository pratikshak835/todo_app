import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/change_text_app/bloc/change_text_bloc.dart';
import 'package:todo_flutter_app/change_text_app/bloc/change_text_event.dart';
import 'package:todo_flutter_app/change_text_app/bloc/change_text_states.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBlocBloc(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Text Change'),
          ),
          body: BlocConsumer<AppBlocBloc, AppState>(
            listener: (context, state) {
              // Handle side effects here
            },
            builder: (context, state) {
              return TextChangeController(
                text: state.text,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TextChangeController extends StatelessWidget {
  final String text;

  const TextChangeController({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            text,
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () =>
                context.read<AppBlocBloc>().add(const ChangeTextEvent()),
            child: const Text('Change Text'),
          ),
        ] // ElevatedButton
            ),
      ),
    ); // [ ]
  }
}

//test
// void main() {
//   blocTest(
//     'Initial State',
//     build: () => AppBlocBloc(),
//     verify: (appState) =>
//         expect(appState.state, const AppState.empty(), reason: 'Initial State'),
//   );
//   blocTest(
//     'emits [MyState] when MyEvent is added.',
//     build: () => AppBlocBloc(),
//     act: (bloc) => bloc.add(const ChangeTextEvent()),
//     expect: () => const [
//       AppState(
//         index: 1,
//         text: 'Changed Text',
//       ),
//     ],
//   );
// }
