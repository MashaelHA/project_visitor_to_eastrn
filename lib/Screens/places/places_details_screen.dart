// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../../data/firebaseauth.dart';
import '../../models/place.dart';
import '../../data/app_data.dart';
import '../../utils/app_export.dart';
import '../../utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesDetails extends StatefulWidget {
  // const PlacesDetails({Key? key}) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;
  final PlaceType placeType;

  const PlacesDetails({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.placeType,
  });

  @override
  State<PlacesDetails> createState() => _PlacesDetailsState();
}

bool isloading = false;
bool isfavorteitem = true;
Firebaseauth _controller = Firebaseauth();

class _PlacesDetailsState extends State<PlacesDetails> {
  @override
  void initState() {
    isFavorite();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isloading = true;
      });
    });
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  isFavorite() {
    setState(() {
      _controller.isFavorite(widget.id).then((value) {
        isfavorteitem = !value;
        // ignore: avoid_print
        print("value is");
        // ignore: avoid_print
        print(isfavorteitem);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final SelectedPlaces =
        PlaceType_data.firstWhere((place) => place.id == widget.id);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text(widget.title)],
        ),
        backgroundColor: kPrimaryColor.withOpacity(0.5),
        toolbarHeight: 40,
      ),
      backgroundColor: ColorConstant.fromHex('#f9f9f9'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getVerticalSize(
                      435.00,
                    ),
                    width: getHorizontalSize(
                      376.00,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: getVerticalSize(
                              26.00,
                            ),
                            width: getHorizontalSize(
                              281.00,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorConstant.fromHex('#7f2a3c4c')
                                        .withOpacity(0.4),
                                    ColorConstant.fromHex('#7f2a3c4c')
                                        .withOpacity(0.1),
                                  ],
                                  stops: const [
                                    0.2,
                                    0.005
                                  ]),
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  13.00,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: getVerticalSize(
                              421.00,
                            ),
                            width: getHorizontalSize(
                              376.00,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                        getHorizontalSize(
                                          32.00,
                                        ),
                                      ),
                                      bottomRight: Radius.circular(
                                        getHorizontalSize(
                                          32.00,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Image.network(
                                    SelectedPlaces.imageUrlPlace,
                                    height: getVerticalSize(
                                      421.00,
                                    ),
                                    width: getHorizontalSize(
                                      376.00,
                                    ),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 19,
                      top: 16,
                      right: 21,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: SelectedPlaces.title,
                                      style: TextStyle(
                                        color: ColorConstant.fromHex('#1e1c66'),
                                        fontSize: getFontSize(
                                          28,
                                        ),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        height: getVerticalSize(
                                          1.11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: getPadding(top: 3, right: 5),
                                    child: IconButton(
                                      // ignore: deprecated_member_use
                                      onPressed: () =>
                                          // ignore: deprecated_member_use
                                          launch(SelectedPlaces.mapUrl),
                                      icon: const Icon(
                                        Icons.location_on_outlined,
                                        color: SecondaryYellow,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    SelectedPlaces.cityName,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        isloading
                            ? InkWell(
                                onTap: () {
                                  if (!isfavorteitem) {
                                    _controller.addtofavorite(widget.id);

                                    setState(() {
                                      isloading = false;
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        isFavorite();
                                      });
                                      Future.delayed(const Duration(seconds: 4),
                                          () {
                                        setState(() {
                                          isloading = true;
                                        });
                                      });
                                    });
                                  } else {
                                    _controller.deletefromfavorite(widget.id);
                                    setState(() {
                                      isloading = false;
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        isFavorite();
                                      });
                                    });
                                    Future.delayed(const Duration(seconds: 4),
                                        () {
                                      setState(() {
                                        isloading = true;
                                      });
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: getPadding(
                                    top: 5,
                                    left: 5,
                                  ),
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor:
                                        SecondaryPink.withOpacity(0.2),
                                    child: Icon(
                                      Icons.favorite,
                                      color: isfavorteitem
                                          ? Colors.red
                                          : Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            // ignore: prefer_const_constructors
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getHorizontalSize(
                      322.00,
                    ),
                    child: Text(
                      SelectedPlaces.description[0],
                      maxLines: null,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  // ),
                  Container(
                    width: getHorizontalSize(
                      378.00,
                    ),
                    margin: getMargin(
                      top: 26,
                    ),
                    padding: getPadding(
                      left: 33,
                      top: 15,
                      right: 33,
                      bottom: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: getHorizontalSize(
                            309.00,
                          ),
                          margin: getMargin(
                            bottom: 57,
                          ),
                          padding: getPadding(
                            left: 30,
                            // top: 30,
                            right: 30,
                            bottom: 12,
                          ),
                          child: SizedBox(
                            width: 500,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                backgroundColor: SecondaryPink,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('أضف إلى الخطة',
                                  style: TextStyle(
                                      fontSize:
                                          20) //Theme.of(context).textTheme.subtitle2,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
