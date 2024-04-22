import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class _AppState extends Equatable {}

class BlocState extends _AppState {
  @override
  List<Object?> get props => [];
}

abstract class AppBloc<T> extends AppBlocHandler<T> {
  AppBloc(T initialState) : super(initialState);

  void init();

  Future<bool> onBackPress();

  Future<void> onRefresh();
}

abstract class AppBlocHandler<T> extends BlocBase<T> {

  AppBlocHandler(T initialState) : super(initialState);
}
