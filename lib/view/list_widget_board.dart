import 'package:flutter/material.dart';
import 'package:flutter_chan_viewer/models/ui/board_item_vo.dart';

class BoardListWidget extends StatelessWidget {
  final BoardItemVO board;

  const BoardListWidget({
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(board.title, style: Theme.of(context).textTheme.titleLarge),
            if (!board.workSafe)
              Text(" !!!", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.error)),
          ],
        ),
      ),
    );
  }
}
