
@RestResource(urlMapping='/enrollment-scores')
global with sharing class EnrollmentScoreRestController {
    @HttpPost
    global static EnrollmentScoreWrapper.ResponseWrapper doPost() {
        return new EnrollmentScoreWrapper.ResponseWrapper();
    }
}
