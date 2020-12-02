import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/add_to_fav_provider.dart';
import 'package:aqar_bazar/providers/favourites_provider.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:provider/provider.dart';

class DealsCard extends StatelessWidget {
  //final Hotel hotel;
  final Datum propertyData;
  final bool fav;

  const DealsCard({Key key, this.propertyData, this.fav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('fav deal ' + (fav == null).toString());
    Locale myLocale = Localizations.localeOf(context);
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: wight,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 140,
        child: Row(
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: myLocale.toString() == 'ar_AE'
                      ? BorderRadius.only(
                          topRight: Radius.circular(18),
                          bottomRight: Radius.circular(18))
                      : BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18)),
                  image: DecorationImage(
                    image: NetworkImage(propertyData.thumbnail),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: AutoSizeText(
                          propertyData.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                        width: width * 0.5,
                      ),
                      (fav == null)
                          ? Container()
                          :
                      Provider.of<AddToFavProvider>(context,listen: false).isLoading()?CircularProgressIndicator(backgroundColor: fBlue,):
                      Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: GestureDetector(
                                  onTap: () async{
                                    print('is loading '+ Provider.of<AddToFavProvider>(context,listen: false).isLoading().toString());
                                    bool removed =await Provider.of<AddToFavProvider>(context,listen: false).addToFav(propertyData.id.toString());
                                    int index = Provider.of<FavouritesProvider>(context,listen:false).data.indexOf(propertyData);
                                    if(removed){
                                      print('index str'+index.toString());
                                      _showToast(context);
                                      Provider.of<FavouritesProvider>(context,listen: false).removeElement(index);
                                    }
                                  },
                                  child: Icon(CupertinoIcons.delete)),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.location),
                              Container(
                                child: AutoSizeText(
                                  propertyData.address,
                                  style: TextStyle(color: labelColor),
                                  maxLines: 1,
                                ),
                                width: width * 0.3,
                              )
                            ],
                          ),
                          RatingBar(
                            initialRating: propertyData.rate.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: darkBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: AutoSizeText('\$${propertyData.price}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              width: width * 0.2,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


void _showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Offer removed From Favourites'),
    ),
  );
}