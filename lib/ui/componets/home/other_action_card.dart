import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherActionCard extends StatelessWidget {
  const OtherActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "其他",
                textAlign: TextAlign.start,
                style: GoogleFonts.notoSerif(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(
                children: [Icon(Icons.gavel_outlined), Text("教评未开启")],
              ),
              Column(
                children: [Icon(Icons.fact_check_outlined), Text("选课未开启")],
              )
            ])
          ],
        ));
  }
}
