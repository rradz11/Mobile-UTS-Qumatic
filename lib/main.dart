
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Keluar ke page sebelumnya
            },
            child: Text("Yay"),
          ),
        ],
      ),
    );
  }

  void showFinalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kuis Selesai 🎉"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selamat, tahniah, terima kasih, dan xièxiè telah menyelesaikan kuis!\n\n"
                    "Anda sukses. 10 langkah kaki lagi di real-life Anda akan mendapat koin keberuntungan 🪙",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Skor Anda: $score/${questions.length}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                resetQuiz(); // Reset utk ngulang kuis
              },
              child: Text("Ulangi Kuis"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Kembali ke page sebelumnya
              },
              child: Text("Selesai"),
            ),
          ],
        );
      },
    );
  }

  // Fungsi reset kuis ke awal
  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      totalAnswered = 0;
      score = 0;
      answerFeedbackIcons.clear();
      _isAnswerCorrect = null;
      _hasAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( // Memperluas size appBar
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 12.5),
        child: AppBar(
          automaticallyImplyLeading: false, // Ngilangin appBar bawaan
          title: Text(
            "Quiz Mafortic",
            style: GoogleFonts.konkhmerSleokchher(fontSize: 24),
          ),
          backgroundColor: Color(0xFF002D8B), // Warna app bar
          foregroundColor: Color(0xFFD8E1FF), // Warna teks
          centerTitle: true,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD8E1FF), Color(0xFF236BFF)], // Gradasi
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Rectangle putih isi ikon feedback
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: answerFeedbackIcons,
                ),
              ),

              // Tombol Back
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton( // Back
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: confirmExitQuiz,
                    ),

                    // Gambar Badge
                    if (_badgeCount > 0)
                      Row(
                        children: List.generate(_badgeCount, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.asset(
                              'assets/streak-badge.png',
                              width: 30,
                              height: 30,
                            ),
                          );
                        }),
                      ),

                    // Tombol Selesai
                    TextButton(
                      onPressed: confirmFinishQuiz,
                      child: Text("Selesai",
                        style: TextStyle(color: Color(0xFF0600BD)),
                      ),
                    )
                  ],
                ),
              ),

              // Nomor Soal
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Soal ${currentQuestionIndex + 1}/$totalQuestions",
                        style: GoogleFonts.konkhmerSleokchher(fontSize: 19),
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Progress Bar
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                        LayoutBuilder( // Progress putih yg nambah sesuai soal
                          builder: (context, constraints) {
                            double progressWidth = constraints.maxWidth * (totalAnswered / totalQuestions);
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: progressWidth,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 43),
                    Divider(thickness: 1, color: Colors.white),
                  ],
                ),
              ),

              // Wadah soal dan tombol jawaban
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.60,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 15), // Jarak antara bagian atas wadah dan teks soal
                        Text(
                          questions[currentQuestionIndex]["question"],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.konkhmerSleokchher(fontSize: 22),
                        ),
                        SizedBox(height: 70), // Jarak antara soal dan tombol

                        // Opsi Jawaban
                        ElevatedButton(
                          onPressed: _hasAnswered ? null : () => checkAnswer(true), // Tombol opsi Benar
                          style: getButtonStyle(true),
                          child: Text(
                            "Benar",
                            style: GoogleFonts.konkhmerSleokchher(
                              fontSize: 22,
                              color: getButtonStyle(true).foregroundColor?.resolve({}),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // Jarak antar tombol
                        ElevatedButton(
                          onPressed: _hasAnswered ? null : () => checkAnswer(false), // Tombol opsi Salah
                          style: getButtonStyle(false),
                          child: Text(
                            "Salah",
                            style: GoogleFonts.konkhmerSleokchher(
                              fontSize: 22,
                              color: getButtonStyle(false).foregroundColor?.resolve({}),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
