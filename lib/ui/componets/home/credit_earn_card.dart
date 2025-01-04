import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditEarnCard extends StatefulWidget {
  const CreditEarnCard({super.key});
  @override
  State<StatefulWidget> createState() => _CreditEarnCardState();
}

class _CreditEarnCardState extends State<CreditEarnCard> {
  @override
  Widget build(BuildContext context) {
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
                        Text("160",
                            style: GoogleFonts.notoSerif(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          "/162",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "13",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.notoSerif(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text("/15",
                                style: GoogleFonts.notoSerif(
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        Text(
                          "本学期已选与已修",
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
                    "学分与已修",
                    style: GoogleFonts.notoSerif(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
