public with sharing class InvSmartyStreetCaller {
  @InvocableMethod(
    label='Call SmartyStreet'
    description='Invokes callout to SmartyStreet API'
  )
  public static void smartyStreetCallout(List<Id> locationIds) {
    run(locationIds[0]);
  }

  @future(callout=true)
  public static void run(Id locId) {
    try {
      //Endpoint: "https://us-street.api.smarty.com/street-address?auth-id=21beeabf-b828-b4fb-fdcb-a0a36f24f3e6&auth-token=cbeQqQv7rDRNHLcpTPyo&street=3525%20Davenport%20St%20NW&city=Washington&state=DC&zipcode=20008&match=enhanced"

      SmartyStreetCredentials__c apiCreds = SmartyStreetCredentials__c.getOrgDefaults();

      Location__c loc = [
        SELECT Street__c, State__c, Postal_Code__c, City__c
        FROM Location__c
        WHERE Id = :locId
        WITH SECURITY_ENFORCED
      ];

      String path =
        'street-address?' +
        'auth-id=' +
        apiCreds.AuthId__c +
        '&auth-token=' +
        apiCreds.AuthToken__c +
        '&street=' +
        EncodingUtil.urlEncode(loc.Street__c, 'UTF-8') +
        '&city=' +
        loc.City__c +
        '&state=' +
        loc.State__c +
        '&zipcode=' +
        loc.Postal_Code__c +
        '&match=enhanced';

      Http http = new http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint('callout:SmartyStreet/' + path);
      request.setMethod('GET');

      HttpResponse response = http.send(request);
      System.debug('Response: ' + response.getBody());

      Boolean success = response.getStatusCode() == 200;
      update new Location__c(Id = locId, Verified__c = success);
    } catch (Exception ex) {
      ErrorLogs.newErrorLog('Call SmartyStreet', ex.getMessage());
    }
  }
}
