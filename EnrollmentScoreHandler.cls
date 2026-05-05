public class EnrollmentScoreHandler 
{
	 public static void updateContactPriority(List<Enrollment_Score__c> records) {

        Map<Id, Enrollment_Score__c> latestScoreMap = new Map<Id, Enrollment_Score__c>();

        for (Enrollment_Score__c rec : records) {
            if (!latestScoreMap.containsKey(rec.Contact__c) ||
                rec.Scored_At__c > latestScoreMap.get(rec.Contact__c).Scored_At__c) {
                latestScoreMap.put(rec.Contact__c, rec);
            }
        }

        List<Contact> contactsToUpdate = new List<Contact>();

        for (Id contactId : latestScoreMap.keySet()) {

            Decimal score = latestScoreMap.get(contactId).Score__c;
            String priority;

            if (score >= 75) priority = 'Hot';
            else if (score >= 40) priority = 'Warm';
            else priority = 'Cold';

            contactsToUpdate.add(new Contact(
                Id = contactId,
                Enrollment_Priority__c = priority
            ));
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}
