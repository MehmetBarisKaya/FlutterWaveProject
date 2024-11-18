// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProductResponse _$CartProductResponseFromJson(Map<String, dynamic> json) =>
    CartProductResponse(
      urunlerSepeti: (json['urunler_sepeti'] as List<dynamic>?)
          ?.map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: (json['success'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartProductResponseToJson(
        CartProductResponse instance) =>
    <String, dynamic>{
      'urunler_sepeti': instance.urunlerSepeti,
      'success': instance.success,
    };

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
      sepetId: (json['sepetId'] as num?)?.toInt(),
      ad: json['ad'] as String?,
      resim: json['resim'] as String?,
      kategori: json['kategori'] as String?,
      fiyat: (json['fiyat'] as num?)?.toInt(),
      marka: json['marka'] as String?,
      siparisAdeti: (json['siparisAdeti'] as num?)?.toInt(),
      kullaniciAdi: json['kullaniciAdi'] as String?,
    );

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'sepetId': instance.sepetId,
      'ad': instance.ad,
      'resim': instance.resim,
      'kategori': instance.kategori,
      'fiyat': instance.fiyat,
      'marka': instance.marka,
      'siparisAdeti': instance.siparisAdeti,
      'kullaniciAdi': instance.kullaniciAdi,
    };
