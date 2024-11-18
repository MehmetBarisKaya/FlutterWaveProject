enum ProductServicePath {
  getAllProduct('/urunler/tumUrunleriGetir.php'),
  addProductToCart('/urunler/sepeteUrunEkle.php'),
  getAllProductFromCart('/urunler/sepettekiUrunleriGetir.php'),
  deleteProductFromCart('/urunler/sepettenUrunSil.php');

  const ProductServicePath(this.value);
  final String value;

  String withQuery(String value) {
    return '${this.value}/$value';
  }
}
