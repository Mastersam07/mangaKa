import 'dart:async';
import 'package:komikkurida/models/mangaDetails.dart';
import 'package:komikkurida/networking/api_response.dart';
import 'package:komikkurida/repository/manga_detail_repository.dart';

class MangaDetailBloc {
  MangaDetailRepository _mangaDetailRepository;

  StreamController _mangaDetailController;

  StreamSink<ApiResponse<MangaDetails>> get mangaDetailSink =>
      _mangaDetailController.sink;

  Stream<ApiResponse<MangaDetails>> get mangaDetailStream =>
      _mangaDetailController.stream;

  MangaDetailBloc(selectedManga) {
    _mangaDetailController = StreamController<ApiResponse<MangaDetails>>();
    _mangaDetailRepository = MangaDetailRepository();
    fetchMangaDetail(selectedManga);
  }

  fetchMangaDetail(String selectedManga) async {
    mangaDetailSink.add(ApiResponse.loading('Fetching Manga Details'));
    try {
      MangaDetails details =
          await _mangaDetailRepository.fetchMangaDetail(selectedManga);
      mangaDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      mangaDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _mangaDetailController?.close();
  }
}
