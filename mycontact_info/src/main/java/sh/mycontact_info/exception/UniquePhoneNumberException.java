package sh.mycontact_info.exception;

public class UniquePhoneNumberException extends RuntimeException{
    public UniquePhoneNumberException() {
        super();
    }

    public UniquePhoneNumberException(String message) {
        super(message);
    }

    public UniquePhoneNumberException(String message, Throwable cause) {
        super(message, cause);
    }

    public UniquePhoneNumberException(Throwable cause) {
        super(cause);
    }
}
