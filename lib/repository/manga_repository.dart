import 'package:komikkurida/models/manga.dart';
import 'package:komikkurida/networking/api_base_helper.dart';

class MangaRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Manga>> fetchMangaList() async {
    final response = await _helper.get("list/0/");
    return MangaResponse.fromJson(response).results;
  }
}
