<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="Main.jsp" />

<div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
			<div class="col-12 col-md-8">
    <div class="app-card app-card-settings shadow-sm p-4">
        
        <div class="app-card-body">
            <form class="settings-form" action="AddProductServlet" method="post">
                <div class="mb-3">
                    <label for="product-name" class="form-label">Product Name<span class="ms-2" data-bs-container="body" data-bs-toggle="popover" data-bs-trigger="hover focus"  data-bs-placement="top" data-bs-content="Provide the name of the product."><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-info-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg"></label>
                    <input type="text" class="form-control" id="product-name" name="product-name" required>
                </div>
                <div class="mb-3">
                    <label for="product-category" class="form-label">Product Category</label>
                    <select class="form-select" id="product-category" name="product-category" required>
                        <option value="">Select Category</option>
                        <option value="women">Women</option>
                        <option value="men">Men</option>
                        <option value="kids">Kids</option>
                        <option value="accessories">Accessories</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="product-price" class="form-label">Product Price</label>
                    <input type="text" class="form-control" id="product-price" name="product-price" required>
                </div>
                <div class="mb-3">
                    <label for="product-quantity" class="form-label">Product Quantity</label>
                    <input type="text" class="form-control" id="product-quantity" name="product-quantity" required>
                </div>
                <div class="mb-3">
                    <label for="product-images" class="form-label">Product Images</label>
                    <input type="file" class="form-control" id="product-images" name="product-images" accept="image/*" multiple>
                </div>
                <div class="mb-3">
                    <label for="product-description" class="form-label">Product Description</label>
                    <textarea class="form-control" id="product-description" name="product-description" rows="4"></textarea>
                </div>
                <button type="submit" class="btn app-btn-primary">Add Product</button>
            </form>
        </div><!--//app-card-body-->
        
    </div><!--//app-card-->
</div>
			
			
			</div>
		</div>
	</div>

</body>
</html>