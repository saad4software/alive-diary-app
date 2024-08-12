import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinedTextField extends StatelessWidget {
  const LinedTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          for (int i = 0; i < 40; i++)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: (i + 1) * 45,
                left: 15,
                right: 15,
              ),
              height: 1,
              color: Colors.grey,
            ),

          SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                cursorHeight: 35,
                style: GoogleFonts.caveat(fontSize: 30),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
