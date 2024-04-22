part of 'login_cubit.dart';

class InitialState extends BlocState {
  InitialState();
}

class PrefillState extends BlocState {
  final String? companyName;
  final String? userName;

  PrefillState(this.companyName, this.userName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PrefillState &&
          runtimeType == other.runtimeType &&
          companyName == other.companyName &&
          userName == other.userName;

  @override
  int get hashCode => super.hashCode ^ companyName.hashCode ^ userName.hashCode;
}
