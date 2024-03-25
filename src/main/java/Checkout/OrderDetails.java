package Checkout;

import java.util.ArrayList;

public class OrderDetails {
    private int orderId;
    private int productId;
    private double unitPrice;
    private int quantity;
    private double totalAmount;
    private String orderDate;
    private String status;
    private String paymentMethod;
    private String shippingAddress;
    private String trackingNumber;
    private String createdAt;
    private String updatedAt;
    private String productName; // Added member variable for product name
    private String imageUrl;    // Added member variable for image URL
    
    private ArrayList<OrderBillingDetails> billingDetails;

    // Constructors, getters, and setters for orderId and other fields

    public void setBillingDetails(ArrayList<OrderBillingDetails> billingDetails) {
        this.billingDetails = billingDetails;
    }


    // Constructor with all parameters including productName and imageUrl
    public OrderDetails(int orderId, int productId, double unitPrice, int quantity, double totalAmount,
                        String orderDate, String status, String paymentMethod, String shippingAddress,
                        String trackingNumber, String createdAt, String updatedAt,
                        String productName, String imageUrl) {
        this.orderId = orderId;
        this.productId = productId;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
        this.trackingNumber = trackingNumber;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.productName = productName;
        this.imageUrl = imageUrl;
    }

    // Getters and setters for member variables
    // (You can generate them automatically in IDE or write them manually)

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public String getTrackingNumber() {
		return trackingNumber;
	}

	public void setTrackingNumber(String trackingNumber) {
		this.trackingNumber = trackingNumber;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
    

    // Repeat for other member variables
	
	
	
	
}
