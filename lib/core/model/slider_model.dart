class SliderModel {
  String? image;
  String? text;
  String? altText;
  String? bAltText;
  String? productImage;
  int? kBackgroundColor;

  SliderModel(this.image, this.text, this.altText, this.bAltText,
      this.productImage, this.kBackgroundColor);

  SliderModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    kBackgroundColor = json['kBackgroundColor'];
    text = json['text'];
    altText = json['altText'];
    bAltText = json['bAltText'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['kBackgroundColor'] = kBackgroundColor;
    data['text'] = text;
    data['altText'] = altText;
    data['bAltText'] = bAltText;
    data['productImage'] = productImage;
    return data;
  }
}

List<SliderModel> slides =
    slideData.map((item) => SliderModel.fromJson(item)).toList();

var slideData = [
  {
    "image": "asset/slides/background-1.jpeg",
    "kBackgroundColor": 0xFF2c614f,
    "text": "Welcome to the Smart Smart Admin Dashboard!",
    "altText": "You can access & track your services in real-time.",
    "bAltText": "Are you ready for the next generation AI supported Dashboard?",
    "productImage": "asset/images/mockup.png"
  },
  {
    "image": "asset/slides/background-2.jpeg",
    "kBackgroundColor": 0xFF8a1a4c,
    "text": "¡Bienvenido al tablero Smart Admin Dashboard!",
    "altText": "Puede acceder y rastrear sus servicios en tiempo real.",
    "bAltText":
        "¿Estás listo para el panel de control impulsado por IA de próxima generación?",
    "productImage": "asset/images/mockup-2.png"
  },
  {
    "image": "asset/slides/background-3.jpeg",
    "kBackgroundColor": 0xFF0ab3ec,
    "text": "Willkommen im Smart Admin Dashboard!",
    "altText":
        "Sie können in Echtzeit auf Ihre Dienste zugreifen und diese verfolgen.",
    "bAltText":
        "Sind Sie bereit für das AI-unterstützte Dashboard der nächsten Generation?",
    "productImage": "asset/images/mockup-3.png"
  }
];
