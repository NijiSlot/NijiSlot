import 'package:rains/model/entities/movie_entity.dart';
import 'package:rains/model/enums/load_status.dart';
import 'package:get/get.dart';

class MoviesSectionState {
  final loadMovieStatus = LoadStatus.initial.obs;
  final movies = <MovieEntity>[].obs;
  final page = 1.obs;
  final totalResults = 0.obs;
  final totalPages = 0.obs;

  MoviesSectionState() {
    ///Initialize variables
  }

  bool get hasReachedMax {
    return page >= totalPages.value;
  }
}
