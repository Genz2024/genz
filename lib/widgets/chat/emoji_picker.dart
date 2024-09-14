import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojiPickerWidget extends StatelessWidget {
  final Function(String) onEmojiSelected;

  EmojiPickerWidget({required this.onEmojiSelected});

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        onEmojiSelected(emoji.emoji);
      },
      config: Config(
        columns: 7,
        verticalSpacing: 0,
        horizontalSpacing: 0,
        gridPadding: EdgeInsets.zero, // EdgeInsets is from material.dart
        initCategory: Category.RECENT,
      ),
    );
  }
}
