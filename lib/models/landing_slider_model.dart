class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImagePath(String getImagePath) {
    imagePath = getImagePath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImagePath() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();
  sliderModel = new SliderModel();
  sliderModel.setImagePath("assets/images/house.png");
  sliderModel.setTitle('Plan your trips');
  sliderModel.setDesc('Book a hotel that suits your mood');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setImagePath("assets/images/landing/travelling3.jpg");
  sliderModel.setTitle('Start exploring');
  sliderModel.setDesc(
      'Life has a lot of mysteries,start unlocking new areas and new adventures');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setImagePath("assets/images/landing/illustration3.png");
  sliderModel.setTitle('Find best Deals');
  sliderModel.setDesc(
      'Looking for a week on getaway beach? maybe You want to ski on a snowy mountain? You think it and we\'ll find it');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
