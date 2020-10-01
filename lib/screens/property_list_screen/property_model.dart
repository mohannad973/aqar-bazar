import 'package:flutter/material.dart';

class PropertyModel{
  String _image,_name,_description,_location;
  int _numberOfBedRooms,_numberOfBathrooms;
  double _price,_rating;

  PropertyModel(
      this._image,
      this._name,
      this._description,
      this._location,
      this._numberOfBedRooms,
      this._numberOfBathrooms,
      this._price,
      this._rating);
}