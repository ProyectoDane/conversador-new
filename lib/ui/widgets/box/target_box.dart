import 'package:flutter/material.dart';
import 'package:flutter_cards/model/word.dart';
import 'package:flutter_cards/ui/widgets/animation/target_animation.dart';
import 'package:flutter_cards/ui/widgets/box/box.dart';
import 'package:flutter_cards/ui/utils/constants.dart';

class TargetBox extends Box {
  TargetBox({
    @required initPosition,
    @required word,
  }) : super(initPosition: initPosition, word: word);

  @override
  State<StatefulWidget> createState() => _TargetBoxState();
}

class _TargetBoxState extends State<TargetBox>
    with SingleTickerProviderStateMixin {
  Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.initPosition.dx,
      top: widget.initPosition.dy,
      child: DragTarget(
        onWillAccept: (word) => word.id == widget.word.id,
        onAccept: (Word word) => _selectedColor = word.color,
        builder: (BuildContext context, List<dynamic> accepted,
                List<dynamic> rejected) =>
            checkAccepted(accepted),
      ),
    );
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedColor = Colors.grey.shade300;
  }

  Widget checkAccepted(List<dynamic> accepted) {
    return accepted.isEmpty
        ? TargetAnimation(label: widget.word.value, color: _selectedColor)
        : widget.buildBox(
            size: TARGET_BOX_SIZE_COMPLETE,
            fontSize: FONT_SIZE_FEEDBACK,
            boxColor: _selectedColor);
  }
}
