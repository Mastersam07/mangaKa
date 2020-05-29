import 'dart:async';
import 'package:komikkurida/models/manga.dart';
import 'package:komikkurida/networking/api_response.dart';
import 'package:komikkurida/repository/manga_repository.dart';

class MangaBloc {
  MangaRepository _mangaRepository;

  StreamController _mangaListController;

  StreamSink<ApiResponse<List<Manga>>> get mangaListSink =>
      _mangaListController.sink;

  Stream<ApiResponse<List<Manga>>> get movieListStream =>
      _mangaListController.stream;

  MangaBloc() {
    _mangaListController = StreamController<ApiResponse<List<Manga>>>();
    _mangaRepository = MangaRepository();
    fetchMangaList();
  }

  fetchMangaList() async {
    mangaListSink.add(ApiResponse.loading('Fetching Movies'));
    try {
      List<Manga> movies = await _mangaRepository.fetchMangaList();
      mangaListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      mangaListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _mangaListController?.close();
  }
}