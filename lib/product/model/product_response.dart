import 'package:equatable/equatable.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse with EquatableMixin {
  List<Product>? urunler;
  int? success;

  ProductResponse({
    this.urunler,
    this.success,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

  @override
  List<Object?> get props => [urunler, success];

  ProductResponse copyWith({
    List<Product>? urunler,
    int? success,
  }) {
    return ProductResponse(
      urunler: urunler ?? this.urunler,
      success: success ?? this.success,
    );
  }
}
