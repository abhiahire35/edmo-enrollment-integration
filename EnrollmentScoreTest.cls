@isTest
public class EnrollmentScoreTest {

    @isTest
    static void testRestAPI() {

        Contact c = new Contact(LastName='Test', Email='test@test.com');
        insert c;

        String jsonBody = '{"scores":[{"contactEmail":"test@test.com","score":80,"recommendedAction":"Schedule Call","sourceSystem":"EDMO","scoredAt":"2026-03-10T10:30:00Z"}]}';

        RestRequest req = new RestRequest();
        req.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = req;

        Test.startTest();
        EnrollmentScoreRestController.handlePost();
        Test.stopTest();

        System.assertEquals(1, [SELECT COUNT() FROM Enrollment_Score__c]);
    }

    @isTest
    static void testTrigger() {

        Contact c = new Contact(LastName='Test2', Email='test2@test.com');
        insert c;

        Enrollment_Score__c score = new Enrollment_Score__c(
            Contact__c = c.Id,
            Score__c = 90,
            Scored_At__c = System.now()
        );

        insert score;

        Contact updated = [SELECT Enrollment_Priority__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals('Hot', updated.Enrollment_Priority__c);
    }
}
