import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/favorite_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/style.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state){
        // if(state is GetChangeFavoriteSuccessState)
        // {
        //   if(!state.model.status!)
        //   {
        //     showToast(message: state.model.message!, state: ToastSate.ERROR);
        //   }
        // }
      },
      builder: (contex, state) {
        var cubit = HomeCubit.get(context);
        return cubit.favoriteModel != null && state is! GetFavoriteLoadingState ? buildProductList(cubit.favoriteModel!, context) : Center(child: CircularProgressIndicator());
      },
    );
  }

}

Widget buildProductList(FavoriteModel model, context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildFavItem(model.data.favoriteData[index], context),
  separatorBuilder: (context, index) => myDivider(),
  itemCount: model.data.favoriteData.length,
);


Widget buildFavItem(FavoriteData model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
              image: NetworkImage(model.product!.image!),
              width: 120.0,
              height: 120.0,
            ),
            if (model.product!.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.product!.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.product!.discount != 0)
                    Text(
                      model.product!.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      HomeCubit.get(context).changeFavorite(model.product!.id!);

                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                      HomeCubit.get(context).favorites[model.product!.id]!
                          ? defaultColor
                          : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
