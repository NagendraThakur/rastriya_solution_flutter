class PrintStationModel {
  final String? id;
  final String? printTitle;
  final String? doubleCopy;
  final String? printerName;
  final String? orderPrintSizeInInch;
  final String? endGapSizeInInch;

  PrintStationModel({
    this.id,
    this.printTitle,
    this.doubleCopy,
    this.printerName,
    this.orderPrintSizeInInch,
    this.endGapSizeInInch,
  });

  Map<String, dynamic> toJson() {
    return {
      'print_title': printTitle,
      'double_copy': doubleCopy,
      'printer_name': printerName,
      'order_print_size': orderPrintSizeInInch,
      'end_gap_size': endGapSizeInInch,
    };
  }

  factory PrintStationModel.fromJson(Map<String, dynamic> json) {
    return PrintStationModel(
      id: json['id'].toString(),
      printTitle: json['print_title'],
      doubleCopy: json['double_copy'].toString(),
      printerName: json['printer_name'],
      orderPrintSizeInInch: json['order_print_size_in_inch'].toString(),
      endGapSizeInInch: json['end_gap_size_in_inch'].toString(),
    );
  }
}
