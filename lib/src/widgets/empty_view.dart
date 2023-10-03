import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:note_buckets/src/res/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(kLottieEmpty),
        Text(
          "The List is Empty Create it with + icon",
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
