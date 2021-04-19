import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:highlight/highlight.dart' show highlight, Node;

class CodeEditor extends StatefulWidget {
  final String text;

  final HighlightEditingController controller;

  final String language;

  final Map<String, TextStyle> theme;

  final EdgeInsetsGeometry padding;

  final TextStyle textStyle;

  CodeEditor({
    this.text,
    this.controller,
    this.language,
    this.theme = const {},
    this.padding,
    this.textStyle,
    int tabSize = 8,
  }) : assert(text != null || controller != null,
            'One of text properties must be provided');

  static const _rootKey = 'root';
  static const _defaultFontColor = Color(0xff000000);
  static const _defaultBackgroundColor = Color(0xffffffff);

  static const _defaultFontFamily = 'monospace';

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  String source;
  HighlightEditingController controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = HighlightEditingController(widget.language, widget.theme);
      controller.text = widget.text;
    } else {
      controller = widget.controller;
    }
    source = controller.text;
  }

  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      fontFamily: CodeEditor._defaultFontFamily,
      color: widget.theme[CodeEditor._rootKey]?.color ??
          CodeEditor._defaultFontColor,
    );
    if (widget.textStyle != null) {
      _textStyle = _textStyle.merge(widget.textStyle);
    }

    return Theme(
      data: ThemeData(
        textSelectionTheme:
            TextSelectionThemeData(selectionColor: Color(0xff82b1ff)),
      ),
          child: Scrollbar(
            child: Container(
          color: widget.theme[CodeEditor._rootKey]?.backgroundColor ??
              CodeEditor._defaultBackgroundColor,
          padding: widget.padding,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(border: InputBorder.none),
            maxLines: null,
            style: widget.theme[CodeEditor._rootKey],
          ),
        ),
      ),
    );
  }
}

List<TextSpan> getHighlightTextSpan(source, language, theme) {
  return _convert(highlight.parse(source, language: language).nodes, theme);
}

class HighlightEditingController extends TextEditingController {
  String language;
  Map<String, TextStyle> theme;

  HighlightEditingController(this.language, this.theme);

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    final result = highlight.parse(value.text, language: language);
    final spans = TextSpan(
      style: style,
      children: _convert(result.nodes, theme),
    );
    if (value.composing.isValid && withComposing) {
      underlineComposing(spans);
    }
    return spans;
  }

  underlineComposing(TextSpan nodes) {
    var pos = 0;
    final TextStyle composingStyle =
        TextStyle(decoration: TextDecoration.underline);

    TextSpan _traverse(TextSpan node) {
      if (node.text != null &&
          pos <= value.composing.start &&
          value.composing.end <= pos + node.text.length) {
        var relativeComposing = TextRange(
          start: value.composing.start - pos,
          end: value.composing.end - pos,
        );
        return TextSpan(
          children: [
            TextSpan(text: relativeComposing.textBefore(node.text)),
            TextSpan(
              style: composingStyle,
              text: relativeComposing.textInside(node.text),
            ),
            TextSpan(text: relativeComposing.textAfter(node.text)),
          ],
        );
      }

      pos += node.text?.length ?? 0;
      if (node.children != null) {
        for (var i = 0;
            i < node.children.length && pos <= value.composing.start;
            i++) {
          var update = _traverse(node.children[i]);
          if (update != null) {
            node.children[i] = update;
            return null;
          }
        }
      }
      return null;
    }

    _traverse(nodes);
  }
}

List<TextSpan> _convert(List<Node> nodes, theme) {
  List<TextSpan> spans = [];
  var currentSpans = spans;
  List<List<TextSpan>> stack = [];

  _traverse(Node node) {
    if (node.value != null) {
      currentSpans.add(node.className == null
          ? TextSpan(text: node.value)
          : TextSpan(text: node.value, style: theme[node.className]));
    } else if (node.children != null) {
      List<TextSpan> tmp = [];
      currentSpans.add(TextSpan(children: tmp, style: theme[node.className]));
      stack.add(currentSpans);
      currentSpans = tmp;

      node.children.forEach((n) {
        _traverse(n);
        if (n == node.children.last) {
          currentSpans = stack.isEmpty ? spans : stack.removeLast();
        }
      });
    }
  }

  for (var node in nodes) {
    _traverse(node);
  }

  return spans;
}
