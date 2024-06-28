import 'package:dummy_project/domain/notes/notes_notifier.dart';
import 'package:dummy_project/model/notes/notes.dart';
import 'package:dummy_project/presentation/home/widgets/dialog_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNotes extends ConsumerStatefulWidget {
  const AddNotes({
    super.key,
    this.notes,
    this.isForEdit = false,
    this.saveText,
  });
  final Notes? notes;
  final bool isForEdit;
  final String? saveText;

  @override
  ConsumerState<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends ConsumerState<AddNotes> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _titleController = TextEditingController(
      text: widget.notes?.title,
    );
    _contentController = TextEditingController(
      text: widget.notes?.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogHeight = MediaQuery.of(context).size.height * 0.5;
    final dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final notesNotifier = ref.read(notesProvider.notifier);

    return SizedBox(
      height: dialogHeight,
      width: dialogWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DialogTextField(controller: _titleController, hintText: 'Title'),
          DialogTextField(controller: _contentController, hintText: 'Content'),
          ElevatedButton(
              onPressed: widget.isForEdit
                  ? () {
                      notesNotifier.editNote(widget.notes?.id ?? 0,
                          title: _titleController.text,
                          content: _contentController.text);
                    }
                  : () {
                      notesNotifier.addNote(
                          _titleController.text, _contentController.text);

                      Navigator.of(context).pop();
                    },
              child: Text(widget.saveText ?? 'Add to notes'))
        ],
      ),
    );
  }
}
