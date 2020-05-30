import 'package:komikkurida/models/mangaDetails.dart';
import 'package:komikkurida/networking/api_base_helper.dart';

class MangaDetailRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<MangaDetails> fetchMangaDetail(String selectedManga) async {
    final response = await _helper.get("manga/$selectedManga");
    return MangaDetails.fromJson(response);
  }
}
