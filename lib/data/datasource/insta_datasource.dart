
class InstaDatasource {
  final _imgBase = 'https://yavuzceliker.github.io/sample-images/image-';

  Future<String> getImageUrl(int n) async{
    return '$_imgBase$n.jpg';
  }
}