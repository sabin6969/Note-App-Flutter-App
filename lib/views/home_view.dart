import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note.bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_state.dart';
import 'package:note_app_flutter_mobile_app/constants/app_constant.dart';
import 'package:note_app_flutter_mobile_app/main.dart';
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
    size = MediaQuery.sizeOf(context);
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
          if (state is NoteLoadingState || state is NoteValidationFailedState) {
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
                    child: displayNotes(state),
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

  GridView displayNotes(NoteLoadedState state) {
    return GridView.builder(
      itemCount: state.notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 8,
            top: 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        context.read<NoteBloc>().add(
                              DeleteNoteEvent(
                                noteId: state.notes[index].id ?? "",
                              ),
                            );
                      },
                      icon: const Icon(
                        Icons.delete,
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        AppRouteNames.updateNote,
                        pathParameters: {
                          "noteId": state.notes[index].id!,
                          "noteTitle": state.notes[index].noteTitle!,
                          "noteDescription":
                              state.notes[index].noteDescription!,
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          state.notes[index].noteTitle ?? "",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            state.notes[index].noteDescription ?? "",
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
