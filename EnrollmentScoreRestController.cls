@RestResource(urlMapping='/enrollment-scores')
global with sharing class EnrollmentScoreRestController {

    @HttpPost
    global static ResponseWrapper handlePost() {
        RestRequest req = RestContext.request;
        String body = req.requestBody.toString();

        RequestWrapper requestData = (RequestWrapper) JSON.deserialize(body, RequestWrapper.class);

        return EnrollmentScoreService.processScores(requestData);
    }

    // Request Wrapper
    global class RequestWrapper {
        public List<ScoreWrapper> scores;
    }

    global class ScoreWrapper {
        public String contactEmail;
        public Integer score;
        public String recommendedAction;
        public String sourceSystem;
        public Datetime scoredAt;
    }

    // Response Wrapper
    global class ResponseWrapper {
        public List<Result> results = new List<Result>();
    }

    global class Result {
        public String email;
        public String status;
        public String message;
    }
}
