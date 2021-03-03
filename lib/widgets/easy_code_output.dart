import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class EasyCodeOutput extends StatelessWidget {
  const EasyCodeOutput({
    Key key,
    @required this.output,
  }) : super(key: key);

  final String output;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyWebView(
        src: output,
        isHtml: true,
        onLoaded: () {},
      ),
    );
  }
}