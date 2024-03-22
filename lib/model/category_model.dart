class CategoryModel {
  final String? id;
  final String name;
  final String? orderPrintStationId;
  final String? noSeriesPrefix;
  final String? prefixFormat;
  final String? image;
  final String? printStationName;
  final double bronzeDiscount;
  final double silverDiscount;
  final double goldDiscount;
  final double platinumDiscount;
  final bool showPos;

  CategoryModel({
    this.id,
    required this.name,
    this.orderPrintStationId,
    required this.noSeriesPrefix,
    required this.prefixFormat,
    this.image,
    this.printStationName,
    required this.bronzeDiscount,
    required this.silverDiscount,
    required this.goldDiscount,
    required this.platinumDiscount,
    required this.showPos,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'],
      orderPrintStationId: json['order_print_station_id'],
      noSeriesPrefix: json['no_series_prefix'],
      prefixFormat: json['prefix_format'],
      image: json['image'],
      printStationName: json['print_station_name'],
      bronzeDiscount: double.parse(json['bronze_discount'].toString()),
      silverDiscount: double.parse(json['silver_discount'].toString()),
      goldDiscount: double.parse(json['gold_discount'].toString()),
      platinumDiscount: double.parse(json['platinum_discount'].toString()),
      showPos: json['show_pos'].toString() == "1" ? true : false,
    );
  }
}
