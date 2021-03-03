import 'package:easycode/widgets/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'themes/night_owl.dart';

class EasyCodeBody extends StatelessWidget {
  const EasyCodeBody({
    Key key,
    @required this.controllerHtml,
    @required this.controllerCss,
    @required this.controllerJs,
  }) : super(key: key);

  final HighlightEditingController controllerHtml;
  final HighlightEditingController controllerCss;
  final HighlightEditingController controllerJs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Html',
                    style: GoogleFonts.firaCode(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Css',
                    style: GoogleFonts.firaCode(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'JavaScript',
                    style: GoogleFonts.firaCode(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: CodeEditor(
                    controller: controllerHtml,
                    text: controllerHtml.text,
                    language: 'html',
                    padding: EdgeInsets.all(12),
                    theme: nightOwlTheme,
                    textStyle: GoogleFonts.firaCode(fontSize: 30),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: CodeEditor(
                    controller: controllerCss,
                    text: controllerCss.text,
                    language: 'css',
                    padding: EdgeInsets.all(12),
                    theme: nightOwlTheme,
                    textStyle: GoogleFonts.firaCode(fontSize: 30),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: CodeEditor(
                    controller: controllerJs,
                    text: controllerJs.text,
                    language: 'javascript',
                    padding: EdgeInsets.all(12),
                    theme: nightOwlTheme,
                    textStyle: GoogleFonts.firaCode(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
