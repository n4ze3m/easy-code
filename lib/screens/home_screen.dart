import 'package:flutter/material.dart';
import 'package:easycode/widgets/widgets.dart';

import 'views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HighlightEditingController controllerHtml;
  HighlightEditingController controllerCss;
  HighlightEditingController controllerJs;

  @override
  void initState() {
    super.initState();
    controllerHtml = HighlightEditingController('html', nightOwlTheme);
    controllerCss = HighlightEditingController('css', nightOwlTheme);
    controllerJs = HighlightEditingController('javascript', nightOwlTheme);

    // comments
    controllerHtml.text = '''
    <!--Easy code 0.0.1 from BuckthornDev-->
    <!-- index.html -->
    ''';
    controllerCss.text = '/* main.css */';
    controllerJs.text = '// index.js';
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: HomeScreenWeb(
        controllerHtml: controllerHtml,
        controllerCss: controllerCss,
        controllerJs: controllerJs,
      ),
      mediumScreen: HomeScreenWeb(
        controllerHtml: controllerHtml,
        controllerCss: controllerCss,
        controllerJs: controllerJs,
      ),
      smallScreen: HomeScreenMobile(
        controllerHtml: controllerHtml,
        controllerCss: controllerCss,
        controllerJs: controllerJs,
      ),
    );
  }
}
