import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igzut/ui/componets/course/course_darwer.dart';

class SideYearBar extends StatefulWidget {
  const SideYearBar(
      {super.key,
      required this.terms,
      required this.natures,
      required this.onPresse});

  final List<String> terms;

  final List<String> natures;

  final Function(String) onPresse;

  @override
  State<SideYearBar> createState() => _SideYearBarState();
}

class _SideYearBarState extends State<SideYearBar> {
  var selectTerm = 1;
  Set<String> extractAndDeduplicate(List<String> data) {
    Set<String> resultSet = {};
    RegExp regExp = RegExp(r"\((\d{4}-\d{4}-\d)\)");
    for (String item in data) {
      Match? match = regExp.firstMatch(item);
      if (match != null) {
        resultSet.add(match.group(1)!);
      }
    }

    return resultSet;
  }

  @override
  Widget build(BuildContext context) {
    var terms = extractAndDeduplicate(widget.terms).toList();
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
            width: 80,
            child: ListView.builder(
                itemCount: terms.length + 2,
                itemBuilder: (context, index) {
                  var resultText = "";
                  if (index == 0) {
                    return IconButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet<String>(
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
                    var result = terms[index - 2].split("-");
                    if (result[2] == "1") {
                      resultText = "${result[0]}-秋";
                    } else {
                      resultText = "${result[1]}-春";
                    }
                  }

                  return ElevatedButton(
                      onPressed: () {
                        if (index == 0 || index == 1) {
                          widget.onPresse("all");
                        } else {
                          widget.onPresse(terms[index - 2]);
                        }
                        if (index != 0) {
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
