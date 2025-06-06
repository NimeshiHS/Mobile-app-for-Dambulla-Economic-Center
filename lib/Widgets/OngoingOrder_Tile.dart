import 'package:dec_app/Pages/Seller/OrderUpdate.dart';
import 'package:flutter/material.dart';

import '../Azure_Translation/translatable_text.dart';
import '../Components/productQuantityManager.dart';
import '../Firestore/productData.dart';
import '../Models/product_model.dart';

class OnOrderTile extends StatefulWidget {
  final Product product;
  const OnOrderTile({super.key, required this.product});

  @override
  State<OnOrderTile> createState() => _OnOrderTileState();
}

class _OnOrderTileState extends State<OnOrderTile> {

  @override
  Widget build(BuildContext context) {

    int filledQuantity =ProductQuantityManager().getFilledQuantity(widget.product.id);
    double progress = (filledQuantity / widget.product.quantity).clamp(0, 1);

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatableText(
                    '${widget.product.name}  ${widget.product.quantity}Kg',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "1KG රු. ${widget.product.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: CircularProgressIndicator(
                          value: progress,
                          color: Color(0xFF208A43),
                          backgroundColor: Color(0xD1D1D3E4),
                          strokeWidth: 5,
                        ),
                      ),
                      Text(
                        "${(progress * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  TranslatableText(
                    "${filledQuantity}Kg / ${widget.product.quantity}Kg සම්පුර්ණ වී ඇත",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => OrderUpdate(product: widget.product),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: TranslatableText(
                      "වෙනස් කරන්න",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const TranslatableText('ඇණවූම ඉවත් කිරීම'),
                              content: const TranslatableText(
                                'ඔබගේ ඇණවූම ඉවත් කිරීමට අවශ්‍යද?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const TranslatableText('නැත'),
                                ),
                                TextButton(
                                  onPressed: () async{
                                    await Database().deleteProduct(widget.product.id, context);
                                  },
                                  child: const TranslatableText(
                                    'අවශ්‍යයි',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                    ),
                    child: TranslatableText(
                      "ඉවත් කරන්න",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
