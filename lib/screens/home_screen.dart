import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_bloc.dart';
import 'package:noteapp/screens/add_note_screen.dart';
import 'package:noteapp/screens/widgets/note_widegt.dart';
import 'package:noteapp/ui_change_bloc/ui_change_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(GetallNotesEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 19, 19),
        title: const Center(
          child: Text(
            "storys",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          BlocBuilder<UiChangeBloc, UiChangeState>(
            builder: (context, state) {
              final uiState = state is UiChangeInitial ? state.uiState : false;
              return IconButton(
                onPressed: () {
                  
                  context.read<UiChangeBloc>().add(UiChangeButtonEvent());
                },
                icon: Icon(uiState ? Icons.grid_4x4 : Icons.grid_3x3,color: Colors.white,),
              );
              
            },
          ),
         
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ScuccessState) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text(
                  'No notes available.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return NoteWidget(notesList: state.notes);
            }
          }
          if (state is ErrorState) {
            return const Center(
              child: Text(
                'Error loading notes. Please try again later.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
