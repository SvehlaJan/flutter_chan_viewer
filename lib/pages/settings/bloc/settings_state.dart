import 'package:equatable/equatable.dart';
import 'package:flutter_chan_viewer/repositories/chan_storage.dart';
import 'package:flutter_chan_viewer/utils/constants.dart';

abstract class SettingsState extends Equatable {
  SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsStateLoading extends SettingsState {}

class SettingsStateError extends SettingsState {
  final String message;

  SettingsStateError(this.message);

  @override
  String toString() => 'SettingsStateError { message: $message }';

  @override
  List<Object> get props => [message];
}

class SettingsStateContent extends SettingsState {
  final AppTheme theme;
  final List<DownloadFolderInfo> downloads;
  final bool nsfwEnabled;

  SettingsStateContent(this.theme, this.downloads, this.nsfwEnabled);

  @override
  String toString() => 'SettingsStateContent { theme: $theme, downloads: $downloads, nsfwEnabled: $nsfwEnabled }';

  @override
  List<Object> get props => [theme, downloads, nsfwEnabled];
}
