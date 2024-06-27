import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note.bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_state.dart';
import 'package:note_app_flutter_mobile_app/constants/app_constant.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/utils/show_info_dialog.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';
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
        centerTitle: false,
        title: const Text(
          "Notes",
        ),
        actions: [
          IconButton(
            onPressed: () {
              showInfoDialog(context: context);
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
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
                        Image.asset(AppConstant.noteImagePath),
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                          child: Text(
                            "Looks like you have't added any notes yet!",
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Try adding some!",
                          ),
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
                          trailing: IconButton(
                            onPressed: () {
                              context.read<NoteBloc>().add(
                                    DeleteNoteEvent(
                                      noteId: state.notes[index].id ?? "",
                                    ),
                                  );
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        );
                      },
                    ),
                  );
          } else if (state is NoteLoadingFailedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(state.errorMessage),
                ),
                TextButton(
                  onPressed: () {
                    context.read<NoteBloc>().add(LoadNoteEvent());
                  },
                  child: const Text(
                    "Try Again",
                  ),
                )
              ],
            );
          } else if (state is NoteFailedState) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: Text("Something went wrong!"),
          );
        },
        listener: (context, state) {
          if (state is NoteSucessState) {
            showToastMessage(message: state.message);
          } else if (state is NoteFailedState) {
            showToastMessage(message: state.message);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(
            AppRouteNames.addNote,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
