import 'package:easycode/functions/generate_code.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easycode/widgets/widgets.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({
    Key key,
    @required this.controllerHtml,
    @required this.controllerCss,
    @required this.controllerJs,
  }) : super(key: key);

  final HighlightEditingController controllerHtml;
  final HighlightEditingController controllerCss;
  final HighlightEditingController controllerJs;

  @override
  _HomeScreenWebState createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  String output = "";
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
          ElevatedButton.icon(
            onPressed: () {
             
              setState(() {
                output = generateCode(widget.controllerHtml.text,
                    widget.controllerCss.text, widget.controllerJs.text);
              });
            },
            icon: Icon(Icons.play_arrow),
            label: Text('Run'),
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: EasyCodeBody(
              controllerHtml: widget.controllerHtml,
              controllerCss: widget.controllerCss,
              controllerJs: widget.controllerJs,
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: EasyCodeOutput(output: output),
          ),
        ],
      ),
    );
  }
}
