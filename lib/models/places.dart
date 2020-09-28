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
    city: 'Venice',
    country: 'Italy',
    description: 'Visit Venice for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/index.jpeg',
    city: 'Paris',
    country: 'France',
    description: 'Visit Paris for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/building.jpeg',
    city: 'New Delhi',
    country: 'India',
    description: 'Visit New Delhi for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/beechwood-home.jpg',
    city: 'Sao Paulo',
    country: 'Brazil',
    description: 'Visit Sao Paulo for an amazing and unforgettable adventure.',
  ),
  Places(
    imageUrl: 'assets/images/building2.jpg',
    city: 'New York City',
    country: 'United States',
    description: 'Visit New York for an amazing and unforgettable adventure.',
  ),
];
