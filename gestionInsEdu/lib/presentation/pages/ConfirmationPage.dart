import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/AnimatedCheckWidget.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 244, 253),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCheckWidget(),
            const SizedBox(height: 20),
            Text(
              "Autenticación Correcta",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
            ),
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}