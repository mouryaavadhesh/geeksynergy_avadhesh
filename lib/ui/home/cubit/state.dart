import 'package:geeksynergy_avadhesh/domain/entites/movie_response_model.dart';
import 'package:geeksynergy_avadhesh/utils/base/cubit.dart';

class HomePageState extends BlocState {
  HomePageState();
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final MovieResponseModel movieResponseModel;

  HomePageLoaded({required this.movieResponseModel});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is HomePageLoaded &&
              runtimeType == other.runtimeType &&
              movieResponseModel == other.movieResponseModel;

  @override
  int get hashCode => super.hashCode ^ movieResponseModel.hashCode;
}