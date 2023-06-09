// ignore_for_file: import_of_legacy_library_into_null_safe, depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    // ignore: avoid_print
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    // ignore: avoid_print
    print(error);
  }
  
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print(transition);
  }
/*
  @override
  void onChange(Bloc bloc, Change change) {
    super.onChange(bloc, change);
  }*/

}
