package bean;

public class ReturnBean {

	int code;
	String message;
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}


	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public ReturnBean() {
		// TODO Auto-generated constructor stub
	}
	public ReturnBean(int code, String message) {
		super();
		this.code = code;
		this.message = message;
	}

}
