import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/LoginModel.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/change_favorite_model.dart';
import 'package:shop/models/favorite_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/modules/category/category_screen.dart';
import 'package:shop/modules/favorite/favorite_screen.dart';
import 'package:shop/modules/product/product_screen.dart';
import 'package:shop/modules/setting/setting_screen.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(index)
  {
    currentIndex = index;
    emit(ChangeNavBotState());
  }

  List screens = [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData()
  {
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.date!.products.forEach((element){
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      emit(HomeSuccessState());
    }).catchError((error){
      emit(HomeErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData()
  {
    DioHelper.getData(url: CATEGORY, token: token).then((value) {
      // print(value.data['data']['banners']);
      categoryModel = CategoryModel.fromJson(value.data);
      // print(categoryModel!.data!.data[0].name);
      // print(homeModel!.date!.banners[0].id);
      emit(GetCategorySuccessState());
    }).catchError((error){
      emit(GetCategoryErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(GetChangeFavoriteState());

    DioHelper.postData(
        url: FAVORITE,
        data: {
          'product_id': productId
        },
        token: token,
        ).then((value){
        changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

        if(!changeFavoriteModel!.status!)
          {
            favorites[productId] = !favorites[productId]!;
          }else {
          getFavoriteData();
        }

        emit(GetChangeFavoriteSuccessState(changeFavoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(GetChangeFavoriteErrorState());
    });
  }


  FavoriteModel? favoriteModel;

  void getFavoriteData()
  {
    emit(GetFavoriteLoadingState());

    DioHelper.getData(url: FAVORITE, token: token).then((value) {
      // print(value.data['data']['banners']);
      favoriteModel = FavoriteModel.fromJson(value.data);
      print(favoriteModel!.data.favoriteData[0].product!.name);
      // print(homeModel!.date!.banners[0].id);
      emit(GetFavoriteSuccessState());
    }).catchError((error){
      emit(GetFavoriteErrorState());
    });
  }


  LoginModel? loginModel;

  void getUserData()
  {
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel!.data!.phone);
      emit(GetUserDataSuccessState());
    }).catchError((error){
      emit(GetUserDataErrorState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(SuccessUpdateUserState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateUserState());
    });
  }


}