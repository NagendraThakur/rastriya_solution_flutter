class IrdInfo {
  final String id;
  final String? billNo;
  final int? noOfPrint;
  final String? syncWithIrd;
  final String? printed;
  final String? isActive;
  final String? sync;
  final String? posted;
  final String? syncTime;
  final String? isRealtime;

  IrdInfo({
    required this.id,
    this.billNo,
    this.noOfPrint,
    this.syncWithIrd,
    this.printed,
    this.isActive,
    this.sync,
    this.posted,
    this.syncTime,
    this.isRealtime,
  });

  factory IrdInfo.fromJson(Map<String, dynamic> json) {
    return IrdInfo(
      id: json['id'].toString(),
      billNo: json['bill_no'].toString(),
      noOfPrint: int.parse(json['no_of_print'].toString()),
      syncWithIrd: json['sync_with_ird'].toString(),
      printed: json['printed'].toString(),
      isActive: json['is_active'].toString(),
      sync: json['sync'].toString(),
      posted: json['posted'].toString(),
      syncTime: json['sync_time'].toString(),
      isRealtime: json['is_realtime'].toString(),
    );
  }
}
