
trigger EnrollmentScoreTrigger on Enrollment_Score__c (after insert) {
    EnrollmentScoreHandler.updateContactPriority(Trigger.new);
}
