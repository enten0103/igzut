import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradePointsCard extends StatelessWidget {
  const GradePointsCard(
      {super.key,
      required this.gradePoint,
      required this.administrativeClass,
      required this.college});
  final String gradePoint;
  final String administrativeClass;
  final String college;
  @override
  Widget build(context) {
    return Card(
        elevation: 0,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: SizedBox(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(gradePoint,
                            style: GoogleFonts.notoSerif(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          " /5",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          administrativeClass,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.notoSerif(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          college,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "绩点与学院",
                    style: GoogleFonts.notoSerif(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
