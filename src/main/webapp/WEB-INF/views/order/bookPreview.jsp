<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Home | Triangle</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet"> 
    <link href="css/lightbox.css" rel="stylesheet"> 
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">


	<!-- bookpreview : 미리보기 부분 -->
	<link rel="stylesheet" type="text/css" href="css/bookpreview/default.css" />
	<link rel="stylesheet" type="text/css" href="css/bookpreview/bookblock.css" />
	<link rel="stylesheet" type="text/css" href="css/bookpreview/demo4.css" />
	<script src="js/bookpreview/modernizr.custom.js"></script>


	<!-- fomats -->
	<script src="https://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
    <link rel='stylesheet prefetch' href='css/bookpreview/bookfomat.css'>


    <!--[if lt IE 9]>
	    <script src="js/html5shiv.js"></script>
	    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
    <script type="text/javascript">
		$(function(){
			// 로그아웃 버튼 클릭 시 confirm
    		$('#logoutA').click(function(){
    			if(confirm("로그아웃 하시겠습니까?")){
    	    		 alert("로그아웃되었습니다.")
    	    		 location.href="logout.do";
    	    	 }else{
    	    		 return;
    	    	 }
    		});

			var orderPrice=0;
			$('#quantity').keyup(function() {
				var quantity = $(this).val();
				var price = $('input[name=price]').val();
				orderPrice = quantity*price;
				$('#price').html(orderPrice+"원");
			});//keyup
			
			$('#orderFrm').submit(function() {
				var num = $('input[name=quantity]').val();
				if(num<=0){
					alert("1이상을 입력해주세요");
					return false;
				}else
					return confirm(num+"개의 책을 주문하시겠습니까?");
			});//click
		});//function	
</script>
<style type="text/css">
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
</style>
</head>
<body>
	<!-- --------------------------------------------- [시작] Header --------------------------------------------- -->
	<c:choose>
		<c:when test="${sessionScope.mvo != null}">
			<header id="header">      
		        <div class="container">
		            <div class="row">
		                <div class="col-sm-12 overflow">
		                   <div class="social-icons pull-right">
		                        <ul class="nav nav-pills">
		                            <li><a href=""><i class="fa fa-facebook"></i></a></li>
		                            <li><a href=""><i class="fa fa-twitter"></i></a></li>
		                            <li><a href=""><i class="fa fa-google-plus"></i></a></li>
		                            <li><a href=""><i class="fa fa-dribbble"></i></a></li>
		                            <li><a href=""><i class="fa fa-linkedin"></i></a></li>
		                        </ul>
		                    </div> 
		                </div>
		             </div>
		        </div>
		        <div class="navbar navbar-inverse" role="banner">
		            <div class="container">
		                <div class="navbar-header">
		                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		                        <span class="sr-only">Toggle navigation</span>
		                        <span class="icon-bar"></span>
		                        <span class="icon-bar"></span>
		                        <span class="icon-bar"></span>
		                    </button>
		
		                    <a class="navbar-brand" href="getMyBookList.do">
		                    	<h1><img src="images/logo.png" alt="logo"></h1>
		                    </a>
		                    
		                </div>
		                <div class="collapse navbar-collapse">
		                    <ul class="nav navbar-nav navbar-right">
		                        <li class="active"><a href="getMyBookList.do">Home</a></li>
		                        <li class="dropdown"><a href="showMemberInfo.do?email=${sessionScope.mvo.email}">내 프로필 조회</a></li>
		                        <li class="dropdown"><a href="getOrderListOfMember.do">내 주문 내역 조회</a></li>
		                        <li class="dropdown"><a href="getBookmarks.do?email=${sessionScope.mvo.email}">내 북마크 조회</a></li>
		                        <li class="dropdown"><a href="getOtherBookList.do">다른 사람들 스토리북 구경하기</a></li>
		                        <li class="dropdown"><a id="logoutA">로그아웃</a></li>
		                    </ul>
		                </div>
		                <div class="search">
		                    <form role="form">
		                        <i class="fa fa-search"></i>
		                        <div class="field-toggle">
		                            <input type="text" class="search-form" autocomplete="off" placeholder="Search">
		                        </div>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </header>
		</c:when>
		<c:otherwise>
			<header id="header">      
		        <div class="container">
		            <div class="row">
		                <div class="col-sm-12 overflow">
		                   <div class="social-icons pull-right">
		                        <ul class="nav nav-pills">
		                            <li><a href=""><i class="fa fa-facebook"></i></a></li>
		                            <li><a href=""><i class="fa fa-twitter"></i></a></li>
		                            <li><a href=""><i class="fa fa-google-plus"></i></a></li>
		                            <li><a href=""><i class="fa fa-dribbble"></i></a></li>
		                            <li><a href=""><i class="fa fa-linkedin"></i></a></li>
		                        </ul>
		                    </div> 
		                </div>
		             </div>
		        </div>
		        <div class="navbar navbar-inverse" role="banner">
		            <div class="container">
		                <div class="navbar-header">
		                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		                        <span class="sr-only">Toggle navigation</span>
		                        <span class="icon-bar"></span>
		                        <span class="icon-bar"></span>
		                        <span class="icon-bar"></span>
		                    </button>
		
		                    <a class="navbar-brand" href="index.jsp">
		                    	<h1><img src="images/logo.png" alt="logo"></h1>
		                    </a>
		                    
		                </div>
		                <div class="collapse navbar-collapse">
		                    <ul class="nav navbar-nav navbar-right">
		                        <li class="active"><a href="index.jsp">Home</a></li>
		                        <li class="dropdown"><a href="getAllBookList.do">다른 사람들 스토리북 구경하기</a></li>
		                    </ul>
		                </div>
		                <div class="search">
		                    <form role="form">
		                        <i class="fa fa-search"></i>
		                        <div class="field-toggle">
		                            <input type="text" class="search-form" autocomplete="off" placeholder="Search">
		                        </div>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </header>
		</c:otherwise>
	</c:choose>
	<!-- --------------------------------------------- [끝] Header --------------------------------------------- -->
	    
	<!-- --------------------------------------------- [시작] 제목 Section --------------------------------------------- -->
	<section id="page-breadcrumb">
    	<div class="vertical-center sun">
        	<div class="container">
            	<div class="row">
               		<div class="action">
                     	<div class="col-sm-12">
                            <h1 class="title">주문 페이지</h1>
                            <p>주문 상품의 정보를 확인하시고 수량을 입력해주십시오.</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->


<br><br>
<div align="center"> [ 인쇄 : 미리보기 ] </div><br>

<section class="booksection">

<div class="container" style="width: 800px; height: 400px;">
			<div class="bb-custom-wrapper">
				
				<div id="bb-bookblock" class="bb-bookblock">
					<div class="bb-item">
						<div class="bb-custom-firstpage">
							<h1>BookInfo <span>Back-Cover : 인쇄시 입력x</span></h1>	
							<nav class="codrops-demos">
								book_no : ${bookInfo.book_no }<br><br>
								book_title : ${bookInfo.book_title }<br><br>
								book_create_date : ${bookInfo.book_create_date }<br><br>
							</nav>
						</div>
						<div class="bb-custom-side" id="bookcoverpic" style="background-image: url('upload/${bookInfo.book_picture_url}');" >            
								이부분은 표지입니다. 책배경은 사용자 지정<br><br>
								${bookInfo.book_title }<br><br>
						</div>
					</div>
					
					<c:forEach items="${storyInfo }" var="story">
					<div class="bb-item">
					
							<div class="bb-custom-side">		
							   <img src="upload/${story.storyPictureUrl}" width="320" height="250">		
							</div>
							
							<div class="bb-custom-side">				
								 storyNo : ${story.storyNo }<br><br>
						         storyTitle : ${story.storyTitle }<br><br>
						         storyContent : ${story.storyContent }<br><br>
						         storyLocation : ${story.storyLocation }<br><br>
						         storyTripDate : ${story.storyTripDate }<br><br>						       				      
						         storyCreateDate : ${story.storyCreateDate }<br><br>		
							</div>
						
					</div>
					</c:forEach>
						
					<div class="bb-item">
							<div class="bb-custom-side">
								마지막장 입니다.<br><br>
								수량을 정해주세요.<p>
							</div>
							
							<div class="bb-custom-side">
								<form action="howToPay.do" method="post" id="orderFrm">
							   		<input type="hidden" name="book_no" value="${bookInfo.book_no}" >
							   		<input type="hidden" name="price" value="${bookInfo.price}">
							   		Quantity : <input type="number" name="quantity" required="required" id="quantity">
							   		<span id="price"></span><br><br>
							   		<input type="submit" value="책주문하기(결제)">
							   	</form>	
							</div>
					</div>	
												
				</div>
				<br>
				<nav>
					<a id="bb-nav-first" href="#" class="bb-custom-icon bb-custom-icon-first">First page</a>
					<a id="bb-nav-prev" href="#" class="bb-custom-icon bb-custom-icon-arrow-left">Previous</a>
					<a id="bb-nav-next" href="#" class="bb-custom-icon bb-custom-icon-arrow-right">Next</a>
					<a id="bb-nav-last" href="#" class="bb-custom-icon bb-custom-icon-last">Last page</a>
				</nav>		
			</div>

</div>
</div>
<!-- /container -->
</section>


<br><br><br><br><br><br><br><br>




<!-- ----------------------------------------- Fomats ----------------------------------------- -->


<section class="fomats" style="height: 500px; width: 900px;">
	
		<div class="container clearfix">
			<div class="content grid_2 contactype active" id="contact-mapClick">
				<div class="icon-map"></div>
				<p>BOOK</p>
			</div>
			<div class="content grid_2 contactype" id="contact-carClick">
				<div class="icon-car"></div>
				<p>COVER</p>
			</div>
			<div class="content grid_2 contactype" id="contact-busClick">
				<div class="icon-bus"></div>
				<p>SIZE</p>
			</div>
	
			<div class="content grid_2 contactype" id="contact-bikeClick">
				<div class="icon-bike-2"></div>
				<p>PAPER</p>
			</div>
			<div class="content grid_2 contactype" id="contact-phoneClick">
				<div class="icon-phone"></div>
				<p>END SHEETS</p>
			</div>
			
			<div class="content grid_2 contactype omega" id="contact-mailClick">
				<div class="icon-mail"></div>
				<p>LOGO</p>
			</div>
	
			<div class="content grid_12 contactmap" id="contact-map">
				<div class="grid_4">
					<h2>CONTACT</h2>
					<p class="information"><span class="icon-location"> ADRESS: </span>Maecenas faucibus mollis interdum.</p>
					<p class="information"><span class="icon-phone-2"> TELEPHONE: </span> 0 (123) 456 789</p>
					<a class="btn" href="https://goo.gl/maps/8GlbZ" target="_blank">Get Direction</a>
					<div class="clear"></div>
				</div>
			</div>
	
			<div class="content grid_12 contactmap dn" id="contact-car">
				<div class="grid_4">
					<h2>CAR</h2>
					<p class="information"><span class="icon-location"> ADRESS: </span>Maecenas faucibus mollis interdum.</p>
					<br><br>
					<div class="btn"><span class="icon-checkmark"></span> Car Park</div>
				</div>
			</div>
	
			<div class="content grid_12 contactmap dn" id="contact-bus">
				<div class="grid_4">
					<h2>BUS</h2>
					<p class="information"><span class="icon-location"> ADRESS: </span>Maecenas faucibus mollis interdum.</p>
					<br><br>
					<div class="btn"><span class="icon-checkmark"></span> OTOPARK MEVCUT</div>
				</div>
			</div>
	
			<div class="content grid_12 contactmap dn" id="contact-bike">
				<div class="grid_4">
					<h2>BIKE</h2>
					<p class="information"><span class="icon-location"> ADRESS: </span>Maecenas faucibus mollis interdum.</p>
					<br><br>
					<div class="btn"><span class="icon-checkmark"></span> BİSİKLETLİK MEVCUT</div>
				</div>
			</div>
	
			<div class="content grid_12 contactmap dn" id="contact-phone">
				<div class="grid_4">
					<h2>TELEPHONE</h2>
					<p class="information"><span class="icon-location"> ADRESS: </span>Maecenas faucibus mollis interdum.</p>
				</div>
			</div>
	
	
			<div class="content grid_12 contactmap dn" id="contact-mail">
				<div class="grid_4">
					<h2>E-MAIL</h2>
					<p class="information"><span class="icon-location"> ADRESS: </span>Maecenas faucibus mollis interdum.</p>
				</div>
			</div>
			
		</div>
	
</section>

 	<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="js/bookpreview/bookfomat.js"></script>

  

<!-- Fomats -->

   


<!-- footer -->
	<br>
    <br>
    <br>
    
    <footer id="footer">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 text-center bottom-separator">
                    <img src="images/home/under.png" class="img-responsive inline" alt="">
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="testimonial bottom">
                        <h2>Testimonial</h2>
                        <div class="media">
                            <div class="pull-left">
                                <a href="#"><img src="images/home/profile1.png" alt=""></a>
                            </div>
                            <div class="media-body">
                                <blockquote>Nisi commodo bresaola, leberkas venison eiusmod bacon occaecat labore tail.</blockquote>
                                <h3><a href="#">- Jhon Kalis</a></h3>
                            </div>
                         </div>
                        <div class="media">
                            <div class="pull-left">
                                <a href="#"><img src="images/home/profile2.png" alt=""></a>
                            </div>
                            <div class="media-body">
                                <blockquote>Capicola nisi flank sed minim sunt aliqua rump pancetta leberkas venison eiusmod.</blockquote>
                                <h3><a href="">- Abraham Josef</a></h3>
                            </div>
                        </div>   
                    </div> 
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="contact-info bottom">
                        <h2>Contacts</h2>
                        <address>
                        E-mail: <a href="mailto:someone@example.com">email@email.com</a> <br> 
                        Phone: +1 (123) 456 7890 <br> 
                        Fax: +1 (123) 456 7891 <br> 
                        </address>

                        <h2>Address</h2>
                        <address>
                        Unit C2, St.Vincent's Trading Est., <br> 
                        Feeder Road, <br> 
                        Bristol, BS2 0UY <br> 
                        United Kingdom <br> 
                        </address>
                    </div>
                </div>
                <div class="col-md-4 col-sm-12">
                    <div class="contact-form bottom">
                        <h2>Send a message</h2>
                        <form id="main-contact-form" name="contact-form" method="post" action="sendemail.php">
                            <div class="form-group">
                                <input type="text" name="name" class="form-control" required="required" placeholder="Name">
                            </div>
                            <div class="form-group">
                                <input type="email" name="email" class="form-control" required="required" placeholder="Email Id">
                            </div>
                            <div class="form-group">
                                <textarea name="message" id="message" required="required" class="form-control" rows="8" placeholder="Your text here"></textarea>
                            </div>                        
                            <div class="form-group">
                                <input type="submit" name="submit" class="btn btn-submit" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
             
            </div>
        </div>
    </footer>
    <!--/#footer-->



<!-- script -->

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<script src="js/bookpreview/jquerypp.custom.js"></script>
		<script src="js/bookpreview/jquery.bookblock.js"></script>
		<script>
			var Page = (function() {
				
				var config = {
						$bookBlock : $( '#bb-bookblock' ),
						$navNext : $( '#bb-nav-next' ),
						$navPrev : $( '#bb-nav-prev' ),
						$navFirst : $( '#bb-nav-first' ),
						$navLast : $( '#bb-nav-last' )
					},
					init = function() {
						config.$bookBlock.bookblock( {
							speed : 1000,
							shadowSides : 0.8,
							shadowFlip : 0.4
						} );
						initEvents();
					},
					initEvents = function() {
						
						var $slides = config.$bookBlock.children();

						// add navigation events
						config.$navNext.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'next' );
							return false;
						} );

						config.$navPrev.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'prev' );
							return false;
						} );

						config.$navFirst.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'first' );
							return false;
						} );

						config.$navLast.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'last' );
							return false;
						} );
						
						// add swipe events
						$slides.on( {
							'swipeleft' : function( event ) {
								config.$bookBlock.bookblock( 'next' );
								return false;
							},
							'swiperight' : function( event ) {
								config.$bookBlock.bookblock( 'prev' );
								return false;
							}
						} );

						// add keyboard events
						$( document ).keydown( function(e) {
							var keyCode = e.keyCode || e.which,
								arrow = {
									left : 37,
									up : 38,
									right : 39,
									down : 40
								};

							switch (keyCode) {
								case arrow.left:
									config.$bookBlock.bookblock( 'prev' );
									break;
								case arrow.right:
									config.$bookBlock.bookblock( 'next' );
									break;
							}
						} );
					};

					return { init : init };

			})();
		</script>
		<script>
				Page.init();
		</script>
		
		
		
		
	<script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.isotope.min.js"></script>
    <script type="text/javascript" src="js/lightbox.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>  
		
		
	</body>
</html>
