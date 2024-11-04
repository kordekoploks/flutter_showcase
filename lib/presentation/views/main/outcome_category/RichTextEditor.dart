import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';

class RichTextEditor extends StatefulWidget {
  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  TextAlign _textAlign = TextAlign.left;
  double _fontSize = 16.0;
  Color _fontColor = Colors.black;
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadTextFromFile(); // Load text on startup
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  void _toggleUnderline() {
    setState(() {
      _isUnderlined = !_isUnderlined;
    });
  }

  void _changeFontSize(double size) {
    setState(() {
      _fontSize = size;
    });
  }

  void _changeFontColor(Color color) {
    setState(() {
      _fontColor = color;
    });
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void _changeTextAlign(TextAlign align) {
    setState(() {
      _textAlign = align;
    });
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/saved_text.json';
  }

  // Save the current text and styles to a JSON file
  Future<void> _saveTextToFile() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    Map<String, dynamic> data = {
      'text': _controller.text,
      'isBold': _isBold,
      'isItalic': _isItalic,
      'isUnderlined': _isUnderlined,
      'textAlign': _textAlign.index,
      'fontSize': _fontSize,
      'fontColor': _fontColor.value,
      'backgroundColor': _backgroundColor.value,
    };

    file.writeAsString(jsonEncode(data));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text saved!')),
    );
  }

  // Load the saved text and styles from a JSON file
  Future<void> _loadTextFromFile() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        String content = await file.readAsString();
        Map<String, dynamic> data = jsonDecode(content);

        setState(() {
          _controller.text = data['text'];
          _isBold = data['isBold'];
          _isItalic = data['isItalic'];
          _isUnderlined = data['isUnderlined'];
          _textAlign = TextAlign.values[data['textAlign']];
          _fontSize = data['fontSize'];
          _fontColor = Color(data['fontColor']);
          _backgroundColor = Color(data['backgroundColor']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load text!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rich Text Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTextToFile,
          ),
          IconButton(
            icon: Icon(Icons.folder_open),
            onPressed: _loadTextFromFile,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(
            child: Container(
              color: _backgroundColor,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: null,
                textAlign: _textAlign,
                style: TextStyle(
                  fontSize: _fontSize,
                  color: _fontColor,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration:
                  _isUnderlined ? TextDecoration.underline : TextDecoration.none,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.format_bold,
              color: _isBold ? Colors.blue : Colors.black,
            ),
            onPressed: _toggleBold,
          ),
          IconButton(
            icon: Icon(
              Icons.format_italic,
              color: _isItalic ? Colors.blue : Colors.black,
            ),
            onPressed: _toggleItalic,
          ),
          IconButton(
            icon: Icon(
              Icons.format_underline,
              color: _isUnderlined ? Colors.blue : Colors.black,
            ),
            onPressed: _toggleUnderline,
          ),
          IconButton(
            icon: Icon(Icons.format_align_left),
            onPressed: () => _changeTextAlign(TextAlign.left),
          ),
          IconButton(
            icon: Icon(Icons.format_align_center),
            onPressed: () => _changeTextAlign(TextAlign.center),
          ),
          IconButton(
            icon: Icon(Icons.format_align_right),
            onPressed: () => _changeTextAlign(TextAlign.right),
          ),
          DropdownButton<double>(
            value: _fontSize,
            items: [14.0, 16.0, 18.0, 20.0, 24.0].map((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text(
                  value.toString(),
                ),
              );
            }).toList(),
            onChanged:  (double? newValue) {
              if (newValue != null) {
                _changeFontSize(newValue); // Call your method with non-null value
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () => _pickFontColor(context),
          ),
          IconButton(
            icon: Icon(Icons.format_color_fill),
            onPressed: () => _pickBackgroundColor(context),
          ),
        ],
      ),
    );
  }

  void _pickFontColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Font Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _fontColor,
            onColorChanged: _changeFontColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Select'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _pickBackgroundColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Background Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _backgroundColor,
            onColorChanged: _changeBackgroundColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Select'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RichTextEditor(),
  ));
}
