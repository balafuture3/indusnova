class Model {
  SoapEnvelope soapEnvelope;

  Model({this.soapEnvelope});

  Model.fromJson(Map<String, dynamic> json) {
    soapEnvelope = json['soap:Envelope'] != null
        ? new SoapEnvelope.fromJson(json['soap:Envelope'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.soapEnvelope != null) {
      data['soap:Envelope'] = this.soapEnvelope.toJson();
    }
    return data;
  }
}

class SoapEnvelope {
  SoapBody soapBody;

  SoapEnvelope({this.soapBody});

  SoapEnvelope.fromJson(Map<String, dynamic> json) {
    soapBody = json['soap:Body'] != null
        ? new SoapBody.fromJson(json['soap:Body'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.soapBody != null) {
      data['soap:Body'] = this.soapBody.toJson();
    }
    return data;
  }
}

class SoapBody {
  IndusMobileUserLogin1Response indusMobileUserLogin1Response;

  SoapBody({this.indusMobileUserLogin1Response});

  SoapBody.fromJson(Map<String, dynamic> json) {
    indusMobileUserLogin1Response =
    json['IndusMobileUserLogin1Response'] != null
        ? new IndusMobileUserLogin1Response.fromJson(
        json['IndusMobileUserLogin1Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.indusMobileUserLogin1Response != null) {
      data['IndusMobileUserLogin1Response'] =
          this.indusMobileUserLogin1Response.toJson();
    }
    return data;
  }
}

class IndusMobileUserLogin1Response {
  String indusMobileUserLogin1Result;

  IndusMobileUserLogin1Response({this.indusMobileUserLogin1Result});

  IndusMobileUserLogin1Response.fromJson(Map<String, dynamic> json) {
    indusMobileUserLogin1Result = json['IndusMobileUserLogin1Result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IndusMobileUserLogin1Result'] = this.indusMobileUserLogin1Result;
    return data;
  }
}
