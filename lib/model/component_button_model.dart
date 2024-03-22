class ComponentButtonModel {
  final String svgPath;
  final String label;
  final String description;
  final String pushNamed;
  final Function()? onTap;

  ComponentButtonModel({
    required this.svgPath,
    required this.label,
    required this.description,
    required this.pushNamed,
    this.onTap,
  });
}
