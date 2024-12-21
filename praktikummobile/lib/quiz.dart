import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'question_screen.dart';
import 'result_screen.dart';
import 'datas/question.dart';
import 'profile.dart'; // Tambahkan jika Anda memiliki layar profil

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen'; // Menyimpan status layar aktif
  final List<String> selectedAnswer = []; // Menyimpan jawaban yang dipilih

  // Fungsi untuk memilih jawaban
  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen'; // Pindah ke layar hasil jika sudah menjawab semua soal
      });
    }
  }

  // Fungsi untuk berpindah layar ke soal
  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen'; // Pindah ke layar soal
    });
  }

  // Fungsi untuk me-restart kuis
  void restartQuiz() {
    setState(() {
      selectedAnswer.clear(); // Menghapus jawaban yang dipilih
      activeScreen = 'start-screen'; // Kembali ke layar awal
    });
  }

  // Fungsi untuk berpindah ke layar profil
  void profileScreen() {
    setState(() {
      selectedAnswer.clear(); // Menghapus jawaban yang dipilih (opsional)
      activeScreen = 'profile-screen'; // Pindah ke layar profil
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomeScreen(switchScreen, profileScreen); // Layar awal dengan tombol mulai dan profil

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectedAnswer: chooseAnswer, // Kirim fungsi chooseAnswer ke QuestionScreen
      );
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        chooseAnswer: selectedAnswer, // Kirim jawaban yang dipilih ke ResultScreen
        onRestart: restartQuiz, // Kirim fungsi restartQuiz untuk mengulang kuis
      );
    }

    if (activeScreen == 'profile-screen') {
      screenWidget = const Profile(); // Tampilkan layar profil
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: screenWidget, // Tampilkan layar sesuai status aktif
      ),
    );
  }
}
