package UserProfle;

public class UserBillingDetails {
    private String userName;
    private String userEmail;
    private String userRole;
    private int userId;
    private String firstName;
    private String lastName;
    private String companyName;
    private String address;
    private String townCity;
    private String country;
    private String postcode;
    private String mobile;
    private String notes;

    // Constructor
    public UserBillingDetails( String userEmail, String userRole, int userId,
                              String firstName, String lastName, String townCity, String country,
                              String postcode, String mobile) {
        this.userEmail = userEmail;
        this.userRole = userRole;
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.townCity = townCity;
        this.country = country;
        this.postcode = postcode;
        this.mobile = mobile;
    }

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTownCity() {
		return townCity;
	}

	public void setTownCity(String townCity) {
		this.townCity = townCity;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

    
}
