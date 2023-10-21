import 'dart:convert';

import 'package:first_app/models/get_categories.dart';
import 'package:first_app/models/get_product.dart';
import 'package:first_app/models/get_single_user.dart';
import 'package:first_app/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/product_card.dart';
import '../config/api_url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late TabController _tabController;
  late SingleUser singleUser;
  late List<Categories> categories;
  late List<Product> products;


  @override
  void initState(){
    super.initState();

    //INITIALIZE TAB CONTROLLER AND LISTENER
    _tabController = TabController(vsync: this, length: 0);
    _tabController.addListener(_updateTabIndex);

    //INITIALIZE SINGLE USER ACC TO MODEL CLASS
    singleUser = SingleUser(
      id: 0, 
      email: "", 
      password: "", 
      name: "", 
      role: "", 
      avatar: "", 
      creationAt: DateTime.now(), 
      updatedAt: DateTime.now());

    //INITIALIZE CATEGORIES ACC TO MODEL CLASS
    categories = [];

    //INITIALIZE PRODUCTS ACC TO MODEL CLASS
    products = [];

    // API CALL FOR SINGLE USER
    getSingleUser();
    // API CALL FOR CATEGORIES
    getCategories();
    // API CALL FOR PRODUCTS
    getProduct();
  }

  @override
  void dispose() {

    //DISPOSE TAB CONTROLLER
    _tabController.dispose();

    super.dispose();
  }

  _updateTabIndex(){
    setState(() {});
  }


  // GET SINGLE USER API CALL
  void getSingleUser() async {
    final response = await http.get(
      Uri.parse(ApiUrl.getSingleUser),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if(mounted){
        setState(() {
          singleUser = SingleUser.fromJson(data);
        });
      }
    } else {
      throw Exception('Request Failed.');
    }
  }

  // GET CATEGORIES API CALL
  void getCategories() async {
    final response = await http.get(
      Uri.parse(ApiUrl.getCategories),
    );

    if (response.statusCode == 200) {
      List<Categories> categoriesList = (json.decode(response.body) as List)
      .map((data) => Categories.fromJson(data))
      .toList();
      
      if(mounted){
        setState(() {
          categories = categoriesList;
          _tabController = TabController(
            vsync: this,
            length: categories.length,
          );
        });
      }
    } else {
      throw Exception('Request Failed.');
    }
  }

  // GET PRODUCT API CALL
  void getProduct() async {
    final response = await http.get(
      Uri.parse(ApiUrl.getAllProducts),
    );

    if (response.statusCode == 200) {
      List<Product> productsList = (json.decode(response.body) as List)
      .map((data) => Product.fromJson(data))
      .toList();
      
      if(mounted){
        setState(() {
          products = productsList;
        });
      }
    } else {
      throw Exception('Request Failed.');
    }
  }

  //MAIN BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 20,),
          userRow(),
          const SizedBox(height: 20,),
          tabRow(),
          const SizedBox(height: 20,),
          tabContent(),
      
        ]),
      ),
    );
  }

  // USER DETAILS ROW
  Widget userRow(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(singleUser.avatar),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10,),
          Column(
            children: [
            const Text("Hello,",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
            ),
            Text(singleUser.name,
              style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          )
          ],)
        ],
      ),
    );
  }

  //TABS ROW
  Widget tabRow(){
    return
    Container(
      height: 35,
      child: 
      TabBar(
        controller: _tabController,
        isScrollable: true,
        unselectedLabelColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontSize: 12),
        labelStyle: TextStyle(fontSize: 12),
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10),
        labelPadding: EdgeInsets.only(left: 10, right: 10),
        indicatorWeight: 0,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black),
          
        tabs: categories
          .map((category) => 
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Align(
                child: Text(category.name),
                alignment: Alignment.center,
              ),
            ),
          ),)
          .toList()
        )
    );
  }

  //TAB CONTENT
  Widget tabContent(){
    return 
    Expanded(
      child: TabBarView(
        controller: _tabController, 
        children: categories.map((category) {
        final categoryProducts = products.where((product) => product.category.name == category.name).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                crossAxisSpacing: 25, // Spacing between columns
                mainAxisSpacing: 25, // Spacing between rows
                childAspectRatio: 0.8 // Aspect Ratio of child
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
              // Create a custom widget for each product card
              return InkWell(
                onTap: (){
                  //NAVIGATION LOGIC
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                          ProductPage(product:categoryProducts[index])));
                },
                child: ProductCard(product: categoryProducts[index]));
              },
            ),
        );
      }).toList(),
      ),
    );
  }
}