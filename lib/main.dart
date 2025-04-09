import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_screen.dart'; // Memgimpor splashscreen

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // SplashScreen jadi layar pembuka
  ));
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.konkhmerSleokchherTextTheme(), // Set tema font
      ),
      home: QuizPage(),
    );
  }
}

// Abstraction
class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Encapsulation
  int currentQuestionIndex = 0;
  int totalQuestions = 12;
  int totalAnswered = 0;
  int score = 0;
  int _currentStreak = 0;
  int _badgeCount = 0;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'Mahasigma prodi kita berkuliah di Gedung K2',
      'answer': true,
    },
    {
      'question': 'Lulusan D4MI UNESA mendapat gelar Sarjana Komputer (S.Kom)',
      'answer': false,
    },
    {
      'question': 'D4 Manajemen Informatika ada di Fakultas Teknik',
      'answer': false,
    },
    {
      'question': 'Mahasigma Unesa masuk kembali pada 8 April 2025',
      'answer': true,
    },
    {
      'question': 'Python dan PHP adalah bahasa pemrograman, sedangkan CSS adalah bahasa untuk mendesain tampilan halaman web',
      'answer': true,
    },
    {
      'question': 'UI/UX Design tidak diajarkan di D4MI UNESA',
      'answer': false,
    },
    {
      'question': 'Matematika Diskrit tidak berkaitan dengan dunia komputer dan informatika',
      'answer': false,
    },
    {
      'question': 'Kekurangan belajar lewat YouTube karena tidak sesuai dengan kebutuhan dan bikin ngantuk',
      'answer': true,
    },
    {
      'question': 'Python menggunakan indentasi (spasi/tab) sebagai penanda blok kode, sementara PHP dan CSS menggunakan kurung kurawal {}',
      'answer': true,
    },
    {
      'question': 'Bahasa pemrograman adalah satu-satunya cara untuk menulis algoritma',
      'answer': false,
    },
    {
      'question': 'Semester 7 itu waktunya magang',
      'answer': false,
    },
    {
      'question': 'Mahasigma gak boleh chat dosen di luar jam kerja atau tidak sopan saat nge-chat',
      'answer': true,
    },
  ];

  // Menyimpan ikon jawaban (benar/salah)
  // Encapsulation
  List<Icon> answerFeedbackIcons = [];

  bool? _isAnswerCorrect;
  bool _hasAnswered = false;
  bool _userSelectedTrue = false;

  // Fungsi cek jawaban user
  // Encapsulation
  void checkAnswer(bool userAnswer) {
    if (_hasAnswered) return;
    _hasAnswered = true;
    _userSelectedTrue = userAnswer;

    bool correctAnswer = questions[currentQuestionIndex]["answer"];
    bool isCorrect = userAnswer == correctAnswer;

    if (isCorrect) {
      score++; // Tambah skor kalo benar
      _currentStreak++; // Tambah streak kalo benar 3x
      if (_currentStreak % 3 == 0) {
        _badgeCount++;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Selamat!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/streak-badge.png', width: 100),
                SizedBox(height: 10),
                Text("Anda telah berhasil mendapatkan badge setelah menjawab 3 soal beruntun.\n\n"
                    "Badge ini dapat digunakan untuk klaim THR dari pakdhe, tante, dan orang di sebelahmu! Cobain 😎"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Mantap, mksh y! 🌹"),
              ),
            ],
          ),
        );
      }
    }

    setState(() {
      _isAnswerCorrect = isCorrect;
      answerFeedbackIcons.add(
        Icon(
          isCorrect ? Icons.check_circle : Icons.cancel,
          color: isCorrect ? Colors.green : Colors.red,
          size: 24,
        ),
      );
      totalAnswered++;
    });

    if (!isCorrect) {
      _currentStreak = 0; // Reset streak kalo salah njawab
    }

    // Delay sebelum ke soal berikutnya (1,5 detik)
    Future.delayed(Duration(milliseconds: 1500), () {
      if (currentQuestionIndex < questions.length - 1) {
        goToNextQuestion();
      } else {
        showFinalDialog(); // Setelah soal terakhir
      }
    });
  }

  // Fungsi styling tombol berdasarkan kondisi jawaban
  ButtonStyle getButtonStyle(bool thisButtonTrue) {
    final isSelected = _hasAnswered && (_userSelectedTrue == thisButtonTrue);
    final isCorrect = questions[currentQuestionIndex]["answer"] == thisButtonTrue;

    Color borderColor = Colors.black;
    Color textColor = Colors.black;

    if (_hasAnswered) {
      if (isSelected) {
        if (_isAnswerCorrect == true) {
          borderColor = Color(0xFF00A906); // Hijau benar
          textColor = Color(0xFF00A906);
        } else {
          borderColor = Color(0xFFFF0000); // Merah salah
          textColor = Color(0xFFFF0000);
        }
      } else if (_isAnswerCorrect == false && isCorrect) {
        // Jawaban yang benar tapi tidak dipilih
        borderColor = Color(0xFF00A906);
        textColor = Color(0xFF00A906);
      } else {
        // Opsi lain yang tidak dipilih
        borderColor = Color(0xFF6D6D6D);
        textColor = Color(0xFF6D6D6D);
      }
    }

    return ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 65),
      alignment: Alignment.centerLeft,
      backgroundColor: Color(0xFFD9D9D9),
      foregroundColor: textColor,
      side: BorderSide(color: borderColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

// Fungsi pindah next soal
  void goToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      _isAnswerCorrect = null;
      _hasAnswered = false;
    });
  }

  // Fungsi confirm sebelum selesai kuis
  void confirmFinishQuiz() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Yaqueen nich mau selesai?"),
          content: Text("Belom kelar loch 🤔"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
                showFinalDialog(); // Langsung tampilkan dialog hasil akhir
              },
              child: Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  void confirmExitQuiz() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Anda ingin mengakhiri kuis?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Nah"),
          ),
