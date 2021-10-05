import 'package:shop/models/LoginModel.dart';
import 'package:shop/models/change_favorite_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeNavBotState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

class GetCategorySuccessState extends HomeStates {}

class GetCategoryErrorState extends HomeStates {}

class GetChangeFavoriteState extends HomeStates {}

class GetChangeFavoriteSuccessState extends HomeStates {

  final ChangeFavoriteModel model;
  GetChangeFavoriteSuccessState(this.model);
}

class GetChangeFavoriteErrorState extends HomeStates {}

class GetFavoriteLoadingState extends HomeStates {}

class GetFavoriteSuccessState extends HomeStates {}

class GetFavoriteErrorState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {}


class LoadingUpdateUserState extends HomeStates {}

class SuccessUpdateUserState extends HomeStates
{
  final LoginModel? loginModel;

  SuccessUpdateUserState(this.loginModel);
}

class ErrorUpdateUserState extends HomeStates {}
