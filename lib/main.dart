import 'package:dart_vlc/dart_vlc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chan_viewer/bloc/app_bloc/app_bloc.dart';
import 'package:flutter_chan_viewer/bloc/app_bloc/app_event.dart';
import 'package:flutter_chan_viewer/bloc/app_bloc/app_state.dart';
import 'package:flutter_chan_viewer/bloc/chan_state.dart';
import 'package:flutter_chan_viewer/bloc/chan_viewer_bloc/chan_viewer_bloc.dart';
import 'package:flutter_chan_viewer/locator.dart';
import 'package:flutter_chan_viewer/pages/base/auth_required_page.dart';
import 'package:flutter_chan_viewer/pages/base/base_page.dart';
import 'package:flutter_chan_viewer/pages/base/notfound_page.dart';
import 'package:flutter_chan_viewer/utils/flavor_config.dart';
import 'package:flutter_chan_viewer/utils/navigation_helper.dart';

import 'app.dart';
import 'utils/constants.dart';

void main() async {
  EquatableConfig.stringify = true;
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundIsolateBinaryMessenger.ensureInitialized(ServicesBinding.rootIsolateToken!);
  setupLocator();
  DartVLC.initialize();

  getIt.allReady().then((value) {
    runApp(
      BlocProvider(
        create: (context) {
          return AppBloc()..add(AppEventAppStarted());
        },
        child: MainApp(),
      ),
    );
  });
}

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlavorConfig(
      flavor: Flavor.dev,
      values: Constants.flavorDev,
    );

    return BlocBuilder<AppBloc, ChanState>(builder: (context, state) {
      if (state is AppStateLoading) {
        return Constants.centeredProgressIndicator;
      } else if (state is AppStateContent) {

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              BlocProvider(
                create: (context) => ChanViewerBloc(),
                child: MaterialApp(
                  title: Constants.appName,
                  theme: state.appTheme,
                  home: ChanViewerApp(),
                ),
              ),
              if (state.authState == AuthState.auth_required) AuthRequiredPage(),
              if (state.authState == AuthState.forbidden) NotFoundPage(),
            ],
          ),
        );
      } else {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: BasePageState.buildErrorScreen(context, (state as ChanStateError).message),
        );
      }
    });
  }
}
