package sh.mycontact_info.exception;

public class PersonIsNotFoundException extends RuntimeException{
    private static final String MESSAGE = "The Person Entity is not existed";

    public PersonIsNotFoundException() {
        super(MESSAGE);
    }
}
