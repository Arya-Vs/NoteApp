import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/theme/colors.dart';
import 'package:noteapp/screens/view_note_screen.dart';
import 'package:noteapp/screens/widgets/delete_pop_up_widget.dart';
import 'package:noteapp/ui_change_bloc/ui_change_bloc.dart';

class NoteWidget extends StatelessWidget {
  final List notesList;

  const NoteWidget({super.key, required this.notesList});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UiChangeBloc, UiChangeState>(
      builder: (context, state) {
        final uiState = state is UiChangeInitial ? state.uiState : false;
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: notesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: uiState ? 1.5 : 3.0,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.white,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewNoteScreen(
                    note: notesList[index],
                  ),
                ),
              ),
              child: note(
                note: notesList[index],
                context: context,
                onDelete: () {
                 
                  showDialog(
                    context: context,
                    builder: (context) => DeletePopUpWidget(
                      note: notesList[index],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

Widget note({
  required Map note,
  required BuildContext context,
  VoidCallback? onDelete,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: colors[note["id"] % colors.length],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              note["title"] ?? "null",
              style: const TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete, 
              color: Colors.red,
            ),
          ],
        ),
        Expanded(
          child: Text(
            note["content"] ?? "null",
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
  );
}
