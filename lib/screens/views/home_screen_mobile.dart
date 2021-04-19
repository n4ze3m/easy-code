import 'package:easycode/functions/generate_code.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
import 'package:easycode/widgets/widgets.dart';

class HomeScreenMobile extends StatefulWidget {
  final HighlightEditingController controllerHtml;
  final HighlightEditingController controllerCss;
  final HighlightEditingController controllerJs;

  const HomeScreenMobile({
    Key key,
    @required this.controllerHtml,
    @required this.controllerCss,
    @required this.controllerJs,
  }) : super(key: key);
  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  String output = "";
  int _currentBarIndex;
  List<Widget> mobileBody;

  @override
  void initState() {
    _currentBarIndex = 0;
    mobileBody = [
      EasyCodeBody(
        controllerHtml: widget.controllerHtml,
        controllerCss: widget.controllerCss,
        controllerJs: widget.controllerJs,
      ),
      EasyCodeOutput(output: output),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Easy Code 0.0.1',
            style: GoogleFonts.firaCode(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              color: Colors.white,
              tooltip: 'Run code',
              onPressed: () {
                setState(() {
                  output = generateCode(widget.controllerHtml.text,
                      widget.controllerCss.text, widget.controllerJs.text);
                  // regenerating mobilebody when use click run
                  mobileBody = [
                    EasyCodeBody(
                      controllerHtml: widget.controllerHtml,
                      controllerCss: widget.controllerCss,
                      controllerJs: widget.controllerJs,
                    ),
                    EasyCodeOutput(output: output),
                  ];
                });
              },
            )
          ],
        ),
        body: mobileBody[_currentBarIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (newIndex) {
              setState(() {
                _currentBarIndex = newIndex;
              });
            },
            currentIndex: _currentBarIndex,
            items: [
              BottomNavigationBarItem(
                label: 'Code',
                icon: Icon(Icons.code),
              ),
              BottomNavigationBarItem(
                label: 'Output',
                icon: Icon(Icons.remove_red_eye_sharp),
              ),
            ]));
  }
}
