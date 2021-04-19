String generateCode(html, css, js) {
    var code = '''
    <html>
    <style>
    $css
    </style>
    $html
    <script>
    $js
    </script>
    </html>''';
    return code;
  }