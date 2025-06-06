import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(CodePreviewApp());
}

class CodePreviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Previewer',
      home: CodePreviewHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CodePreviewHome extends StatefulWidget {
  @override
  _CodePreviewHomeState createState() => _CodePreviewHomeState();
}

class _CodePreviewHomeState extends State<CodePreviewHome> {
  late WebViewController _controller;
  final TextEditingController _textController = TextEditingController();

  String initialHTML = """
<!DOCTYPE html>
<html>
<head><style>body { font-family: sans-serif; }</style></head>
<body>
<h2>Paste your code and tap 'Run'</h2>
</body>
</html>
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Code Previewer")),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Paste HTML, CSS, JS code here...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.loadHtmlString(_textController.text);
            },
            child: Text("Run Code"),
          ),
          Expanded(
            flex: 1,
            child: WebView(
              initialUrl: Uri.dataFromString(initialHTML, mimeType: 'text/html').toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
