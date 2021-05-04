import '../../ui/views/anime/anime_home.dart';
import '../../ui/views/home/apphome.dart';
import '../../ui/views/download/downloads.dart';
import '../../ui/views/manga/manga_home.dart';
import '../../ui/views/settings.dart';
import 'base_viewmodel.dart';

class NavigationViewModel extends BaseModel {
  int _pageIndex = 0;
  int get page => _pageIndex;

  var pages = [
    AppHomeScreen(),
    const AnimeHomeScreen(),
    const MangaHomeScreen(),
    const DownloadsScreen(),
    const SettingsScreen(),
  ];

  void changePage(int i) {
    _pageIndex = i;
    notifyListeners();
  }
}
