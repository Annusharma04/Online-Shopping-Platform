<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Checkout.MyOrders" %>
<%@ page import="Checkout.OrderDetails" %>
<%@ page import="java.util.ArrayList" %> 
    <%@ page import="Checkout.OrderBillingDetails" %>
    
<%@ page import="UserProfle.UserBillingDetails" %>
<%@ page import="UserProfle.Profile" %>
<%@ page import="java.util.List" %> 
    
<jsp:include page="View/Header.jsp" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- Additional CSS Files -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">

<link rel="stylesheet" href="https://allyoucan.cloud/cdn/icofont/1.0.1/icofont.css" integrity="sha384-jbCTJB16Q17718YM9U22iJkhuGbS0Gd2LjaWb4YJEZToOPmnKDjySVa323U+W7Fv" crossorigin="anonymous">
<link rel="stylesheet" href="assets/css/MyOrders.css">
</head>
<body>
    <div class="container-fluid py-5" style="margin-top: 80px;">

<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="osahan-account-page-left shadow-sm bg-white h-100">
                <div class="border-bottom p-4">
                    <div class="osahan-user text-center">
                        <div class="osahan-user-media">
                            <img class="mb-3 rounded-pill shadow-sm mt-1" src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="gurdeep singh osahan">
                            <div class="osahan-user-media-body">
                            
					<%
					      String userEmail = (String) session.getAttribute("email");
					
						List<UserBillingDetails> userDetailsList = Profile.fetchUserBillingDetails(userEmail);
					        // Print the retrieved details
					        for (UserBillingDetails userDetails : userDetailsList) {%>
                            
                                <h6 class="mb-2"><%= userDetails.getFirstName() %> <%= userDetails.getLastName() %></h6>
                                <p class="mb-1"><%= userDetails.getMobile() %></p>
                                <p><%= userDetails.getUserEmail() %></p>
								<p class="mb-0 text-black font-weight-bold">
								    <a class="text-primary mr-3"  href="Profile.jsp">
								        <i class="icofont-ui-edit"></i> EDIT
								    </a>
								</p>
                            <%} %>
                            </div>
                        </div>
                    </div>
                </div>
                <ul class="nav nav-tabs flex-column border-0 pt-4 pl-4 pb-4" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link" id="orders-tab" data-toggle="tab" href="#orders" role="tab" aria-controls="orders" aria-selected="false"><i class="icofont-food-cart"></i> Orders</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-md-9">
            <div class="osahan-account-page-right shadow-sm bg-white p-4 h-100">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane  fade  active show" id="orders" role="tabpanel" aria-labelledby="orders-tab">
                        <h4 class="font-weight-bold mt-0 mb-4">My Orders</h4>
                        
                        <% 
						        // Fetch order details for the current user
						        ArrayList<OrderDetails> orderDetails = MyOrders.fetchOrderDetails(userEmail);
						    %>
						     <% for (OrderDetails orderDetail : orderDetails) { %> 
                        <div class="bg-white card mb-4 order-list shadow-sm">
                            <div class="gold-members p-4">
                                <a href="#">
                                </a>
                                
                                <div class="media">
                                    <a href="#">
                                        <img class="mr-4" src="assets/images/<%= orderDetail.getImageUrl() %>" alt="Generic placeholder image">
                                    </a>

                                    <div class="media-body">
                                        <a href="#">
                                            <span class="float-right text-info">Not Delieverd <i class="icofont-check-circled text-success"></i></span>
                                        </a>
                                        <h6 class="mb-2">
                                            <a href="#"></a>
                                            <a href="#" class="text-black"><%= orderDetail.getProductName() %></a>
                                        </h6>
                                                  <% 
								                        ArrayList<OrderBillingDetails> billingDetails = MyOrders.fetchBillingDetailsForOrder(orderDetail.getOrderId());
								                        for (OrderBillingDetails billingDetail : billingDetails) { 
								                    %>
                                        <p class="text-gray mb-1"><i class="icofont-location-arrow"></i> <%= billingDetail.getAddress() %>, <%= billingDetail.getTownCity() %>, <%= billingDetail.getCountry() %> <%= billingDetail.getPostcode() %>
                                        </p><%} %>
                                        <p class="text-gray mb-3"><i class="icofont-list"></i> ORDER #<%= orderDetail.getOrderId() %> <i class="icofont-clock-time ml-2"></i><%= orderDetail.getOrderDate() %></p>
                                        <p class="text-dark"><%= orderDetail.getProductName() %> * <%= orderDetail.getQuantity() %>
                                        </p>
                                        <hr>
                                        <div class="float-right">
                                            <a class="btn btn-sm btn-outline-primary" href="#"><i class="icofont-headphone-alt"></i> Check Status</a>
                                            <a class="btn btn-sm btn-primary" href="#"><i class="icofont-refresh"></i> View Details</a>
                                        </div>
                                        <p class="mb-0 text-black text-primary pt-2"><span class="text-black font-weight-bold"> Total Paid:</span> <%= orderDetail.getUnitPrice() %>
                                        </p>
                                    </div>
                                    
                                    
                                </div>

                            </div>
                        </div>
                        <%} %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

    <!-- jQuery -->
    <script src="assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="assets/js/popper.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

</body>
</html>