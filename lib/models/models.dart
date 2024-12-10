class Temuan {
  String temuan;
  String lokasi;
  String area;
  String aspek;
  String jenis;
  bool isEdit;

  Temuan({
    required this.temuan,
    required this.lokasi,
    required this.area,
    required this.aspek,
    required this.jenis,
    required this.isEdit
  });

  factory Temuan.fromJson(Map<String, dynamic> json) {
    return Temuan(
      temuan: json['temuan'],
      lokasi: json['lokasi'],
      area: json['area'],
      aspek: json['aspek'],
      jenis: json['jenis'],
      isEdit: json['isEdit']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temuan': temuan,
      'lokasi': lokasi,
      'area': area,
      'aspek': aspek,
      'jenis': jenis,
      'isEdit' : isEdit
    };
  }
}

class Area {
  int id;
  String area;

  Area({required this.id, required this.area});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
    };
  }
}

class Aspek {
  int id;
  String aspek;

  Aspek({required this.id, required this.aspek});

  factory Aspek.fromJson(Map<String, dynamic> json) {
    return Aspek(
      id: json['id'],
      aspek: json['aspek'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aspek': aspek,
    };
  }
}

class Rekomendasi {
  int id;
  String rekomendasi;

  Rekomendasi({required this.id, required this.rekomendasi});

  factory Rekomendasi.fromJson(Map<String, dynamic> json) {
    return Rekomendasi(
      id: json['id'],
      rekomendasi: json['rekomendasi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rekomendasi': rekomendasi,
    };
  }
}

class Inspeksi {
  String startDate;
  String endDate;
  String badanUsaha;

  Inspeksi({required this.startDate, required this.endDate, required this.badanUsaha});

  String pelaksaan() {
    return "$startDate - $endDate";
  }

  factory Inspeksi.fromJson(Map<String, dynamic> json) {
    return Inspeksi(
      startDate: json['startDate'],
      endDate: json['endDate'],
      badanUsaha: json['badanUsaha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'badanUsaha': badanUsaha,
    };
  }
}


