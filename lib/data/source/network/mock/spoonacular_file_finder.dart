/// This file helps in figuring out which file to deliver to mock API responses
/// Feel free to configure this however you would like!
class SpoonacularFileFinder {
  
  final String host = 'api.spoonacular.com';
  final String path = '/recipes/random';

  String? getJsonPath(Uri uri) {

    if(host != uri.host) return null;
    if(path != uri.path) return null;
    
    return 'spoonacular/recipes/random/first_twenty.json';
  }

}
