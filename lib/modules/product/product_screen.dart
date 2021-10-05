import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/style.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state){
          if(state is GetChangeFavoriteSuccessState)
            {
              if(!state.model.status!)
                {
                  showToast(message: state.model.message!, state: ToastSate.ERROR);
                }
            }
        },
        builder: (contex, state) {
          var cubit = HomeCubit.get(context);
          return cubit.homeModel != null && cubit.categoryModel != null ? productBuilder(cubit.homeModel, cubit.categoryModel, context) : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget productBuilder(HomeModel? model, CategoryModel? categoryModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model!.date!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          )).toList(),
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            reverse: false,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(categoryModel!.data!.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.0,
                  ),
                  itemCount: categoryModel!.data!.data.length,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1/1.54,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            children: List.generate(
                model.date!.products.length,
                (index) => buildGridProduct(model.date!.products[index], context)
            ),
          ),
        ),
      ],
    ),
  );


  Widget buildGridProduct(ProductModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200,
                ),
            ),
            if(false)
              Padding(
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  fontSize: 16.0,
                  height: 1.6,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style:  TextStyle(
                      fontSize: 14.0,
                      height: 1.6,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style:  TextStyle(
                      fontSize: 14.0,
                      height: 1.6,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeFavorite(model.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: HomeCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 20.0,
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
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.5),
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
          ),
        ),
      ),
    ],
  );
}
