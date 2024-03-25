<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="UserProfle.UserBillingDetails" %>
<%@ page import="UserProfle.Profile" %>
<%@ page import="java.util.List" %> 
<jsp:include page="View/Header.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* Adjustments for the profile page */
        .profile-container {
            margin-top: 50px;
        }
        .profile-title {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<%
      String userEmail = (String) session.getAttribute("email");

	List<UserBillingDetails> userDetailsList = Profile.fetchUserBillingDetails(userEmail);
        // Print the retrieved details
        for (UserBillingDetails userDetails : userDetailsList) {%>
    <div class="container-fluid py-5">
        <div class="container profile-container">
            <h1 class="profile-title">User Profile</h1>
            <!-- Profile Information -->
            <div class="row">
                <div class="col-md-6">
                    <label for="firstName">First Name:</label>
                    <input type="text" class="form-control" id="firstName" value="<%= userDetails.getFirstName() %>" disabled>
                </div>
                <div class="col-md-6">
                    <label for="lastName">Last Name:</label>
                    <input type="text" class="form-control" id="lastName" value="<%= userDetails.getLastName() %>" disabled>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-6">
                    <label for="email">Email Address:</label>
                    <input type="email" class="form-control" id="email" value="<%= userDetails.getUserEmail() %>" disabled>
                </div>
                <div class="col-md-6">
                    <label for="mobile">Mobile Number:</label>
                    <input type="tel" class="form-control" id="mobile" value="<%= userDetails.getMobile() %>" disabled>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-6">
                    <label for="townCity">Town/City:</label>
                    <input type="text" class="form-control" id="townCity" value="<%= userDetails.getTownCity() %>" disabled>
                </div>
                <div class="col-md-6">
                    <label for="country">Country:</label>
                    <input type="text" class="form-control" id="country" value="<%= userDetails.getCountry() %>" disabled>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-6">
                    <label for="postcode">Postcode:</label>
                    <input type="text" class="form-control" id="postcode" value="<%= userDetails.getPostcode() %>" disabled>
                </div>
                <div class="col-md-6">
                    <button type="button" class="btn btn-primary mt-3" onclick="openEditDetailsModal()">Edit Details</button>
                </div>
            </div>
            <!-- Change Password Section -->
            <div class="mt-5">
                <h2>Change Password</h2>
                <form id="changePasswordForm">
                    <div class="form-group">
                        <label for="oldPassword">Old Password</label>
                        <input type="password" class="form-control" id="oldPassword">
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" class="form-control" id="newPassword">
                    </div>
                    <button type="button" class="btn btn-primary" onclick="changePassword()">Change Password</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Details Modal -->
    <div class="modal fade" id="editDetailsModal" tabindex="-1" role="dialog" aria-labelledby="editDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editDetailsModalLabel">Edit Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Form for editing user details -->
                    <form id="editDetailsForm">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="editfirstName">First Name:</label>
                                <input type="text" class="form-control" id="editfirstName" value="<%= userDetails.getFirstName() %>">
                            </div>
                            <div class="col-md-6">
                                <label for="editlastName">Last Name:</label>
                                <input type="text" class="form-control" id="editlastName" value="<%= userDetails.getLastName() %>">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label for="editemail">Email Address:</label>
                                <input type="email" class="form-control" id="editemail" value="<%= userDetails.getUserEmail() %>">
                            </div>
                            <div class="col-md-6">
                                <label for="editmobile">Mobile Number:</label>
                                <input type="tel" class="form-control" id="editmobile" value="<%= userDetails.getMobile() %>">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label for="edittownCity">Town/City:</label>
                                <input type="text" class="form-control" id="edittownCity" value="<%= userDetails.getTownCity() %>">
                            </div>
                            <div class="col-md-6">
                                <label for="editcountry">Country:</label>
                                <input type="text" class="form-control" id="editcountry" value="<%= userDetails.getCountry() %>">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label for="editpostcode">Postcode:</label>
                                <input type="text" class="form-control" id="editpostcode" value="<%= userDetails.getPostcode() %>">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="saveDetailsChanges()">Save Changes</button>
                </div>
            </div>
        </div>
    </div>
<% }%>
    <!-- Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // Function to open edit details modal
        function openEditDetailsModal() {
            $('#editDetailsModal').modal('show');
        }

        // Function to save edited details
        function saveDetailsChanges() {
            // Retrieve values from modal form
            var editedFirstName = $('#editfirstName').val();
            var editedLastName = $('#editlastName').val();
            var editedemail = $('#editemail').val();
            var editedmobile = $('#editmobile').val();
            var editedtownCity = $('#edittownCity').val();
            var editedcountry = $('#editcountry').val();
            var editedpostcode = $('#editpostcode').val();

            
            $.ajax({
                type: "POST",
                url: "Profile",
                data: {
                    action: "updateUserDetails",
                    firstName: editedFirstName,
                    lastName: editedLastName,
                    email: editedemail,
                    mobile: editedmobile,
                    townCity: editedtownCity,
                    country: editedcountry,
                    postcode: editedpostcode
                },
                success: function(response) {
                    $('#editDetailsModal').modal('hide');
                    $('#firstName').val(editedFirstName);
                    $('#lastName').val(editedLastName);
                    $('#email').val(editedEmail);
                    $('#mobile').val(editedMobile);
                    $('#townCity').val(editedTownCity);
                    $('#country').val(editedCountry);
                    $('#postcode').val(editedPostcode);
                    // Update profile information on the page if necessary
                },
                error: function(xhr, status, error) {
                    // Handle error response
                }
            });
        }

        // Function to change password using AJAX
        function changePassword() {
            var oldPassword = $('#oldPassword').val();
            var newPassword = $('#newPassword').val();

            $.ajax({
                type: "POST",
                url: "Profile",
                data: {
                    action: "changePassword",
                    oldPassword: oldPassword,
                    newPassword: newPassword
                },
                success: function(response) {
                    $('#changePasswordModal').modal('hide');
                    // Show success message or handle response
                },
                error: function(xhr, status, error) {
                    // Handle error response (e.g., display password incorrect message)
                }
            });
        }
    </script>

</body>
</html>
