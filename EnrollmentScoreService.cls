public with sharing class EnrollmentScoreService {

    public static EnrollmentScoreRestController.ResponseWrapper processScores(
        EnrollmentScoreRestController.RequestWrapper requestData
    ) {

        EnrollmentScoreRestController.ResponseWrapper response =
            new EnrollmentScoreRestController.ResponseWrapper();

        Set<String> emails = new Set<String>();

        for (EnrollmentScoreRestController.ScoreWrapper s : requestData.scores) {
            emails.add(s.contactEmail);
        }

        Map<String, Contact> contactMap = new Map<String, Contact>();
        for (Contact c : [SELECT Id, Email FROM Contact WHERE Email IN :emails]) {
            contactMap.put(c.Email, c);
        }

        List<Enrollment_Score__c> recordsToInsert = new List<Enrollment_Score__c>();

        for (EnrollmentScoreRestController.ScoreWrapper s : requestData.scores) {

            EnrollmentScoreRestController.Result res =
                new EnrollmentScoreRestController.Result();

            res.email = s.contactEmail;

            if (!contactMap.containsKey(s.contactEmail)) {
                res.status = 'ERROR';
                res.message = 'Contact not found';
                response.results.add(res);
                continue;
            }

            Enrollment_Score__c rec = new Enrollment_Score__c(
                Contact__c = contactMap.get(s.contactEmail).Id,
                Score__c = s.score,
                Recommended_Action__c = s.recommendedAction,
                Source_System__c = s.sourceSystem,
                Scored_At__c = s.scoredAt
            );

            recordsToInsert.add(rec);

            res.status = 'SUCCESS';
            res.message = 'Record created';
            response.results.add(res);
        }

        if (!recordsToInsert.isEmpty()) {
            insert recordsToInsert;
        }

        return response;
    }
}
