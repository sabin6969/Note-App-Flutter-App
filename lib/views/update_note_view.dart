import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note.bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_state.dart';
import 'package:note_app_flutter_mobile_app/main.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';

class UpdateNoteView extends StatefulWidget {
  final String noteId;
  final String noteTitle;
  final String noteDescription;
  const UpdateNoteView({
    super.key,
    required this.noteId,
    required this.noteTitle,
    required this.noteDescription,
  });

  @override
  State<UpdateNoteView> createState() => _UpdateNoteViewState();
}

class _UpdateNoteViewState extends State<UpdateNoteView> {
  @override
  void initState() {
    super.initState();
    _noteTitleController.text = widget.noteTitle;
    _noteDescriptionController.text = widget.noteDescription;
  }

  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NoteBloc>().add(
                    UpdateNoteEvent(
                      noteDescription: _noteDescriptionController.text,
                      noteId: widget.noteId,
                      noteTitle: _noteTitleController.text,
                    ),
                  );
            },
            icon: const Icon(
              Icons.update,
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
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(
                      fontSize: 16,
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
                      fontSize: 16,
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
