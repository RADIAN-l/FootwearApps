import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String offer;
  final Function onTap;
  const ProductCard({super.key, required this.name, required this.imageUrl, required this.price, required this.offer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,
              ),
              SizedBox(height: 5,),
              Text(name,style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              Text('$price taka',style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              Text(
                offer,
                style: TextStyle(color: Colors.white,fontSize: 12,backgroundColor: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
