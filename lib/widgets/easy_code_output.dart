import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasyCodeOutput extends StatelessWidget {
  const EasyCodeOutput({
    Key key,
    @required this.output,
  }) : super(key: key);

  final String output;

  @override
  Widget build(BuildContext context) {
    var console = '''
    <html>
    <body>
    <div id="mylog"></div>
    </body>
    <script>
    var former = console.log;
console.log = function(msg){
    former(msg); 
document.write("<div>" + msg + "</div>");
    // \$("#mylog").append("<div>" + msg + "</div>");
}

console.log("test")
    </script>
    </html>
    ''';

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Website',
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
                    'Console',
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
                  child: EasyWebView(
                    src: output,
                    isHtml: true,
                    onLoaded: () {},
                  ),
                ),
                Container(
                  child: EasyWebView(
                    src: console,
                    isHtml: true,
                    onLoaded: () {},
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
