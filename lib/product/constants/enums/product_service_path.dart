enum ProductServicePath {
  getAllProduct('/urunler/tumUrunleriGetir.php');

  const ProductServicePath(this.value);
  final String value;

  String withQuery(String value) {
    return '${this.value}/$value';
  }
}
