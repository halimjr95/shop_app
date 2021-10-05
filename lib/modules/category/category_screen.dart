import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/shared/components/components.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => BuildCateItem(HomeCubit.get(context).categoryModel!.data!.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: HomeCubit.get(context).categoryModel!.data!.data.length,
        );
      },
    );
  }

  Widget BuildCateItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 80.0,
          width: 80.0,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}
