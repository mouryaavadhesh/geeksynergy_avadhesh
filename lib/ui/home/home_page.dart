import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksynergy_avadhesh/data/database/sql.dart';
import 'package:geeksynergy_avadhesh/domain/entites/movie_response_model.dart';
import 'package:geeksynergy_avadhesh/ui/bottomsheet/user_info.dart';
import 'package:geeksynergy_avadhesh/ui/home/cubit/home_page_cubit.dart';
import 'package:geeksynergy_avadhesh/ui/home/cubit/state.dart';
import 'package:geeksynergy_avadhesh/utils/base/app_instance.dart';
import 'package:geeksynergy_avadhesh/utils/template/text.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(context, HomePageInitial()),
      child:
          BlocBuilder<HomePageCubit, HomePageState>(builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Home"),
              actions: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5),
                    child: InkWell(
                        onTap: () {
                          AppInstance()
                              .databaseHelper
                              .readUser(UserColumn.email, AppInstance().sharedPreferences.getString("email"))
                              .then((value) async {
                            UserInfoBottomSheet().show(context,value!);
                          });

                        },
                        child: const Icon(
                          Icons.info,
                          size: 36,
                        )))
              ],
            ),
            backgroundColor: Colors.white,
            body: state is HomePageLoading
                ? _loadingState()
                : state is HomePageLoaded
                    ? _body(context, state)
                    : const SizedBox(
                        width: 0,
                      ),
          ),
        );
      }),
    );
  }

  _loadingState() {
    return const Center(
      child: SizedBox(
        width: 36,
        height: 36,
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _body(BuildContext context, HomePageLoaded homePageLoaded) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return const SizedBox(
                height: 20,
              );
            },
            childCount: 1, // 1000 list items
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _stockCard(
                  context, homePageLoaded.movieResponseModel.result[index]);
            },
            childCount: homePageLoaded.movieResponseModel.result.length,
          ),
        )
      ],
    );
  }

  _stockCard(BuildContext context, Result result) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.arrow_drop_up,
                      size: 48,
                    ),
                    GeekAvaText.textBold(
                        text: result.voting.toString(), fontSize: 20),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 48,
                    ),
                    GeekAvaText.textMedium(text: "Votes", fontSize: 16),
                  ],
                ),
              ),
              SizedBox(
                  height: 150,
                  child: Card(
                    child: Image.network(
                      result.poster,
                      width: 80,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeekAvaText.textBold(text: result.title, fontSize: 20),
                    Row(
                      children: [
                        GeekAvaText.textBold(text: "Genre: ", fontSize: 14),
                        Flexible(
                          child: GeekAvaText.textMedium(
                            text: result.genre,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GeekAvaText.textBold(text: "Director: ", fontSize: 14),
                        Flexible(
                          child: GeekAvaText.textMedium(
                            text: result.director.join(', '),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GeekAvaText.textBold(text: "Starring: ", fontSize: 14),
                        Flexible(
                          child: GeekAvaText.textMedium(
                            text: result.stars.join(', '),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    GeekAvaText.textMedium(
                        text:
                            "${result.runTime} Min | ${result.language} | ${getTime(result.releasedDate)}",
                        fontSize: 14),
                    GeekAvaText.textMedium(
                        text:
                            "${result.pageViews} views | Voted by ${result.totalVoted} people",
                        fontSize: 14,
                        color: Colors.blue.shade200),
                  ],
                ),
              )
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeekAvaText.textBold(
                    text: "Watch Trailer", fontSize: 14, color: Colors.white),
              ],
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2)),
        ],
      ),
    );
  }

  String getTime(int timestampInMilliseconds) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds * 1000);

    return DateFormat('dd MMM').format(dateTime);
  }


}
