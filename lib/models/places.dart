class Places {
  String imageUrl;
  String city;
  String country;
  String description;

  Places({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
  });
}

List<Places> destinations = [
  Places(
    imageUrl: 'assets/images/beechwood-home.jpg',
    city: 'Hotels',
    country: 'Italy',
    description: 'Visit Venice for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/index.jpeg',
    city: 'Apartments',
    country: 'France',
    description: 'Visit Paris for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/building.jpeg',
    city: 'villa',
    country: 'India',
    description: 'Visit New Delhi for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/beechwood-home.jpg',
    city: 'house',
    country: 'Brazil',
    description: 'Visit Sao Paulo for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/building2.jpg',
    city: 'office',
    country: 'United States',
    description: 'Visit New York for an amazing and unforgettable adventure.',
  ),
];
