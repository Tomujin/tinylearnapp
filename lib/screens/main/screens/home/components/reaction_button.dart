import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:tiny/theme/style.dart';
import 'package:tiny/utils/tiny_icons.dart';
import 'package:tiny/theme/style.dart';

class ReactionButton extends StatelessWidget {
  final int selectedIndex;
  ReactionButton({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final reactionColor =
        this.selectedIndex == -1 ? ligtGrey : Theme.of(context).accentColor;
    var reactions = <Reaction>[
      Reaction(
        title: _buildTitle('Thanked'),
        previewIcon:
            _buildReactionsPreviewIcon('assets/images/reaction/clap.png'),
        icon: _buildReactionsIcon(Tiny.clap, reactionColor),
      ),
      Reaction(
        title: _buildTitle('Got it'),
        previewIcon:
            _buildReactionsPreviewIcon('assets/images/reaction/lamp.png'),
        icon: _buildReactionsIcon(
          Tiny.lamp,
          reactionColor,
        ),
      ),
      Reaction(
        title: _buildTitle('Not clear'),
        previewIcon:
            _buildReactionsPreviewIcon('assets/images/reaction/question.png'),
        icon: _buildReactionsIcon(
          Tiny.clap,
          reactionColor,
        ),
      ),
      Reaction(
        title: _buildTitle('Learned a lot'),
        previewIcon:
            _buildReactionsPreviewIcon('assets/images/reaction/book.png'),
        icon: _buildReactionsIcon(
          Tiny.book,
          reactionColor,
        ),
      ),
      Reaction(
        title: _buildTitle('Disagree'),
        previewIcon:
            _buildReactionsPreviewIcon('assets/images/reaction/disagree.png'),
        icon: _buildReactionsIcon(
          Tiny.disagree,
          reactionColor,
        ),
      ),
      Reaction(
          title: _buildTitle('Wrong'),
          previewIcon:
              _buildReactionsPreviewIcon('assets/images/reaction/wrong.png'),
          icon: _buildReactionsIcon(
            Tiny.wrong,
            reactionColor,
          )),
    ];
    return FlutterReactionButtonCheck(
        initialReaction:
            selectedIndex == -1 ? reactions[0] : reactions[selectedIndex],
        selectedReaction:
            selectedIndex == -1 ? reactions[0] : reactions[selectedIndex],
        onReactionChanged: (reaction, index, isChecked) {
          print('reaction selected index: $index');
        },
        reactions: reactions);
    // For padding
  }

  Widget _builFlagsdPreviewIcon(String path, String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 7.5),
            Image.asset(path, height: 30),
          ],
        ),
      );

  Widget _buildTitle(String title) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildReactionsPreviewIcon(String path) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
        child: Image.asset(path, height: 40),
      );

  Widget _buildIcon(String path) => Image.asset(
        path,
        height: 30,
        width: 30,
      );

  Widget _buildReactionsIcon(IconData icon, Color iconColor) => Container(
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Icon(icon, color: iconColor),
            const SizedBox(width: 5),
            // text,
          ],
        ),
      );
}
