import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note.bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_state.dart';
import 'package:note_app_flutter_mobile_app/main.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Note",
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("Done");
              context.read<NoteBloc>().add(
                    AddNoteEvent(
                      noteDescription: _noteDescriptionController.text,
                      noteTitle: _noteTitleController.text,
                    ),
                  );
            },
            icon: const Icon(
              Icons.save,
            ),
          )
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteLoadingState) {
            // showLoadingDialog(context: context);
          } else if (state is NoteFailedState) {
            GoRouter.of(context).pop(); // removing loading progress indicator
            showToastMessage(message: state.message);
          } else if (state is NoteSucessState) {
            showToastMessage(message: state.message);
            Navigator.pop(context); // Navigating user to home page
          } else if (state is NoteValidationFailedState) {
            showToastMessage(message: state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.025,
            ),
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _noteTitleController,
                    decoration: const InputDecoration(
                      hintText: "Note Title",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    controller: _noteDescriptionController,
                    maxLines: null,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Note Description",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
