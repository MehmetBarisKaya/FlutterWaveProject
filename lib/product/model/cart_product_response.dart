import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_product_response.g.dart';

@JsonSerializable()
final class CartProductResponse with EquatableMixin {
  @JsonKey(name: "urunler_sepeti")
  final List<CartProduct>? urunlerSepeti;
  final int? success;

  CartProductResponse({
    this.urunlerSepeti,
    this.success,
  });

  factory CartProductResponse.fromJson(Map<String, dynamic> json) =>
      _$CartProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductResponseToJson(this);

  @override
  List<Object?> get props => [urunlerSepeti, success];

  CartProductResponse copyWith({
    List<CartProduct>? urunlerSepeti,
    int? success,
  }) {
    return CartProductResponse(
      urunlerSepeti: urunlerSepeti ?? this.urunlerSepeti,
      success: success ?? this.success,
    );
  }
}

@JsonSerializable()
class CartProduct with EquatableMixin {
  int? sepetId;
  String? ad;
  String? resim;
  String? kategori;
  int? fiyat;
  String? marka;
  int? siparisAdeti;
  String? kullaniciAdi;

  CartProduct({
    this.sepetId,
    this.ad,
    this.resim,
    this.kategori,
    this.fiyat,
    this.marka,
    this.siparisAdeti,
    this.kullaniciAdi,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);

  @override
  List<Object?> get props =>
      [sepetId, ad, resim, kategori, fiyat, marka, siparisAdeti, kullaniciAdi];

  CartProduct copyWith({
    int? sepetId,
    String? ad,
    String? resim,
    String? kategori,
    int? fiyat,
    String? marka,
    int? siparisAdeti,
    String? kullaniciAdi,
  }) {
    return CartProduct(
      sepetId: sepetId ?? this.sepetId,
      ad: ad ?? this.ad,
      resim: resim ?? this.resim,
      kategori: kategori ?? this.kategori,
      fiyat: fiyat ?? this.fiyat,
      marka: marka ?? this.marka,
      siparisAdeti: siparisAdeti ?? this.siparisAdeti,
      kullaniciAdi: kullaniciAdi ?? this.kullaniciAdi,
    );
  }
}
