import 'package:pbp_2_restaurant/model/chart.dart';

String getSubTotal(List<toChart> products) {
  return products
      .fold(0.0,
          (double prev, element) => prev + (element.quantity! * element.price!))
      .toStringAsFixed(2);
}
