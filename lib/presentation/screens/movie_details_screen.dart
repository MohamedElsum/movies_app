import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/domain/models/MovieDetailsResponse.dart';
import 'package:movies_app/presentation/screens/get_tickets.dart';
import 'package:movies_app/presentation/screens/trailer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/constants/strings.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({Key? key, required this.movieId})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MoviesCubit _charactersCubit;

  @override
  void initState() {
    super.initState();

    _charactersCubit = BlocProvider.of<MoviesCubit>(context);
    _charactersCubit.getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.appWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Watch',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildWidget(state),
                  const SizedBox(
                    height: 500,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildWidget(state) {
    if (state == MovieDetailsLoading) {
      return showLoadingIndicator();
    } else {
      return buildDetailsWidget(_charactersCubit.movie);
    }
  }

  Widget buildDetailsWidget(MovieDetailsResponse movie) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              FadeInImage.assetNetwork(
                width: double.infinity,
                height: 500,
                placeholder: 'assets/images/loader.gif',
                image:
                    (AppConstants.baseImageUrl + movie.posterPath.toString()) ??
                        "",
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 90,
                left: 90,
                child: Column(
                  children: [
                    Text(
                      'In Theaters ${movie.releaseDate}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => GetTicketsScreen(
                                      movieTitle: movie.title,
                                      releaseDate: movie.releaseDate,
                                    )),
                          );
                        },
                        child: const Text(
                          'Get Tickets',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.indigo),
                            ))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TrailerScreen()));
                        },
                        child: const Text(
                          'Watch Trailer',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              'Genres',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: movie.genres?.length ?? 0,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  genreTile((movie.genres?[index].name).toString()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              'Overview',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 10),
            child: Text(
              movie.overview.toString(),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget genreTile(String genre) {
    return Container(
      width: 80,
      height: 40,
      margin: const EdgeInsets.only(left: 25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        genre,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }


  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.appYellow,
      ),
    );
  }
}

class CharacterInfo extends StatelessWidget {
  final String title;
  final String value;

  const CharacterInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.appWhite,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.appWhite,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

Widget showLoadingIndicator() {
  return Center(
    child: Image.asset('assets/images/loader.gif'),
  );
}

class AppDivider extends StatelessWidget {
  final double endIndent;

  const AppDivider({Key? key, required this.endIndent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: AppColors.appYellow,
      thickness: 2,
    );
  }
}
