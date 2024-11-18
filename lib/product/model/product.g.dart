// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      ad: json['ad'] as String?,
      resim: json['resim'] as String?,
      kategori: json['kategori'] as String?,
      fiyat: (json['fiyat'] as num?)?.toInt(),
      marka: json['marka'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'ad': instance.ad,
      'resim': instance.resim,
      'kategori': instance.kategori,
      'fiyat': instance.fiyat,
      'marka': instance.marka,
    };
