class MangaResponse {
  List<Manga> results;

  MangaResponse({this.results});

  MangaResponse.fromJson(Map<String, dynamic> json) {
    if (json['manga'] != null) {
      results = new List<Manga>();
      json['manga'].forEach((v) {
        results.add(new Manga.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manga {
  String image;
  String title;
  String id;
  String alias;
  int status;
  int hits;

  Manga(this.image, this.title, this.id, this.alias, this.status, this.hits);


  Manga.fromJson(Map<String, dynamic> json) {
    image = json['im'];
    title = json['t'];
    id = json['i'];
    alias = json['a'];
    status = json['s'];
    hits = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['im'] = this.image;
    data['t'] = this.title;
    data['i'] = this.id;
    data['a'] = this.alias;
    data['s'] = this.status;
    data['h'] = this.hits;
    return data;
  }
}
