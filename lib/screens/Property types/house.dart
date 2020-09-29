import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HouseScreen extends StatefulWidget {
  @override
  _HouseScreenState createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColorLight),
        child: Column(
          children: [
            ImageSlider(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [Container()],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext contextn, int index) {
        return Image.asset(
          bestDeals[index].image,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          fit: BoxFit.cover,
        );
      },
      itemCount: bestDeals.length,
      viewportFraction: 0.8,
      itemHeight: MediaQuery.of(context).size.height / 2,
      itemWidth: MediaQuery.of(context).size.width,
      pagination: SwiperPagination(
        margin: EdgeInsets.all(50),
      ),
      autoplay: true,
      layout: SwiperLayout.TINDER,
    );
  }
}
