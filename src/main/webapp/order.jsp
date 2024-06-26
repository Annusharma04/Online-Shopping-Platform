<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    
  <%@ page import="java.util.*, OrderPage.CheckOrder, OrderPage.OrderDetails" %>
  
<jsp:include page="Main.jsp" />
<div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
			    
			    <div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <h1 class="app-page-title mb-0">Orders</h1>
				    </div>
				    <div class="col-auto">
					     <div class="page-utilities">
						    <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
							    <div class="col-auto">
								    <form class="table-search-form row gx-1 align-items-center">
					                    <div class="col-auto">
					                        <input type="text" id="search-orders" name="searchorders" class="form-control search-orders" placeholder="Search">
					                    </div>
					                    <div class="col-auto">
					                        <button type="submit" class="btn app-btn-secondary">Search</button>
					                    </div>
					                </form>
					                
							    </div><!--//col-->
							    
						    </div><!--//row-->
					    </div><!--//table-utilities-->
				    </div><!--//col-auto-->
			    </div><!--//row-->
			   
			    
			    <nav id="orders-table-tab" class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
				    <a class="flex-sm-fill text-sm-center nav-link active" id="orders-all-tab" data-bs-toggle="tab" href="#orders-all" role="tab" aria-controls="orders-all" aria-selected="true">All</a>
				    <a class="flex-sm-fill text-sm-center nav-link"  id="orders-paid-tab" data-bs-toggle="tab" href="#orders-paid" role="tab" aria-controls="orders-paid" aria-selected="false">Paid</a>
				    <a class="flex-sm-fill text-sm-center nav-link" id="orders-pending-tab" data-bs-toggle="tab" href="#orders-pending" role="tab" aria-controls="orders-pending" aria-selected="false">Pending</a>
				    <a class="flex-sm-fill text-sm-center nav-link" id="orders-cancelled-tab" data-bs-toggle="tab" href="#orders-cancelled" role="tab" aria-controls="orders-cancelled" aria-selected="false">Cancelled</a>
				</nav>
				
				
				<div class="tab-content" id="orders-table-tab-content">
			        <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
					    <div class="app-card app-card-orders-table shadow-sm mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
							        <table class="table app-table-hover mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">Order</th>
												<th class="cell">Product</th>
												<th class="cell">Customer</th>
												<th class="cell">Date</th>
												<th class="cell">Status</th>
												<th class="cell">Total</th>
												<th class="cell"></th>
											</tr>
										</thead>
										<tbody>
										    <%
										        CheckOrder checkorder = new CheckOrder();
										        List<OrderDetails> orderDetailsList = checkorder.getOrders();
										        if (!orderDetailsList.isEmpty()) {
										            for (OrderDetails orderdetails : orderDetailsList) {
										                System.out.println(orderdetails.getOrderId());
										    %>
										                <tr>
										                    <td><%= orderdetails.getOrderId() %></td>
										                    <td><%= orderdetails.getProductName() %></td>
										                    <td><%= orderdetails.getUserName() %></td>
										                    <td><%= orderdetails.getOrderDate() %></td>
										                    <td><%= orderdetails.getStatus() %></td>
										                    <td><%= orderdetails.getTotalAmount() %></td>
										                </tr>
										    <%
										            }
										        } else {
										    %>
										            <tr>
										                <td colspan="6">No orders</td>
										            </tr>
										    <%
										        }
										    %>
										</tbody>

									</table>
						        </div><!--//table-responsive-->
						       
						    </div><!--//app-card-body-->		
						</div><!--//app-card-->
						<nav class="app-pagination">
							<ul class="pagination justify-content-center">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
							    </li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item">
								    <a class="page-link" href="#">Next</a>
								</li>
							</ul>
						</nav><!--//app-pagination-->
						
			        </div><!--//tab-pane-->
			        
			        <div class="tab-pane fade" id="orders-paid" role="tabpanel" aria-labelledby="orders-paid-tab">
					    <div class="app-card app-card-orders-table mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
								    
							        <table class="table mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">Order</th>
												<th class="cell">Product</th>
												<th class="cell">Customer</th>
												<th class="cell">Date</th>
												<th class="cell">Status</th>
												<th class="cell">Total</th>
												<th class="cell"></th>
											</tr>
										</thead>
										<tbody>
										    <%
										         if (!orderDetailsList.isEmpty()) {
										            for (OrderDetails orderdetails : orderDetailsList) {
										                if ("paid".equals(orderdetails.getStatus())) { // Check if the status is "paid"
										    %>
										                    <tr>
										                        <td><%= orderdetails.getOrderId() %></td>
										                        <td><%= orderdetails.getProductName() %></td>
										                        <td><%= orderdetails.getUserName() %></td>
										                        <td><%= orderdetails.getOrderDate() %></td>
										                        <td><%= orderdetails.getStatus() %></td>
										                        <td><%= orderdetails.getTotalAmount() %></td>
										                    </tr>
										    <%
										                }
										                else{
										                	%>
												            <tr>
												                <td colspan="6">No paid orders</td>
												            </tr>
												    <%
										                }
										            }
										        } 
										    %>
										</tbody>

									</table>
						        </div><!--//table-responsive-->
						    </div><!--//app-card-body-->		
						</div><!--//app-card-->
			        </div><!--//tab-pane-->
			        
			        <div class="tab-pane fade" id="orders-pending" role="tabpanel" aria-labelledby="orders-pending-tab">
					    <div class="app-card app-card-orders-table mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
							        <table class="table mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">Order</th>
												<th class="cell">Product</th>
												<th class="cell">Customer</th>
												<th class="cell">Date</th>
												<th class="cell">Status</th>
												<th class="cell">Total</th>
												<th class="cell"></th>
											</tr>
										</thead>
										<tbody>
										    <%
										         if (!orderDetailsList.isEmpty()) {
										            for (OrderDetails orderdetails : orderDetailsList) {
										                if ("pending".equals(orderdetails.getStatus())) { // Check if the status is "paid"
										    %>
										                    <tr>
										                        <td><%= orderdetails.getOrderId() %></td>
										                        <td><%= orderdetails.getProductName() %></td>
										                        <td><%= orderdetails.getUserName() %></td>
										                        <td><%= orderdetails.getOrderDate() %></td>
										                        <td><%= orderdetails.getStatus() %></td>
										                        <td><%= orderdetails.getTotalAmount() %></td>
										                    </tr>
										    <%
										                }
										                else{
										                	%>
												            <tr>
												                <td colspan="6">No pending orders</td>
												            </tr>
												    <%
										                }
										            }
										        } 
										    %>
										</tbody>

									</table>
						        </div><!--//table-responsive-->
						    </div><!--//app-card-body-->		
						</div><!--//app-card-->
			        </div><!--//tab-pane-->
			        <div class="tab-pane fade" id="orders-cancelled" role="tabpanel" aria-labelledby="orders-cancelled-tab">
					    <div class="app-card app-card-orders-table mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
							        <table class="table mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">Order</th>
												<th class="cell">Product</th>
												<th class="cell">Customer</th>
												<th class="cell">Date</th>
												<th class="cell">Status</th>
												<th class="cell">Total</th>
												<th class="cell"></th>
											</tr>
										</thead>
										<tbody>
										<tbody>
										    <%
										         if (!orderDetailsList.isEmpty()) {
										            for (OrderDetails orderdetails : orderDetailsList) {
										                if ("cancelled".equals(orderdetails.getStatus())) { // Check if the status is "paid"
										    %>
										                    <tr>
										                        <td><%= orderdetails.getOrderId() %></td>
										                        <td><%= orderdetails.getProductName() %></td>
										                        <td><%= orderdetails.getUserName() %></td>
										                        <td><%= orderdetails.getOrderDate() %></td>
										                        <td><%= orderdetails.getStatus() %></td>
										                        <td><%= orderdetails.getTotalAmount() %></td>
										                    </tr>
										    <%
										                }
										                else{
										                	%>
												            <tr>
												                <td colspan="6">No cancelled orders</td>
												            </tr>
												    <%
										                }
										            }
										        } 
										    %>
										</tbody>
									</table>
						        </div><!--//table-responsive-->
						    </div><!--//app-card-body-->		
						</div><!--//app-card-->
			        </div><!--//tab-pane-->
				</div><!--//tab-content-->
				
				
			    
		    </div><!--//container-fluid-->
	    </div><!--//app-content-->
	    
	    <footer class="app-footer">
		    <div class="container text-center py-3">
		         <!--/* This template is free as long as you keep the footer attribution link. If you'd like to use the template without the attribution link, you can buy the commercial license via our website: themes.3rdwavemedia.com Thank you for your support. :) */-->
            <small class="copyright">Designed with <span class="sr-only">love</span><i class="fas fa-heart" style="color: #fb866a;"></i> by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
		       
		    </div>
	    </footer><!--//app-footer-->
	    
    </div><!--//app-wrapper-->    					

 
    <!-- Javascript -->          
    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>  
    
    
    <!-- Page Specific JS -->
    <script src="assets/js/app.js"></script> 

</body>
</html> 

										
    