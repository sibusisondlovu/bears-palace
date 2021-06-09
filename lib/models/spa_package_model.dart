class SpaPackageModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String serviceImageUrl;
  final String unitOfMeasurement;
  final int serviceCategoryId;
  final int qty;

  SpaPackageModel(
      this.id,
      this.title,
      this.description,
      this.price,
      this.serviceCategoryId,
      this.serviceImageUrl,
      this.qty,
      this.unitOfMeasurement);
}
