import 'package:amazy_app/network/config.dart';
import 'package:amazy_app/model/Product/AllProducts.dart';
import 'package:amazy_app/model/Product/ProductModel.dart';
import 'package:amazy_app/model/NewUserZoneModel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewUserZoneController extends GetxController {
  Dio _dio = Dio();
  var isLoading = false.obs;

  var newZone = NewUserZoneModel().obs;

  var bgColor = 0.obs;

  var isNewUserProductLoading = false.obs;

  // ignore: deprecated_member_use
  var newUserProducts = List<NewUserZoneDatum>().obs;
  var brandPageNumber = 1.obs;
  var lastPage = false.obs;

  var newUserZoneSlug = ''.obs;

  Future getNewUserZone() async {
    var response = await _dio
        .get(
      URLs.NEW_USER_ZONE,
    )
        .catchError((onError) {
      print(onError.toString());
    });
    if (response != null) {
      final data = new Map<String, dynamic>.from(response.data);
      if (data['message'] == 'success') {
        return NewUserZoneModel.fromJson(data);
      } else {
        //show error message
        return null;
      }
    } else {
      print('No Data');
    }
  }

  Future<NewUserZoneModel> getNewUserZoneHome() async {
    try {
      isLoading(true);
      var products = await getNewUserZone();
      if (products != null) {
        newZone.value = products;
        newUserZoneSlug.value = newZone.value.newUserZone.slug;
        if (!newZone.value.newUserZone.backgroundColor.contains('#')) {
          bgColor.value =
              colourNameToHex(newZone.value.newUserZone.backgroundColor);
        } else {
          bgColor.value = getBGColor(newZone.value.newUserZone.backgroundColor);
        }
      }
      return products;
    } finally {
      isLoading(false);
    }
  }

  int getBGColor(String color) {
    String col = color.replaceAll("#", "");
    String bg = "0xff$col";
    return int.parse(bg);
  }

  colourNameToHex(colour) {
    Map<String, dynamic> colours = {
      "aliceblue": 0xfff0f8ff,
      "antiquewhite": 0xfffaebd7,
      "aqua": 0xff00ffff,
      "aquamarine": 0xff7fffd4,
      "azure": 0xfff0ffff,
      "beige": 0xfff5f5dc,
      "bisque": 0xffffe4c4,
      "black": 0xff000000,
      "blanchedalmond": 0xffffebcd,
      "blue": 0xff0000ff,
      "blueviolet": 0xff8a2be2,
      "brown": 0xffa52a2a,
      "burlywood": 0xffdeb887,
      "cadetblue": 0xff5f9ea0,
      "chartreuse": 0xff7fff00,
      "chocolate": 0xffd2691e,
      "coral": 0xffff7f50,
      "cornflowerblue": 0xff6495ed,
      "cornsilk": 0xfffff8dc,
      "crimson": 0xffdc143c,
      "cyan": 0xff00ffff,
      "darkblue": 0xff00008b,
      "darkcyan": 0xff008b8b,
      "darkgoldenrod": 0xffb8860b,
      "darkgray": 0xffa9a9a9,
      "darkgreen": 0xff006400,
      "darkkhaki": 0xffbdb76b,
      "darkmagenta": 0xff8b008b,
      "darkolivegreen": 0xff556b2f,
      "darkorange": 0xffff8c00,
      "darkorchid": 0xff9932cc,
      "darkred": 0xff8b0000,
      "darksalmon": 0xffe9967a,
      "darkseagreen": 0xff8fbc8f,
      "darkslateblue": 0xff483d8b,
      "darkslategray": 0xff2f4f4f,
      "darkturquoise": 0xff00ced1,
      "darkviolet": 0xff9400d3,
      "deeppink": 0xffff1493,
      "deepskyblue": 0xff00bfff,
      "dimgray": 0xff696969,
      "dodgerblue": 0xff1e90ff,
      "firebrick": 0xffb22222,
      "floralwhite": 0xfffffaf0,
      "forestgreen": 0xff228b22,
      "fuchsia": 0xffff00ff,
      "gainsboro": 0xffdcdcdc,
      "ghostwhite": 0xfff8f8ff,
      "gold": 0xffffd700,
      "goldenrod": 0xffdaa520,
      "gray": 0xff808080,
      "green": 0xff008000,
      "greenyellow": 0xffadff2f,
      "honeydew": 0xfff0fff0,
      "hotpink": 0xffff69b4,
      "indianred ": 0xffcd5c5c,
      "indigo": 0xff4b0082,
      "ivory": 0xfffffff0,
      "khaki": 0xfff0e68c,
      "lavender": 0xffe6e6fa,
      "lavenderblush": 0xfffff0f5,
      "lawngreen": 0xff7cfc00,
      "lemonchiffon": 0xfffffacd,
      "lightblue": 0xffadd8e6,
      "lightcoral": 0xfff08080,
      "lightcyan": 0xffe0ffff,
      "lightgoldenrodyellow": 0xfffafad2,
      "lightgrey": 0xffd3d3d3,
      "lightgreen": 0xff90ee90,
      "lightpink": 0xffffb6c1,
      "lightsalmon": 0xffffa07a,
      "lightseagreen": 0xff20b2aa,
      "lightskyblue": 0xff87cefa,
      "lightslategray": 0xff778899,
      "lightsteelblue": 0xffb0c4de,
      "lightyellow": 0xffffffe0,
      "lime": 0xff00ff00,
      "limegreen": 0xff32cd32,
      "linen": 0xfffaf0e6,
      "magenta": 0xffff00ff,
      "maroon": 0xff800000,
      "mediumaquamarine": 0xff66cdaa,
      "mediumblue": 0xff0000cd,
      "mediumorchid": 0xffba55d3,
      "mediumpurple": 0xff9370d8,
      "mediumseagreen": 0xff3cb371,
      "mediumslateblue": 0xff7b68ee,
      "mediumspringgreen": 0xff00fa9a,
      "mediumturquoise": 0xff48d1cc,
      "mediumvioletred": 0xffc71585,
      "midnightblue": 0xff191970,
      "mintcream": 0xfff5fffa,
      "mistyrose": 0xffffe4e1,
      "moccasin": 0xffffe4b5,
      "navajowhite": 0xffffdead,
      "navy": 0xff000080,
      "oldlace": 0xfffdf5e6,
      "olive": 0xff808000,
      "olivedrab": 0xff6b8e23,
      "orange": 0xffffa500,
      "orangered": 0xffff4500,
      "orchid": 0xffda70d6,
      "palegoldenrod": 0xffeee8aa,
      "palegreen": 0xff98fb98,
      "paleturquoise": 0xffafeeee,
      "palevioletred": 0xffd87093,
      "papayawhip": 0xffffefd5,
      "peachpuff": 0xffffdab9,
      "peru": 0xffcd853f,
      "pink": 0xffffc0cb,
      "plum": 0xffdda0dd,
      "powderblue": 0xffb0e0e6,
      "purple": 0xff800080,
      "rebeccapurple": 0xff663399,
      "red": 0xffff0000,
      "rosybrown": 0xffbc8f8f,
      "royalblue": 0xff4169e1,
      "saddlebrown": 0xff8b4513,
      "salmon": 0xfffa8072,
      "sandybrown": 0xfff4a460,
      "seagreen": 0xff2e8b57,
      "seashell": 0xfffff5ee,
      "sienna": 0xffa0522d,
      "silver": 0xffc0c0c0,
      "skyblue": 0xff87ceeb,
      "slateblue": 0xff6a5acd,
      "slategray": 0xff708090,
      "snow": 0xfffffafa,
      "springgreen": 0xff00ff7f,
      "steelblue": 0xff4682b4,
      "tan": 0xffd2b48c,
      "teal": 0xff008080,
      "thistle": 0xffd8bfd8,
      "tomato": 0xffff6347,
      "turquoise": 0xff40e0d0,
      "violet": 0xffee82ee,
      "wheat": 0xfff5deb3,
      "white": 0xffffffff,
      "whitesmoke": 0xfff5f5f5,
      "yellow": 0xffffff00,
      "yellowgreen": 0xff9acd32
    };

    return colours[colour];
  }

  @override
  void onInit() {
    getNewUserZoneHome();
    super.onInit();
  }

  Future<List<NewUserZoneDatum>> getBrandProducts() async {
    NewUserZoneModel allBrandModelDatum = NewUserZoneModel();
    try {
      isNewUserProductLoading(true);
      await _dio.get(URLs.NEW_USER_ZONE, queryParameters: {
        'page': brandPageNumber,
      }).then((value) {
        final data = new Map<String, dynamic>.from(value.data);
        allBrandModelDatum = NewUserZoneModel.fromJson(data['data']);
        if (allBrandModelDatum.newUserZone.allProducts.data.length == 0) {
          lastPage(true);
        } else {
          newUserProducts
              .addAll(allBrandModelDatum.newUserZone.allProducts.data);
        }
      });
    } catch (e) {
      isNewUserProductLoading(false);
      print(e.toString());
    } finally {
      isNewUserProductLoading(false);
    }
    return newUserProducts;
  }

  var isNewUserZoneProductLoading = false.obs;
  var isMoreNewUserProductLoading = false.obs;
  var newUserProductLastPage = false.obs;
  var allNewUserProducts = <NewUserZoneDatum>[].obs;
  var newUserProductsPageNumber = 1.obs;

  Future<List<NewUserZoneDatum>> getNewUserZoneProducts({String slug}) async {
    NewUserZoneAllProducts parentCategoryElement = NewUserZoneAllProducts();
    try {
      isNewUserZoneProductLoading(true);
      isMoreNewUserProductLoading(true);
      await _dio.get(URLs.fetchNewUserProductData(slug), queryParameters: {
        'page': newUserProductsPageNumber,
        'item': 'product',
      }).then((value) {
        final data = new Map<String, dynamic>.from(value.data);
        parentCategoryElement = NewUserZoneAllProducts.fromJson(data);
        if (parentCategoryElement.data.length == 0) {
          isMoreNewUserProductLoading(false);
          newUserProductLastPage(true);
        } else {
          isMoreNewUserProductLoading(true);
          allNewUserProducts.addAll(parentCategoryElement.data);
        }
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        isMoreNewUserProductLoading(false);
        newUserProductLastPage(true);
        print('ERROR is $error');
      });
    } catch (e) {
      isNewUserZoneProductLoading(false);
      print(e.toString());
    } finally {
      isNewUserZoneProductLoading(false);
      isMoreNewUserProductLoading(false);
    }
    return allNewUserProducts;
  }

  /// Category ALL PRODUCTS
  var isCategoryAllProductLoading = false.obs;
  var isMoreCategoryAllProductLoading = false.obs;
  var categoryAllProductLastPage = false.obs;
  var allCategoryAllProducts = <ProductModel>[].obs;
  var categoryAllProductsPageNumber = 1.obs;

  Future<List<ProductModel>> getCategoryAllProducts({String slug}) async {
    AllProducts parentCategoryElement = AllProducts();
    try {
      isCategoryAllProductLoading(true);
      isMoreCategoryAllProductLoading(true);
      await _dio
          .get(URLs.fetchNewUserCategoryAllProducts(slug), queryParameters: {
        'item': 'category',
        'page': categoryAllProductsPageNumber,
      }).then((value) {
        print(value.realUri);
        final data = new Map<String, dynamic>.from(value.data);
        parentCategoryElement =
            AllProducts.fromJson(data['allCategoryProducts']);
        if (parentCategoryElement.data.length == 0) {
          isMoreCategoryAllProductLoading(false);
          categoryAllProductLastPage(true);
        } else {
          isMoreCategoryAllProductLoading(true);
          allCategoryAllProducts.addAll(parentCategoryElement.data);
        }
        print(allCategoryAllProducts.length);
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        isMoreCategoryAllProductLoading(false);
        categoryAllProductLastPage(true);
        print('ERROR is $error');
      });
    } catch (e) {
      isCategoryAllProductLoading(false);
      print(e.toString());
    } finally {
      isCategoryAllProductLoading(false);
      isMoreCategoryAllProductLoading(false);
    }
    return allCategoryAllProducts;
  }

  Future<List<ProductModel>> getCouponAllProducts({String slug}) async {
    AllProducts parentCategoryElement = AllProducts();
    try {
      isCategoryAllProductLoading(true);
      isMoreCategoryAllProductLoading(true);
      await _dio
          .get(URLs.fetchNewUserCouponAllProducts(slug), queryParameters: {
        'item': 'category',
        'page': categoryAllProductsPageNumber,
      }).then((value) {
        final data = new Map<String, dynamic>.from(value.data);
        parentCategoryElement =
            AllProducts.fromJson(data['allCouponCategoryProducts']);
        if (parentCategoryElement.data.length == 0) {
          isMoreCategoryAllProductLoading(false);
          categoryAllProductLastPage(true);
        } else {
          isMoreCategoryAllProductLoading(true);
          allCategoryAllProducts.addAll(parentCategoryElement.data);
        }
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        isMoreCategoryAllProductLoading(false);
        categoryAllProductLastPage(true);
        print('ERROR is $error');
      });
    } catch (e) {
      isCategoryAllProductLoading(false);
      print(e.toString());
    } finally {
      isCategoryAllProductLoading(false);
      isMoreCategoryAllProductLoading(false);
    }
    return allCategoryAllProducts;
  }

  /// Category SINGLE PRODUCTS
  var isCategoryProductLoading = false.obs;
  var isMoreCategoryProductLoading = false.obs;
  var categoryProductLastPage = false.obs;
  var allCategoryProducts = <ProductModel>[].obs;
  var categoryProductsPageNumber = 1.obs;

  var itemType = ''.obs;
  var itemID = 0.obs;
  var parentID = 0.obs;

  Future<List<ProductModel>> getCategoryProducts({String slug}) async {
    AllProducts parentCategoryElement = AllProducts();
    try {
      isCategoryProductLoading(true);
      isMoreCategoryProductLoading(true);
      await _dio.get(URLs.fetchNewUserCategoryProducts(slug), queryParameters: {
        'item': itemType,
        'category': itemID.value,
        'parent_data': parentID.value,
        'page': categoryProductsPageNumber,
      }).then((value) {
        final data = new Map<String, dynamic>.from(value.data);
        parentCategoryElement = AllProducts.fromJson(data);
        if (parentCategoryElement.data.length == 0) {
          isMoreCategoryProductLoading(false);
          categoryProductLastPage(true);
        } else {
          isMoreCategoryProductLoading(true);
          allCategoryProducts.addAll(parentCategoryElement.data);
        }
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        isMoreCategoryProductLoading(false);
        categoryProductLastPage(true);
        print('ERROR is $error');
      });
    } catch (e) {
      isCategoryProductLoading(false);
      print(e.toString());
    } finally {
      isCategoryProductLoading(false);
      isMoreCategoryProductLoading(false);
    }
    return allCategoryProducts;
  }

  Future<List<ProductModel>> getCouponProducts({String slug}) async {
    AllProducts parentCategoryElement = AllProducts();
    try {
      isCategoryProductLoading(true);
      isMoreCategoryProductLoading(true);
      await _dio.get(URLs.fetchNewUserCouponProducts(slug), queryParameters: {
        'item': itemType,
        'category': itemID.value,
        'parent_data': parentID.value,
        'page': categoryProductsPageNumber,
      }).then((value) {
        final data = new Map<String, dynamic>.from(value.data);
        parentCategoryElement = AllProducts.fromJson(data);
        if (parentCategoryElement.data.length == 0) {
          isMoreCategoryProductLoading(false);
          categoryProductLastPage(true);
        } else {
          isMoreCategoryProductLoading(true);
          allCategoryProducts.addAll(parentCategoryElement.data);
        }
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        isMoreCategoryProductLoading(false);
        categoryProductLastPage(true);
        print('ERROR is $error');
      });
    } catch (e) {
      isCategoryProductLoading(false);
      print(e.toString());
    } finally {
      isCategoryProductLoading(false);
      isMoreCategoryProductLoading(false);
    }
    return allCategoryProducts;
  }
}
