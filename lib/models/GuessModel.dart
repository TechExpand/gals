class Guess {
  String id;
  String AlbumName;
  String TrackName;
  String MusicLength;
  String MusicUrl;
  String ImageUrl;
  String MusicToken;
  String LineOne;
  String Lineofday;
  String LineTwo;
  String created;
  String expired;
  String LineThree;
  String answer;

  Guess({
    this.id,
    this.AlbumName,
    this.TrackName,
    this.MusicUrl,
    this.MusicLength,
    this.ImageUrl,
    this.MusicToken,
    this.created,
    this.expired,
    this.LineOne,
    this.LineTwo,
    this.LineThree,
    this.answer,
    this.Lineofday,
  });

  Guess.fromMap(Map snapshot, String id)
      : id = id ?? '',
        created = snapshot['created'] ?? '',
        expired = snapshot['expired'] ?? '',
        AlbumName = snapshot['AlbumName'] ?? '',
        MusicUrl = snapshot['MusicUrl'] ?? '',
        TrackName = snapshot['TrackName'] ?? '',
        ImageUrl = snapshot['ImageUrl'] ?? '',
        MusicToken = snapshot['MusicToken'] ?? '',
        MusicLength = snapshot['MusicLength'] ?? '',
        LineTwo = snapshot['LineTwo'] ?? '',
        LineOne = snapshot['LineOne'] ?? '',
        Lineofday = snapshot['Lineofday'] ?? '',
        LineThree = snapshot['LineThree'] ?? '',
        answer = snapshot['answer'] ?? '';

  toJson() {
    return {
      "AlbumName": AlbumName,
      "TrackName": TrackName,
      "ImageUrl": ImageUrl,
      "MusicToken": MusicToken,
      "MusicLength": MusicLength,
      'LineTwo': LineTwo,
      'created': created,
      'expired':expired,
      'LineOne': LineTwo,
      'LineThree': LineThree,
      'Lineofday': Lineofday,
      'answer': answer,
    };
  }
}
