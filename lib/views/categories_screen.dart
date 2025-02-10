import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_a/models/categories_new_model.dart';
import 'package:new_a/view_models/new_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewViewModel newViewModel = NewViewModel();
  List<String> listcategories = [
    'health',
    'bitcoin',
    'politics',
    'entertainment',
    'technology'
  ];
  final format = DateFormat('MMMM dd, yyyy');
  String categoriesName = 'health';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listcategories.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          categoriesName = listcategories[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: categoriesName == listcategories[index]
                                  ? Colors.black
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                  child: Text(
                                listcategories[index].toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                        ),
                      )),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<CategoriesNewModel>(
                future: newViewModel.fetchCategoryNewModelApi(categoriesName),
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
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime datetime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Container(
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
                                    errorWidget: (context, url, error) =>
                                        Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                    fontWeight:
                                                        FontWeight.w400),
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
            ),
          ],
        ),
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.black,
);
