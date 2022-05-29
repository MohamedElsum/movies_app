import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/domain/models/upcomingMoviesResponse.dart';
import 'package:movies_app/presentation/widgets/movie_item.dart';
import 'package:movies_app/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesCubit _charactersCubit;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _charactersCubit = BlocProvider.of<MoviesCubit>(context);
    _charactersCubit.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appYellow,
            leading: state is MoviesFiltered
                ? const BackButton(
                    color: AppColors.appGray,
                  )
                : Container(),
            title: state is MoviesFiltered
                ? buildSearchTextField()
                : buildAppBarTitle(),
            actions: _buildAppBarActions(state),
          ),
          body: buildBlocWidget(state),
        );
      },
    );
  }

  Widget buildBlocWidget(state) {
    switch (state) {
      case MoviesLoaded:
        return buildListWidget(state.characters);
      case MoviesFiltered:
        return buildListWidget(state.characters);
      case MoviesLoading:
        return showLoadingIndicator();
    }
    return buildListWidget(_charactersCubit.movies);
  }

  Widget showLoadingIndicator() {
    return Center(
      child: Image.asset('assets/images/loader.gif'),
    );
  }

  Widget buildListWidget(List<Results>? movies) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.appGray,
        child: Column(
          children: [
            buildCharacterList(movies!),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList(List<Results> movies) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieItem(
          movie: movies[index],
        );
      },
    );
  }

  List<Widget> _buildAppBarActions(state) {
    if (state is MoviesFiltered) {
      return [
        IconButton(
          onPressed: () {
            _stopSearching();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.appGray,
          ),
        ),
      ];
    }

    return [
      IconButton(
        onPressed: _startSearch,
        icon: const Icon(
          Icons.search,
          color: AppColors.appGray,
        ),
      ),
    ];
  }

  Widget buildSearchTextField() {
    return SearchTextField(
      onSearch: (searchKey) {
        _charactersCubit.search(searchKey);
      },
      searchTextController: _searchTextController,
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Watch',
      style: TextStyle(color: AppColors.appGray),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    _charactersCubit.startSearch();
  }

  void _stopSearching() {
    setState(() {
      _searchTextController.clear();
    });
    _charactersCubit.stopSearch();
  }
}
