
public class EnrollmentScoreWrapper {
    public class ScoreWrapper {
        public String contactEmail;
        public Integer score;
        public String recommendedAction;
        public String sourceSystem;
        public Datetime scoredAt;
    }
    public class RequestWrapper {
        public List<ScoreWrapper> scores;
    }
    public class ResponseWrapper {
        public List<Result> results = new List<Result>();
    }
    public class Result {
        public String email;
        public String status;
        public String message;
    }
}
