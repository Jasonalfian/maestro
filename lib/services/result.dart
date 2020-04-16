import 'package:maestro/services/networking.dart';

String result;


class GenerateLyrics {

  Future<dynamic> getLyrics(String inputString, int sumResult) async{
    NetworkHelper networkHelper = NetworkHelper("https://lyricsgenerator.didithilmy.com/predict?seed=$inputString&num=$sumResult");
    var lyricsResult = await networkHelper.getData();

    return lyricsResult;
  }
}