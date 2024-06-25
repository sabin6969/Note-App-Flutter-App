import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note.bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_state.dart';
import 'package:note_app_flutter_mobile_app/constants/app_constant.dart';
import 'package:note_app_flutter_mobile_app/views/drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<NoteBloc>().add(LoadNoteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Note App"),
      ),
      drawer: const ProfileDrawer(),
      body: BlocConsumer<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoadingState) {
            return Center(
              child: Lottie.asset(AppConstant.loadingAnimationPath),
            );
          } else if (state is NoteLoadedState) {
            return state.notes.isEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      context.read<NoteBloc>().add(LoadNoteEvent());
                    },
                    child: ListView(
                      children: [
                        Lottie.asset(
                          AppConstant.emptyListAnimationPath,
                        ),
                        const Text(
                          "Looks like you have't added any notes yet!",
                        ),
                        const Text(
                          "Try adding some!",
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      context.read<NoteBloc>().add(LoadNoteEvent());
                    },
                    child: ListView.builder(
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.notes[index].noteTitle ?? ""),
                          subtitle:
                              Text(state.notes[index].noteDescription ?? ""),
                        );
                      },
                    ),
                  );
          }
          return const Center(
            child: Text("Something went wrong!"),
          );
        },
        listener: (context, state) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
