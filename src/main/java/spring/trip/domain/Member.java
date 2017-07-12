package spring.trip.domain;

public class Member {
	// field
	private String email;
	private String nickname;
	private String username;
	private String password;
	private String address;
	
	// constructors
	public Member(){}
	
	public Member(String email, String nickname, String username, String password, String address) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.username = username;
		this.password = password;
		this.address = address;
	}

	// setters and getters
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Member [email=" + email + ", nickname=" + nickname + ", username=" + username + ", password=" + password
				+ ", address=" + address + "]";
	}	
}
