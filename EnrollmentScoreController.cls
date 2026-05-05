public with sharing class EnrollmentScoreController {

    @AuraEnabled(cacheable=true)
    public static Enrollment_Score__c getLatestScore(Id contactId) {

        List<Enrollment_Score__c> scores = [
            SELECT Score__c, Recommended_Action__c, Source_System__c, Scored_At__c
            FROM Enrollment_Score__c
            WHERE Contact__c = :contactId
            ORDER BY Scored_At__c DESC
            LIMIT 1
        ];

        if (scores.isEmpty()) return null;
        return scores[0];
    }
}
