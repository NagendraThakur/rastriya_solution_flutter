import 'package:rastriya_solution_flutter/model/batch_model.dart';
import 'package:rastriya_solution_flutter/model/stock_model.dart';

class ProductModel {
  String? id;
  String name;
  int? fired;
  double? quantity;
  String? productCode;
  String? baseUnit;
  String? barcode1;
  String? barcode2;
  String? barcode3;
  String? barcode4;
  String? productGroup;
  String? flatDiscountDateFrom;
  String? flatDiscountDateTo;
  String? remarks1;
  String? remarks2;
  String? blocked;
  double? vatPercent;
  String? discountable;
  double? discountPercentage;
  double? discountAmount;
  String? flatDiscount;
  double? lastUnitCost;
  double? lastUnitPrice;
  String? inventoryItem;
  String? sellableItem;
  String? isPos;
  String? lastVendorCode;
  String? brandId;
  String? modelYearId;
  String? mrp;
  String? otherUnitId;
  String? otherUnitFactor;
  String? profitPercent;
  String? printName;
  String? productDetail;
  String? createdAt;
  String? updatedAt;
  String? categoryName;
  String? baseUnitName;
  String? color;
  BatchModel? batch;
  String? printStationId;
  bool? selected;
  String? review;
  String? batchLot;
  StockModel? stockInfo;

  ProductModel({
    this.id,
    required this.name,
    this.fired,
    this.quantity,
    this.productCode,
    this.baseUnit,
    this.barcode1,
    this.barcode2,
    this.barcode3,
    this.barcode4,
    this.productGroup,
    this.flatDiscountDateFrom,
    this.flatDiscountDateTo,
    this.remarks1,
    this.remarks2,
    this.blocked,
    this.vatPercent,
    this.discountable,
    this.discountPercentage,
    this.discountAmount,
    this.flatDiscount,
    this.lastUnitCost,
    this.lastUnitPrice,
    this.inventoryItem,
    this.sellableItem,
    this.isPos,
    this.lastVendorCode,
    this.brandId,
    this.modelYearId,
    this.mrp,
    this.otherUnitId,
    this.otherUnitFactor,
    this.profitPercent,
    this.printName,
    this.productDetail,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.baseUnitName,
    this.color,
    this.batch,
    this.printStationId,
    this.selected = true,
    this.review,
    this.batchLot,
    this.stockInfo,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      fired: json['fired'] ?? 0,
      quantity: json['quantity'] != null
          ? (double.parse(json['quantity'].toString()))
          : 0,
      productCode: json['product_code']?.toString(),
      baseUnit: json['base_unit']?.toString(),
      barcode1: json['barcode1']?.toString(),
      barcode2: json['barcode2']?.toString(),
      barcode3: json['barcode3']?.toString(),
      barcode4: json['barcode4']?.toString(),
      productGroup: json['product_group']?.toString(),
      flatDiscountDateFrom: json['flat_discount_date_from']?.toString(),
      flatDiscountDateTo: json['flat_discount_date_to']?.toString(),
      remarks1: json['remarks1']?.toString(),
      remarks2: json['remarks2']?.toString(),
      blocked: json['blocked']?.toString(),
      vatPercent: json['vat_percent'] != null
          ? (double.parse(json['vat_percent'].toString()))
          : 0,
      discountable: json['discountable']?.toString(),
      discountPercentage: json['discount_percent'] != null
          ? (double.parse(json['discount_percent'].toString()))
          : 0,
      discountAmount: json['discount_amount'] != null
          ? (double.parse(json['discount_amount'].toString()))
          : 0,
      flatDiscount: json['flat_discount']?.toString(),
      lastUnitCost: json['last_unit_cost'] != null
          ? (double.parse(json['last_unit_cost'].toString()))
          : 0,
      lastUnitPrice: json['last_unit_price'] != null
          ? (double.parse(json['last_unit_price'].toString()))
          : 0,
      inventoryItem: json['inventory_item']?.toString(),
      sellableItem: json['sellable_item']?.toString(),
      isPos: json['is_pos']?.toString(),
      lastVendorCode: json['last_vendor_code']?.toString(),
      brandId: json['brand_id']?.toString(),
      modelYearId: json['model_year_id']?.toString(),
      mrp: json['mrp']?.toString(),
      otherUnitId: json['other_unit_id']?.toString(),
      otherUnitFactor: json['other_unit_factor']?.toString(),
      profitPercent: json['profit_percent']?.toString(),
      printName: json['print_name']?.toString(),
      productDetail: json['product_detail']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      categoryName: json['category_name']?.toString(),
      baseUnitName: json['base_unit_name']?.toString(),
      color: json['color']?.toString(),
      batch: json['batch'] != null ? BatchModel.fromJson(json['batch']) : null,
      printStationId: json['print_station_id'] != null
          ? json['print_station_id'].toString()
          : null,
      batchLot: json['batch_lot'].toString(),
      stockInfo: json['stock_info'] != null
          ? StockModel.fromJson(json['stock_info'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    // amount is the multiple of qunatity and lastUnitPrice i.e. rate in case of retail
    double calculatedAmount = quantity! * lastUnitPrice!;
    double calculatedDiscountAmount =
        calculatedAmount * (discountPercentage ?? 0) / 100;
    return {
      'product_code': id,
      'name': name,
      'fired': fired ?? 0,
      'quantity': quantity,
      'rate': lastUnitPrice,
      "rate_before_vat": 0.0, // no calculation needed
      'amount': calculatedAmount,
      'amount_before_vat': 0.0, // no calculation needed
      "discount_percent": discountPercentage, //calculate
      "discount_percentage": discountPercentage, //same as discount_percent
      "discount_amount": discountAmount ?? calculatedDiscountAmount, //calculate
      "discount_amount_before_vat": 0.0, // no calculate
      'net_amount': calculatedAmount -
          calculatedDiscountAmount, //(quantity! * lastUnitPrice!) - discount amount
      "net_amount_before_vat": 0.0, // no calculation
      "vat_amount": 0.0, // no calculation
      "vat_rate": vatPercent,
      'unit': baseUnit,
      'barcode1': barcode1,
      'barcode2': barcode2,
      'barcode3': barcode3,
      'barcode4': barcode4,
      'product_group': productGroup,
      'flat_discount_date_from': flatDiscountDateFrom,
      'flat_discount_date_to': flatDiscountDateTo,
      'remarks1': remarks1,
      'remarks2': remarks2,
      'blocked': blocked,
      'vat_percent': vatPercent,
      'discountable': discountable,
      'flat_discount': flatDiscount,
      'last_unit_cost': lastUnitCost,
      'inventory_item': inventoryItem,
      'sellable_item': sellableItem,
      'is_pos': isPos,
      'last_vendor_code': lastVendorCode,
      'brand_id': brandId,
      'model_year_id': modelYearId,
      'mrp': mrp,
      'other_unit_id': otherUnitId,
      'other_unit_factor': otherUnitFactor,
      'profit_percent': profitPercent,
      'print_name': printName,
      'product_detail': productDetail,
      'category_name': categoryName,
      'base_unit_name': baseUnitName,
      'color': color,
      'print_station_id': printStationId,
      'selected': selected,
      'review': review ?? "",
      'batch_lot': batchLot
    };
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.batch == batch;
  }

  @override
  int get hashCode {
    return id.hashCode ^ batch.hashCode;
  }

  ProductModel copyWith({
    String? id,
    String? name,
    double? quantity,
    int? fired,
    String? review,
    String? productCode,
    String? baseUnit,
    String? barcode1,
    String? barcode2,
    String? barcode3,
    String? barcode4,
    String? productGroup,
    String? flatDiscountDateFrom,
    String? flatDiscountDateTo,
    String? remarks1,
    String? remarks2,
    String? blocked,
    double? vatPercent,
    String? discountable,
    double? discountPercentage,
    double? discountAmount,
    String? flatDiscount,
    double? lastUnitCost,
    double? lastUnitPrice,
    String? inventoryItem,
    String? sellableItem,
    String? isPos,
    String? lastVendorCode,
    String? brandId,
    String? modelYearId,
    String? mrp,
    String? otherUnitId,
    String? otherUnitFactor,
    String? profitPercent,
    String? printName,
    String? productDetail,
    String? createdAt,
    String? updatedAt,
    String? categoryName,
    String? baseUnitName,
    String? color,
    BatchModel? batch,
    String? printStationId,
    bool? selected,
    String? batchLot,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      fired: fired ?? fired,
      review: review ?? this.review,
      productCode: productCode ?? this.productCode,
      baseUnit: baseUnit ?? this.baseUnit,
      barcode1: barcode1 ?? this.barcode1,
      barcode2: barcode2 ?? this.barcode2,
      barcode3: barcode3 ?? this.barcode3,
      barcode4: barcode4 ?? this.barcode4,
      productGroup: productGroup ?? this.productGroup,
      flatDiscountDateFrom: flatDiscountDateFrom ?? this.flatDiscountDateFrom,
      flatDiscountDateTo: flatDiscountDateTo ?? this.flatDiscountDateTo,
      remarks1: remarks1 ?? this.remarks1,
      remarks2: remarks2 ?? this.remarks2,
      blocked: blocked ?? this.blocked,
      vatPercent: vatPercent ?? this.vatPercent,
      discountable: discountable ?? this.discountable,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      flatDiscount: flatDiscount ?? this.flatDiscount,
      lastUnitCost: lastUnitCost ?? this.lastUnitCost,
      lastUnitPrice: lastUnitPrice ?? this.lastUnitPrice,
      inventoryItem: inventoryItem ?? this.inventoryItem,
      sellableItem: sellableItem ?? this.sellableItem,
      isPos: isPos ?? this.isPos,
      lastVendorCode: lastVendorCode ?? this.lastVendorCode,
      brandId: brandId ?? this.brandId,
      modelYearId: modelYearId ?? this.modelYearId,
      mrp: mrp ?? this.mrp,
      otherUnitId: otherUnitId ?? this.otherUnitId,
      otherUnitFactor: otherUnitFactor ?? this.otherUnitFactor,
      profitPercent: profitPercent ?? this.profitPercent,
      printName: printName ?? this.printName,
      productDetail: productDetail ?? this.productDetail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryName: categoryName ?? this.categoryName,
      baseUnitName: baseUnitName ?? this.baseUnitName,
      color: color ?? this.color,
      batch: batch ?? this.batch,
      printStationId: printStationId ?? this.printStationId,
      selected: selected ?? this.selected,
      batchLot: batchLot ?? this.batchLot,
    );
  }
}
