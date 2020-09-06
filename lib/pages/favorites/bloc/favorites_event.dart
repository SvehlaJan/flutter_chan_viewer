import 'package:flutter_chan_viewer/bloc/chan_event.dart';

class FavoritesEventOnItemSelected extends ChanEvent {}

class FavoritesEventFetchDetail extends ChanEvent {
  final int index;

  FavoritesEventFetchDetail(this.index);

  @override
  List<Object> get props => [index];
}