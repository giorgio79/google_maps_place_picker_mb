import 'package:flutter/material.dart';
import 'package:google_maps_apis/places.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction>? onTap;

  PredictionTile({required this.prediction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on),
      title: RichText(
        text: TextSpan(
          children: _buildPredictionText(context),
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!(prediction);
        }
      },
    );
  }

  List<TextSpan> _buildPredictionText(BuildContext context) {
    final List<TextSpan> result = <TextSpan>[];
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;

    if (prediction.matchedSubstrings != null && prediction.matchedSubstrings!.isNotEmpty) {
      MatchedSubstring matchedSubString = prediction.matchedSubstrings![0];
      // There is no matched string at the beginning.
      if (matchedSubString.offset > 0) {
        result.add(
          TextSpan(
            text: prediction.description
                ?.substring(0, matchedSubString.offset.toInt()),
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.w300),
          ),
        );
      }

      // Matched strings.
      result.add(
        TextSpan(
          text: prediction.description?.substring(
              matchedSubString.offset.toInt(),
              matchedSubString.offset.toInt() + matchedSubString.length.toInt()),
          style: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );

      // Other strings.
      if (matchedSubString.offset.toInt() + matchedSubString.length.toInt() <
          (prediction.description?.length ?? 0)) {
        result.add(
          TextSpan(
            text: prediction.description?.substring(
                matchedSubString.offset.toInt() + matchedSubString.length.toInt()),
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.w300),
          ),
        );
      }
      // If there is no matched strings, but there are predicts. (Not sure if this happens though)
    } else {
      result.add(
        TextSpan(
          text: prediction.description,
          style: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w300),
        ),
      );
    }

    return result;
  }
}
