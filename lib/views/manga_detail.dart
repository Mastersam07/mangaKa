import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:komikkurida/blocs/manga_detail_bloc.dart';
import 'package:komikkurida/models/mangaDetails.dart';
import 'package:komikkurida/networking/api_response.dart';

class MangaDetail extends StatefulWidget {
  final String selectedManga;
  const MangaDetail(this.selectedManga);

  @override
  _MangaDetailState createState() => _MangaDetailState();
}

class _MangaDetailState extends State<MangaDetail> {
  MangaDetailBloc _mangaDetailBloc;

  @override
  void initState() {
    super.initState();
    _mangaDetailBloc = MangaDetailBloc(widget.selectedManga);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Icon(Icons.search),
        ],
        title: Text(
          'MangaX',
          style: TextStyle(
//            color: Colors.white,
            fontSize: 20,
          ),
        ),
//        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Colors.black54,
      body: RefreshIndicator(
        onRefresh: () =>
            _mangaDetailBloc.fetchMangaDetail(widget.selectedManga),
        child: StreamBuilder<ApiResponse<MangaDetails>>(
          stream: _mangaDetailBloc.mangaDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return ShowMangaDetail(displayManga: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        _mangaDetailBloc.fetchMangaDetail(widget.selectedManga),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mangaDetailBloc.dispose();
    super.dispose();
  }
}

class ShowMangaDetail extends StatelessWidget {
  final MangaDetails displayManga;

  ShowMangaDetail({Key key, this.displayManga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        displayManga.image != null
            ? Image.network(
                'https://cdn.mangaeden.com/mangasimg/${displayManga.image}',
                fit: BoxFit.fill,
              )
            : Image.network(
                'https://wallup.net/wp-content/uploads/2017/10/25/487437-anime_girls-404_Not_Found-glowing_eyes.jpg',
                fit: BoxFit.fill,
              ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 400.0,
                    height: 400.0,
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    image: new DecorationImage(
                        image: displayManga.image != null
                            ? NetworkImage(
                                'https://cdn.mangaeden.com/mangasimg/${displayManga.image}',
//                          fit: BoxFit.fill,
                              )
                            : NetworkImage(
                                'https://wallup.net/wp-content/uploads/2017/10/25/487437-anime_girls-404_Not_Found-glowing_eyes.jpg',
//                          fit: BoxFit.fill,
                              ),
                        fit: BoxFit.cover),
                    boxShadow: [
                      new BoxShadow(
//                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: new Offset(0.0, 10.0))
                    ],
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                        displayManga.description,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'Arvo'),
                      )),
                      new Text(
                        (displayManga.hits).toString(),
//                      '${widget.movie['vote_average']}/10',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Arvo'),
                      )
                    ],
                  ),
                ),
                new Text(displayManga.title,
                    style:
                        new TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Container(
                      width: 150.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      child: new Text(
                        'Rate Movie',
                        style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arvo',
                            fontSize: 20.0),
                      ),
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          color: const Color(0xaa3C3261)),
                    )),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: new Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                    new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: new Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
              style: TextStyle(
//                color: Colors.white,
                  ),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
//              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
