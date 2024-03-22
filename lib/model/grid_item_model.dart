class DashboardMenuModel {
  final bool permission;
  final String imagePath;
  final String label;
  final String navigationPath;

  DashboardMenuModel(
      {required this.permission,
      required this.navigationPath,
      required this.imagePath,
      required this.label});
}
