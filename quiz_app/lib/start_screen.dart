import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Image.asset(
              'assets/quiz-logo.png',
              width: 300,
              color: const Color.fromARGB(150, 255, 255, 255),
            ),
          // Opacity(
          //   opacity: 0.5,
          //   child: Image.asset('assets/quiz-logo.png',
          //   width: 300,
          //   ),
          // ),
          const SizedBox(
            height: 80,
          ),
          Text(
            'Pake Flutter Biar Gaji 2 Digit',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              side: const BorderSide( // outlined color
                width: 3,
                color: Colors.white,
                style: BorderStyle.solid,
              ),
              padding: const EdgeInsets.all(15),
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 120, 55, 231),
            ),
            icon: const Icon(Icons.arrow_right_alt), 
            label: const Text(  // kalau pake OutlinedButton.icon harus jadi pake label
              'Start Quiz',
              style: TextStyle(
                fontSize: 20,
              ),
              ),
          ),
        ],
      ),
    );
  }
}
