import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/NewsModel.dart';

class NewsController extends GetxController {
  RxList<NewsModel> trendingNewsList = <NewsModel>[].obs;
  RxList<NewsModel> newsForYouList = <NewsModel>[].obs;
  RxList<NewsModel> searchNewsList = <NewsModel>[].obs;
  RxList<NewsModel> newsForYou5 = <NewsModel>[].obs;
  RxList<NewsModel> appleNewsList = <NewsModel>[].obs;
  RxList<NewsModel> apple5News = <NewsModel>[].obs;
  RxList<NewsModel> teslaNewsList = <NewsModel>[].obs;
  RxList<NewsModel> tesla5News = <NewsModel>[].obs;
  RxList<NewsModel> businessNewsList = <NewsModel>[].obs;
  RxList<NewsModel> business5News = <NewsModel>[].obs;
  RxBool isTrendingLoading = false.obs;
  RxBool isNewsForULoading = false.obs;
  RxBool isTeslaLoading = false.obs;
  RxBool isAppleLoading = false.obs;
  RxBool isBuisLoading = false.obs;
  RxBool isSpeeking = false.obs;
  RxInt selectedCategoryIndex = 0.obs;

  void onInit() async {
    super.onInit();
    getNewsForYou();
    getTrendingNews();
    getAppleNews();
    getTeslaNews();
    getBusinessNews();
  }

  void changeCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  RxList<NewsModel> get currentNews {
    switch (selectedCategoryIndex.value) {
      case 0:
        return business5News;
      case 1:
        return apple5News;
      case 2:
        return tesla5News;
      default:
        return newsForYouList;
    }
  }

  Future<void> getTrendingNews() async {
    isTrendingLoading.value = true;
    var baseURL =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=79a38a9ae80d4d51bf9bf8178fbeda3a";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          trendingNewsList.add(NewsModel.fromJson(news));
        }
      } else {
        print("Something went Wrong in Trending News");
      }
    } catch (ex) {
      print(ex);
    }
    isTrendingLoading.value = false;
  }

  Future<void> getNewsForYou() async {
    isNewsForULoading.value = true;
    var baseURL =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=79a38a9ae80d4d51bf9bf8178fbeda3a";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          newsForYouList.add(NewsModel.fromJson(news));
        }
        newsForYou5.value = newsForYouList.sublist(0, 2).obs;
      } else {
        print("Something went Wrong in getNews4u News");
      }
    } catch (ex) {
      print(ex);
    }
    isNewsForULoading.value = false;
  }

  Future<void> getAppleNews() async {
    isAppleLoading.value = true;
    var baseURL =
        "https://newsapi.org/v2/everything?q=apple&from=2024-11-02&to=2024-11-02&sortBy=popularity&apiKey=79a38a9ae80d4d51bf9bf8178fbeda3a";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          appleNewsList.add(NewsModel.fromJson(news));
        }
        apple5News.value = appleNewsList.sublist(0, 5).obs;
      } else {
        print("Something went Wrong in apple News");
      }
    } catch (ex) {
      print(ex);
    }
    isAppleLoading.value = false;
  }

  Future<void> getTeslaNews() async {
    isTeslaLoading.value = true;
    var baseURL =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-10-03&sortBy=publishedAt&apiKey=79a38a9ae80d4d51bf9bf8178fbeda3a";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          teslaNewsList.add(NewsModel.fromJson(news));
        }
        tesla5News.value = teslaNewsList.sublist(0, 5).obs;
      } else {
        print("Something went Wrong in Tesla News");
      }
    } catch (ex) {
      print(ex);
    }
    isTeslaLoading.value = false;
  }

  Future<void> getBusinessNews() async {
    isBuisLoading.value = true;
    var baseURL =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=79a38a9ae80d4d51bf9bf8178fbeda3a";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          businessNewsList.add(NewsModel.fromJson(news));
        }
        business5News.value = businessNewsList.sublist(0, 5).obs;
      } else {
        print("Something went Wrong in business News");
      }
    } catch (ex) {
      print(ex);
    }
    isBuisLoading.value = false;
  }

  Future<void> searchNews(String search) async {
    isNewsForULoading.value = true;
    var baseURL =
        "https://newsapi.org/v2/everything?q=$search&apiKey=79a38a9ae80d4d51bf9bf8178fbeda3a";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        newsForYouList.clear();
        int i = 0;
        for (var news in articals) {
          i++;
          newsForYouList.add(NewsModel.fromJson(news));
          if (i == 10) {
            break;
          }
        }
      } else {
        print("Something went Wrong in Search News");
      }
    } catch (ex) {
      print(ex);
    }
    isNewsForULoading.value = false;
  }
}
