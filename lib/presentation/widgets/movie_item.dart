import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/strings.dart';
import 'package:movies_app/domain/models/upcomingMoviesResponse.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final Results movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppConstants.charactersDetailsScreen,
          arguments: movie.id,
        ),
        child: GridTile(
          child: Hero(
            tag: movie.id ?? 0,
            child: Container(
              color: AppColors.appGray,
              child: FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/images/loader.gif',
                image: (AppConstants.baseImageUrl + movie.posterPath!) ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${movie.originalTitle}',
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: AppColors.appWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
