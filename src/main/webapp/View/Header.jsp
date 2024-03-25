<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <title>Hexashop Ecommerce HTML CSS Template</title>


    <!-- Additional CSS Files -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">

    <link rel="stylesheet" href="assets/css/templatemo-hexashop.css">

    <link rel="stylesheet" href="assets/css/owl-carousel.css">

    <link rel="stylesheet" href="assets/css/lightbox.css">
<!--

TemplateMo 571 Hexashop

https://templatemo.com/tm-571-hexashop

-->
    </head>
    
    <body>
    
    <!-- ***** Preloader Start ***** -->
    <div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>  
    <!-- ***** Preloader End ***** -->
    
    
    <!-- ***** Header Area Start ***** -->
    <header class="header-area header-sticky">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav class="main-nav">
                        <!-- ***** Logo Start ***** -->
                        <a href="index.html" class="logo">
                            <img src="assets/images/logo.png">
                        </a>
                        <!-- ***** Logo End ***** -->
                        <!-- ***** Menu Start ***** -->
                        <ul class="nav">
                            <li class="scroll-to-section"><a href="AfterLogin.jsp" id="homeLink">Home</a></li>
						    <li class="scroll-to-section"><a href="MenClothesPage.jsp" id="menLink">Men's</a></li>
						    <li class="scroll-to-section"><a href="WomenClothesPage.jsp" id="womenLink">Women's</a></li>
						    <li class="scroll-to-section"><a href="KidClothesPage.jsp" id="kidLink">Kid's</a></li>
						           <li><a href="about.jsp">About Us</a></li>
                                    <li><a href="Contact.jsp">Contact Us</a></li>
                              
                            <li class="submenu">
                                <a href="javascript:;">My Account</a>
                                <ul>
                                    <li><a href="Profile.jsp">Profile</a></li>
                                    <li><a href="cart.jsp">Cart</a></li>
                                    <li><a href="MyOrders.jsp">My orders</a></li>
                                    <li><a href="#">Logout</a></li>
                                </ul>
                            </li>
                        </ul>        
                        <a class='menu-trigger'>
                            <span>Menu</span>
                        </a>
                        <!-- ***** Menu End ***** -->
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ***** Header Area End ***** -->
    

    
    <!-- jQuery -->
    <script src="assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="assets/js/popper.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Plugins -->
    <script src="assets/js/owl-carousel.js"></script>
    <script src="assets/js/accordions.js"></script>
    <script src="assets/js/datepicker.js"></script>
    <script src="assets/js/scrollreveal.min.js"></script>
    <script src="assets/js/waypoints.min.js"></script>
    <script src="assets/js/jquery.counterup.min.js"></script>
    <script src="assets/js/imgfix.min.js"></script> 
    <script src="assets/js/slick.js"></script> 
    <script src="assets/js/lightbox.js"></script> 
    <script src="assets/js/isotope.js"></script> 
    
    <!-- Global Init -->
    <script src="assets/js/custom.js"></script>

    <script>
    
 // Get the current page URL
    var currentPage = window.location.href;

    // Check if the current page URL contains the specific page names and add the 'active' class accordingly
    if (currentPage.indexOf('MenClothesPage.jsp') !== -1) {
        document.getElementById('menLink').classList.add('active');
    } else if (currentPage.indexOf('WomenClothesPage.jsp') !== -1) {
        document.getElementById('womenLink').classList.add('active');
    } else if (currentPage.indexOf('KidClothesPage.jsp') !== -1) {
        document.getElementById('kidLink').classList.add('active');
    } else {
        document.getElementById('homeLink').classList.add('active');
    }

    
    
    
    

        $(function() {
            var selectedClass = "";
            $("p").click(function(){
            selectedClass = $(this).attr("data-rel");
            $("#portfolio").fadeTo(50, 0.1);
                $("#portfolio div").not("."+selectedClass).fadeOut();
            setTimeout(function() {
              $("."+selectedClass).fadeIn();
              $("#portfolio").fadeTo(50, 1);
            }, 500);
                
            });
        });

    </script>
    
</body>
</html>