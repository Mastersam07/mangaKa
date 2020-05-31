import 'package:flutter/material.dart';
import 'package:komikkurida/blocs/manga_detail_bloc.dart';
import 'package:komikkurida/models/mangaDetails.dart';
import 'package:komikkurida/networking/api_response.dart';
import 'package:komikkurida/utils/rating_bar.dart';

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
          IconButton(
            icon: Icon(
              Icons.lightbulb_outline,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: null,
          ),
        ],
        title: Text(
          'MangaX',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: StreamBuilder<ApiResponse<MangaDetails>>(
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
    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: displayManga.title,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.yellow.shade900,
              child: Image(
                image: displayManga.image != null
                    ? NetworkImage(
                        'https://cdn.mangaeden.com/mangasimg/${displayManga.image}',
                      )
                    : NetworkImage(
                        'https://wallup.net/wp-content/uploads/2017/10/25/487437-anime_girls-404_Not_Found-glowing_eyes.jpg',
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        text(
          '${displayManga.chaptersLen} Chapters',
          color: Colors.black38,
          size: 12,
        )
      ],
    );

    ///detail top right
    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text('${displayManga.title}',
            size: 16, isBold: true, padding: EdgeInsets.only(top: 16.0)),
        text(
          'by ${displayManga.author}',
          color: Colors.black54,
          size: 12,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        Row(
          children: <Widget>[
            text(
              'Free',
              isBold: true,
              padding: EdgeInsets.only(right: 8.0),
            ),
            RatingBar(rating: (displayManga.hits).toDouble())
          ],
        ),
        SizedBox(height: 32.0),
        Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.blue.shade200,
          elevation: 5.0,
          child: MaterialButton(
            onPressed: () {},
            minWidth: 160.0,
            color: Colors.blue,
            child: text('READ NOW', color: Colors.white, size: 13),
          ),
        ),
      ],
    );

    final topContent = Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Text(
        displayManga.description,
        style: TextStyle(fontSize: 13.0, height: 1.5),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }

  ///create text widget
  text(String data,
          {Color color = Colors.black87,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
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
              style: TextStyle(),
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
