package yourpackage;

public class Product {
    private int productId;
    private String productName;
    private String productPrice;
    private String productCategory;
    private String productDescription;
	private String productImageUrl; // Add image URL property
	private int quantity;
	 
	public Product(int productId, String productName, String productPrice) {
	        this.productId = productId;
	        this.productName = productName;
	        this.productPrice = productPrice;
	    }

    
    // Constructor
    public Product(int productId, String productName, String productPrice,String productCategory,String productDescription ,String productImageUrl,int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productCategory=productCategory;
        this.productImageUrl = productImageUrl;
        this.productDescription=productDescription;
        this.quantity=quantity;
    }
    
    public Product(int productId, String productName, String productPrice,String productCategory,String productDescription ,String productImageUrl) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productCategory=productCategory;
        this.productImageUrl = productImageUrl;
        this.productDescription=productDescription;
    }
    // Getters and setters
    public int getProductId() {
        return productId;
    }
    
   
	public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getProductPrice() {
        return productPrice;
    }
    
    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }
    public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

    public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

    public String getProductImageUrl() {
        return productImageUrl;
    }
    
    public void setProductImageUrl(String productImageUrl) {
        this.productImageUrl = productImageUrl;
    }
    public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


}
