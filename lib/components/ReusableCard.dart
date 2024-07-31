import "package:cypto_ticker/utilities/constants.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.labelText,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0, // is a shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          labelText,
          textAlign: TextAlign.center,
          style: kTextCardStyle,
        ),
      ),
    );
  }
}
