import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../components/indicator.dart';
import '../models/get_product.dart';

class ProductPage extends StatefulWidget {
  Product product;
  ProductPage({super.key,required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product product;int activeStep = 0;
  int _curr = 0;
  int dotCount = 3;
  int _selectedIndex = 0;
  PageController controller = PageController();

  @override
  void initState(){
    super.initState();
    controller = PageController(initialPage: _curr);
    product = widget.product;
  }

  //BACK LOGIC
  _back(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20,),
                backHandlerRow(),
                const SizedBox(height: 20,),
                Stack(
                  children: [
                    imageViewer(),
                    Positioned(
                    bottom: 20,
                    left: 40,
                    child: indicator(),)
                  ],
                ),
                const SizedBox(height: 30,),
                productNameRow(),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Text(product.description,
                    style:TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  )),
                ),
              const SizedBox(height: 30,),
              ],
            ),
            Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: buyButton(),),
          ],
        )
      ),
    );
  }

  // TOP COMPONENT FOR BACK HANDLE
  Widget backHandlerRow(){
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          InkWell(
            onTap: _back,
            child: const Icon(Iconsax.arrow_left_2,size: 20,)),
          const Text("Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700
          ),),
          const Icon(Iconsax.heart,size: 20,)
        ],),
      );
  }

  // COMPONENT FOR IMAGE VIEWER
  Widget imageViewer(){
    return 
    SizedBox(
      height: 450,
      child: PageView.builder(
        controller: controller,
        onPageChanged: (index) => {
          setState(() {
            _selectedIndex = index;
          })
        },
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  product.images[index],
                  height: 450, 
                  fit: BoxFit.cover,),
            ),
          );
        },
      ),
    );
  }

  //INDICATOR ROW 
  Widget indicator(){
    return
    Column(
      children: [
        ...List.generate(
            product.images.length,
            (index) => Indicator(
                  isActive:
                      _selectedIndex == index ? true : false,
                ))
      ],
    );
  }

  //PRODUCT NAME ROW FOR NAME AND PRICE
  Widget productNameRow(){
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.title,
          style:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700
          )),
          Text("\$${product.price}",
          style:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700
          )),
        ],
      ),
    );
  }

  //BUY BUTTON
  Widget buyButton(){
    return
      Container(
      height: 50,
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ElevatedButton.icon(
          icon: Icon(
            Iconsax.arrow_right_1,
            color:Colors.white,
            size: 20.0,
          ),
          onPressed: (){},
          label: Text('Buy Now',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,)),
          style: ElevatedButton.styleFrom(
            elevation: 0,
              primary: Colors.black, 
              shape:StadiumBorder()),
        ),
      ),
    );
  }
}