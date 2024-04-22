import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/domain/entites/movie_req_model.dart';
import 'package:geeksynergy_avadhesh/domain/repositories/movie_repository.dart';
import 'package:geeksynergy_avadhesh/ui/home/cubit/state.dart';
import 'package:geeksynergy_avadhesh/utils/base/cubit.dart';
import 'package:geeksynergy_avadhesh/utils/extensions.dart';

class HomePageCubit extends AppBloc<HomePageState> {
  final BuildContext _context;
  final MovieRepo _movieRepo = MovieRepo();
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();

  HomePageCubit(
    this._context,
    super.initialState,
  ) {
    init();
  }

  @override
  void init() {
    onRefresh();
  }

  @override
  Future<bool> onBackPress() {
    return Future.value(false);
  }

  @override
  Future<void> onRefresh() async {
    emit(HomePageLoading());
    _movieRepo
        .getMovieLIst(const RequestMovieModel(
            category: "movies",
            language: "kannada",
            genre: "all",
            sort: "voting"))
        .thenSuccessData((response) {
      emit(HomePageLoaded(movieResponseModel: response));
    });
    return Future.value(false);
  }


}
