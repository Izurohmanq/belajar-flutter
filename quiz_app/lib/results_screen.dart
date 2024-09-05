import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chooseAnswer, required this.onRestart});

  final void Function() onRestart;
  final List<String> chooseAnswer;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chooseAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct': questions[i].answers[0],
        'user_answer': chooseAnswer[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestion = questions.length;
    final numCorrectQuestion = summaryData.where((data) {
      return data['user_answer'] == data['correct'];
    }).length;

    return SizedBox(
      width: double
          .infinity, // gunakan lebar dari size tersebut yang anda bisa gunakan selebar mungkin
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' Yang bener cuman $numCorrectQuestion dari $numTotalQuestion',
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 17, 17)),
            ),
            const SizedBox(height: 30),
            QuestionSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
                onPressed: onRestart,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 3,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                  padding: const EdgeInsets.all(15),
                ),
                label: const Text('Restart Quiznya bege',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
