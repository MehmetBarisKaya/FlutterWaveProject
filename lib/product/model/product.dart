import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product with EquatableMixin {
  int? id;
  String? ad;
  String? resim;
  String? kategori;
  int? fiyat;
  String? marka;

  Product({
    this.id,
    this.ad,
    this.resim,
    this.kategori,
    this.fiyat,
    this.marka,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, ad, resim, kategori, fiyat, marka];

  Product copyWith({
    int? id,
    String? ad,
    String? resim,
    String? kategori,
    int? fiyat,
    String? marka,
  }) {
    return Product(
      id: id ?? this.id,
      ad: ad ?? this.ad,
      resim: resim ?? this.resim,
      kategori: kategori ?? this.kategori,
      fiyat: fiyat ?? this.fiyat,
      marka: marka ?? this.marka,
    );
  }
}
