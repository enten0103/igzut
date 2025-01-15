import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igzut/ui/componets/course/course_darwer.dart';

class SideYearBar extends StatefulWidget {
  const SideYearBar(
      {super.key,
      required this.terms,
      required this.natures,
      required this.onSelectTermChange});

  final List<String> terms;

  final List<String> natures;

  final Function(int) onSelectTermChange;

  @override
  State<SideYearBar> createState() => _SideYearBarState();
}

class _SideYearBarState extends State<SideYearBar> {
  var selectTerm = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
            width: 80,
            child: ListView.builder(
                itemCount: widget.terms.length + 2,
                itemBuilder: (context, index) {
                  var resultText = "";
                  if (index == 0) {
                    return IconButton(
                        onPressed: () async {
                          await showModalBottomSheet<String>(
                            context: context,
                            builder: (context) {
                              return CourseDarwer(
                                natures: widget.natures,
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.filter_alt_outlined));
                  } else if (index == 1) {
                    resultText = "全部";
                  } else {
                    var result = widget.terms[index - 2].split("-");
                    if (result[2] == "1") {
                      resultText = "${result[0]}-秋";
                    } else {
                      resultText = "${result[1]}-春";
                    }
                  }

                  return ElevatedButton(
                      onPressed: () {
                        if (index != 0) {
                          widget.onSelectTermChange(index);
                          setState(() {
                            selectTerm = index;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: selectTerm == index
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromARGB(0, 0, 0, 0),
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(0),
                          elevation: 0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                            child: Text(
                          resultText,
                          style: GoogleFonts.notoSerif(
                              fontSize: 16,
                              color: selectTerm == index
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Colors.black),
                        )),
                      ));
                })));
  }
}
