import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_a/models/categories_new_model.dart';
import 'package:new_a/models/new_channel_headline_model.dart';
import 'package:new_a/view_models/new_view_model.dart';
import 'package:new_a/views/categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  nbcnews,
  cnn,
  foxnews,
  aftenposten,
  argaam,
}

class _HomeScreenState extends State<HomeScreen> {
  NewViewModel newViewModel = NewViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'nbc-news';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final response = await newViewModel.fetchNewChannelHeadlinesApi(name);
    print('dat fetchNewChannelHeadlinesAp $response  ');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
            },
            icon: Image.asset(
              'images/category_icon.png',
              width: 20,
              height: 20,
            )),
        title: Center(
          child: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem(
                value: FilterList.nbcnews,
                child: Text('BBC News'),
              ),
              PopupMenuItem(
                value: FilterList.cnn,
                child: Text('CNN'),
              ),
              PopupMenuItem(
                value: FilterList.foxnews,
                child: Text('Fox News'),
              ),
              PopupMenuItem(
                value: FilterList.aftenposten,
                child: Text('Aftenposten'),
              ),
              PopupMenuItem(
                value: FilterList.argaam,
                child: Text('Argaam'),
              ),
            ],
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert),
            onSelected: (FilterList item) {
              if (FilterList.nbcnews.name == item.name) {
                name = 'bbcNews';
              }
              if (FilterList.cnn.name == item.name) {
                name = 'cnn';
              }
              if (FilterList.foxnews.name == item.name) {
                name = 'foxnews';
              }

              if (FilterList.aftenposten.name == item.name) {
                name = 'aftenposten';
              }
              if (FilterList.argaam.name == item.name) {
                name = 'argaam';
              }
              setState(() {
                selectedMenu = item;
              });
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewChanelHeadlineModel>(
              future: newViewModel.fetchNewChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.articles?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime datetime = DateTime.parse(
                          snapshot.data.articles[0].publishedAt.toString());
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: width * .9,
                              height: height * .5,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles[index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Container(child: spinkit2),
                                  errorWidget: (context, url, error) =>
                                      SizedBox(
                                    child: Icon(Icons.error_outline,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: height * .2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        width: width * .75,
                                        child: Text(
                                          snapshot.data!.articles[index].title
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles[index]
                                                  .source.name
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 100,
                                            ),
                                            Text(
                                              format.format(datetime),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<CategoriesNewModel>(
            future: newViewModel.fetchCategoryNewModelApi('health'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitCircle(
                    size: 50,
                    color: Colors.black,
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime datetime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    return SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * 0.2,
                                width: width * 0.3,
                                placeholder: (context, url) =>
                                    Container(child: spinkit2),
                                errorWidget: (context, url, error) => Container(
                                  child: Icon(Icons.error_outline,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            format.format(datetime),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.black,
);
