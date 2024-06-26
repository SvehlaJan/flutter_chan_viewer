import 'package:flutter/material.dart';
import 'package:flutter_chan_viewer/models/ui/thread_item_vo.dart';
import 'package:flutter_chan_viewer/utils/chan_util.dart';
import 'package:flutter_chan_viewer/utils/constants.dart';
import 'package:flutter_chan_viewer/utils/extensions.dart';
import 'package:flutter_chan_viewer/utils/log_utils.dart';
import 'package:flutter_chan_viewer/view/view_cached_image.dart';
import 'package:flutter_html/flutter_html.dart';

class ThreadListWidget extends StatelessWidget with ChanLogger {
  final ThreadItemVO thread;
  final bool showProgress;

  ThreadListWidget({required this.thread, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    int newReplies = thread.lastSeenPostIndex > 0 ? thread.replies - thread.lastSeenPostIndex : 0;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (thread.mediaSource != null)
            ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Constants.avatarImageSize,
                  minWidth: Constants.avatarImageSize,
                  minHeight: Constants.avatarImageSize,
//                  maxHeight: Constants.avatarImageMaxHeight,
                ),
                child: ChanCachedImage(imageSource: thread.mediaSource!.asImageSource(), boxFit: BoxFit.fitWidth)),
          Flexible(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (thread.isFavorite)
                            Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Icon(Icons.star, color: Colors.yellow, size: Constants.favoriteIconSize)),
                          Text(thread.threadId.toString(), style: Theme.of(context).textTheme.bodySmall),
                          Spacer(),
                          Text("${thread.replies}p/${thread.images}m", style: Theme.of(context).textTheme.bodySmall),
                          Spacer(),
                          Text(ChanUtil.getHumanDate(thread.timestamp), style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (thread.subtitle.isNotNullNorEmpty)
                            Flexible(
                                child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(thread.subtitle!,
                                        style: Theme.of(context).textTheme.titleLarge, maxLines: 2))),
                          if (newReplies > 0)
                            Text("$newReplies NEW",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(backgroundColor: Colors.red)),
                        ],
                      ),
                      Html(
                        data: ChanUtil.getReadableHtml(thread.htmlContent ?? "", true),
                        style: {"*": Style(margin: Margins.zero)},
                        onLinkTap: (url, attributes, element) => logDebug("Html link clicked { url: $url }"),
                      )
                    ],
                  ),
                ),
                if (showProgress) LinearProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
