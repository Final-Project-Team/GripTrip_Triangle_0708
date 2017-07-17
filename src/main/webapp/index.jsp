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
    <link href="css/bootstrap.min.css?ver=3" rel="stylesheet">
    <link href="css/font-awesome.min.css?ver=1" rel="stylesheet">
    <link href="css/animate.min.css?ver=1" rel="stylesheet"> 
    <link href="css/lightbox.css?ver=1" rel="stylesheet"> 
	<link href="css/main.css?ver=1" rel="stylesheet">
	<link href="css/responsive.css?ver=1" rel="stylesheet">

    <!--[if lt IE 9]>
	    <script src="js/html5shiv.js"></script>
	    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    
    <!-- Book 이미지 hover -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$('[data-toggle="tooltip"]').tooltip();
    		$('.book-icons-hover').hide();
    		
    		// 로그아웃 시
    		if('${logout}' == 'true'){
    			alert("로그아웃되었습니다.")
    		}
    		
    		// 회원 탈퇴 시
    		if('${remove}' == 'true'){
    			alert("회원 탈퇴가 완료됐습니다.");
    		}
    		
    		// 로그인 실패 시
    		if('${login}' == 'false'){
    			//alert("이메일과 비밀번호가 일치하지 않습니다. 다시 입력해주십시오.");
    			$('#loginModal').modal();
    			$('#loginResultView').html('<font color=red>이메일과 비밀번호가 일치하지 않습니다.</font>')
    		}
    		
    		// 회원가입 시
    		if('${nickname}' != ''){
    			alert('${nickname}님 회원가입을 축하합니다~');
    		}
    		
    		// 로그아웃 버튼 클릭 시 confirm
    		$('#logoutA').click(function(){
    			if(confirm("로그아웃 하시겠습니까?")){
    	    		 alert("로그아웃되었습니다.")
    	    		 location.href="logout.do";
    	    	 }else{
    	    		 return;
    	    	 }
    		});
    		
    		// book 이미지 mouse hover 시
    		$('.book').hover(function(){
    			$(this).find('.book-icons-hover').fadeIn('1500');
    		}, function(){
    			$(this).find('.book-icons-hover').fadeOut('1500');
    		});
    		
    		// 스토리북 추가 이미지 mouse hover 시
    		$('#add-book').hover(function(){
    			$('#add-img').find('img').addClass('add-img-big');
    		}, function(){
    			$('#add-img').find('img').removeClass('add-img-big');
    		});
    		
    		
    	});
    	
    	function deleteBook(book_no, book_picture_url, book_title) {
    	      var insertTitle = prompt("제목과 일치하면 삭제 가능합니다", "입력하세요");
    	      if (book_title == insertTitle) {

    	         $.ajax({
    	            type : "get",
    	            url : "deleteBook.do",
    	            data : "book_no=" + book_no + "&&book_picture_url="+ book_picture_url,

    	            success : function() {
    	               alert("삭제되었습니다.");
    	               window.location.reload();
    	            } //callback
    	         }); //ajax
    	      } //if
    	   } //deletebook

    	   function updateBookView(book_no) {
    	      if (confirm("정말 수정하시겠습니까?")) {
    	         /* $.ajax({
    	            type : "post",
    	            url : "updateBookView.do",
    	            data : book
    	         }); //ajax  */

    	         location.href="updateBookView.do?book_no="+book_no;
    	      }
    	   }
    	   function bookmark(no) {
    		      if(confirm("이 글을 북마크 하시겠습니까?")){
    		         $(function() {
    		               $.ajax({
    		                  type:"post",
    		                  url:"insertBookmark.do",
    		                  data:"book_no="+no+"&&storyNo=0",
    		                  dataType:"json",
    		                     
    		                  success:function(data){
    		                     $('#'+no).remove;
    		                     location.reload();
    		                  }//callback
    		               });//ajax
    		            });//function
    		         //location.href="insertBookmark.do?book_no="+no+"&&storyNo=0";
    		      }
    		   }
    		   function deleteBookmark(no) {
    		       $(function() {
    		           $.ajax({
    		              type:"post",
    		              url:"bookDeleteBookmark.do",
    		              data:"book_no="+no,
    		              dataType:"json",
    		                 
    		              success:function(data){
    		                 $('#'+no).remove;
    		                 location.reload();
    		              }//callback
    		           });//ajax
    		        });//function
    		      //location.href="bookDeleteBookmark.do?book_no="+no;
    		   }
    	   function orderBookView(book_no){
    		      if (confirm("주문하시겠습니까?")) {
    		         
    		       location.href="bookPreviewStoryBook.do?book_no="+book_no;
    		         
    		      }//if
    		}
    </script>
	<style type="text/css">
		@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
		@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
		@import url(http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css);
		@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
		@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
		
		.book {
		  display: inline-block;
		  box-shadow: 5px 5px 20px #333;
		  margin: 10px;
		  position: relative;
		  
		}
		
		.book:after{
	 		position: absolute;
		}
		
		.book-title{
			position: absolute;
			width: 100%;
			min-height: 25%;
			top: 0px;
			background-color: #949596;
			opacity: 0.5;
			font-size: 25px;
			/* font-size: 30px; 나눔손글씨*/
		}
		
		.book-title p{
			margin-top: 10px;
			margin-left: 10px;
			margin-right: 30px;
			margin-buttom: 10px;
			line-height: 120%;
			/* font-family: 'Noto Sans KR', sans-serif; */
			/* font-family: 'Jeju Myeongjo', serif; */
			font-family: 'Jeju Gothic', serif;
			/* font-family: 'Nanum Pen Script', serif; */
			/* font-family: 'Nanum Gothic', serif; */
			opacity: 1;
			color: #000000;
			z-index: 100;
		}
		
		#add-img{
			
		}
		
		#add-img img{
			width: 120px;
			height: 120px;
			opacity: 0.6;
			position: absolute;
			top: 90px;
			left: 40px;
		}
		
		.add-img-big{
			width: 200px;
			height: 200px;
		}
		
		.bookmark-img{
			position: absolute;
			top: 0px;
			right: 5px;
		}
		
		.bookmark-img img{
			position: absolute;
			top: 0px;
			right: 5px;
			width: 60px;
		}
		
		.book-icons{
			position: absolute;
		}
		
		#view-icon{
			left: 20px;
			bottom: 10px;
		}
		
		#edit-icon{
			left: 65px;
			bottom: 10px;
		}
		
		#delete-icon{
			left: 110px;
			bottom: 10px;
		}
		
		#order-icon{
			left: 155px;
			bottom: 10px;
		}
		
		.bookmark-icon{
			right: 10px;
			top: -2px;
		}
		
		.book img {
			vertical-align: middle;
			width: 200px;
			height: 300px;
			object-fit: cover;	
			/* border: 0.5px solid #5a2d18; */	
			
			/* -webkit-transition: all 0.2s ease;
    	    transition: all 0.2s ease; */
		}
		
		.book:hover img {
		  -webkit-transform: scale(1);
		  -ms-transform: scale(1);
		  transform: scale(1);
		  filter: url('data:image/svg+xml;charset=utf-8,<svg xmlns="http://www.w3.org/2000/svg"><filter id="filter"><feComponentTransfer color-interpolation-filters="sRGB"><feFuncR type="linear" slope="0.7" /><feFuncG type="linear" slope="0.7" /><feFuncB type="linear" slope="0.7" /></feComponentTransfer></filter></svg>#filter');
		  filter: brightness(0.7);
		  -webkit-filter: brightness(0.7);
		  
		  /* width: 210px;
		  height: 315px; */
		}
		
		/*
		 *  In order for this to work, you must use Modernizer
		 *  to detect 3D transform browser support. This will add
		 *  a "csstransforms3d" class to the HTML element.
		 *
		 *  Visit http://modernizr.com/ for installation instructions
		 */
		
		.csstransforms3d  .books {
		  -moz-perspective: 100px;
		  -moz-transform-style: preserve-3d;
		  -webkit-transform-style: preserve-3d;
		}
		
		.csstransforms3d  .book {
		  position: relative;
		  -moz-perspective: 100px;
		  -moz-transform: rotateY(-3deg);
		  -webkit-transform: perspective(100) rotateY(-3deg);
		  outline: 1px solid transparent; /* Helps smooth jagged edges in Firefox */
		  box-shadow: none;
		  margin: 0;
		}
		
		.csstransforms3d  .book img {
		  position: relative;
		  max-width: 100%;
		}
		
		.csstransforms3d  .book:before,
		.csstransforms3d  .book:after {
		  position: absolute;
		  top: 2%;
		  height: 96%;
		  content: ' ';
		  z-index: -1;
		}
		
		.csstransforms3d  .book:before {
		  width: 100%;
		  left: 7.5%;
		  background-color: #5a2d18;
		  box-shadow: 5px 5px 20px #333;
		}
		
		.csstransforms3d  .book:after {
		  width: 5%;
		  left: 100%;
		  background-color: #EFEFEF;
		  box-shadow: inset 0px 0px 5px #aaa;
		  -moz-transform: rotateY(20deg);
		  -webkit-transform: perspective(100) rotateY(20deg);
		}
	</style>
</head><!--/head-->

<body>
<c:choose>
	<c:when test="${sessionScope.mvo == null}">
	<!-- --------------------------------------------- [시작] 로그인 안 한 화면 --------------------------------------------- -->
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
                        <li class="dropdown"><a href="getAllList.do">다른 사람들 스토리북 구경하기</a></li>
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
    <!--/#header-->
    
	
    <section id="home-slider">
        <div class="container">
            <div class="row">
                <div class="main-slider">
                    <div class="slide-text">
                        <h1>We Are Creative Nerds</h1>
                        <p>Boudin doner frankfurter pig. Cow shank bresaola pork loin tri-tip tongue venison pork belly meatloaf short loin landjaeger biltong beef ribs shankle chicken andouille.</p>
                        <a href="#" class="btn btn-common" data-toggle="modal" data-target="#loginModal">로그인</a>
                        <a href="registerMember.jsp" class="btn btn-common">회원가입</a>
                    </div>
                    <img src="images/home/slider/hill.png" class="slider-hill" alt="slider image">
                    <img src="images/home/slider/house.png" class="slider-house" alt="slider image">
                    <img src="images/home/slider/sun.png" class="slider-sun" alt="slider image">
                    <img src="images/home/slider/birds1.png" class="slider-birds1" alt="slider image">
                    <img src="images/home/slider/birds2.png" class="slider-birds2" alt="slider image">
                </div>
            </div>
        </div>
        <div class="preloader"><i class="fa fa-sun-o fa-spin"></i></div>
    </section>
    
    <!-- Modal 로그인 모달창-->
    <form action="login.do" method="post" id="loginFrm">
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  		<div class="modal-dialog" role="document">
  			<div class="modal-content">
      			<div class="modal-header" style="background-color: #555; color: #fff;">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Login Form</h4>
      			</div>
      			<div class="modal-body">
      				<br/>
      				<div id="loginResultView" style="text-align: center;"></div>
      				<br/>
					<div class="input-group" style="width: 400px; margin: auto;">
						<span class="input-group-addon" >e-mail</span>
						<input type="text" class="form-control" name="email" id="email" aria-describedby="basic-addon3" required="required">
					</div><br/>
					<div class="input-group" style="width: 400px; margin: auto;">
						<span class="input-group-addon" id="basic-addon3">password</span>
						<input type="password" class="form-control" name="password" id="password" aria-describedby="basic-addon3" required="required">
					</div>
					<br/>
					<br/>
				</div>
      			<div class="modal-footer">
      				<div style="text-align: center; font-size: 13px;">아직 계정이 없으신가요? <a href="registerMember.jsp">지금 바로 회원가입하세요!</a></div>
      				<br/>
      				<div style="text-align: right; font-size: 12px;">아이디를 잊어버리셨나요? <a href="">아이디 찾기</a></div>
      				<div style="text-align: right; font-size: 12px;">비밀번호를 잊어버리셨나요? <a href="">비밀번호 찾기</a></div>
      				<br/>
      				<button type="submit" class="btn btn-primary">로그인</button>
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
	</form>
	
    <!--/#home-slider-->

    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 text-center padding wow fadeIn" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="single-service">
                        <div class="wow scaleIn" data-wow-duration="500ms" data-wow-delay="300ms">
                            <img src="images/home/icon1.png" alt="">
                        </div>
                        <h2>Incredibly Responsive</h2>
                        <p>Ground round tenderloin flank shank ribeye. Hamkevin meatball swine. Cow shankle beef sirloin chicken ground round.</p>
                    </div>
                </div>
                <div class="col-sm-4 text-center padding wow fadeIn" data-wow-duration="1000ms" data-wow-delay="600ms">
                    <div class="single-service">
                        <div class="wow scaleIn" data-wow-duration="500ms" data-wow-delay="600ms">
                            <img src="images/home/icon2.png" alt="">
                        </div>
                        <h2>Superior Typography</h2>
                        <p>Hamburger ribeye drumstick turkey, strip steak sausage ground round shank pastrami beef brisket pancetta venison.</p>
                    </div>
                </div>
                <div class="col-sm-4 text-center padding wow fadeIn" data-wow-duration="1000ms" data-wow-delay="900ms">
                    <div class="single-service">
                        <div class="wow scaleIn" data-wow-duration="500ms" data-wow-delay="900ms">
                            <img src="images/home/icon3.png" alt="">
                        </div>
                        <h2>Swift Page Builder</h2>
                        <p>Venison tongue, salami corned beef ball tip meatloaf bacon. Fatback pork belly bresaola tenderloin bone pork kevin shankle.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--/#services-->

    <section id="action" class="responsive">
        <div class="vertical-center">
             <div class="container">
                <div class="row">
                    <div class="action take-tour">
                        <div class="col-sm-7 wow fadeInLeft" data-wow-duration="500ms" data-wow-delay="300ms">
                            <h1 class="title">Triangle Corporate Template</h1>
                            <p>A responsive, retina-ready &amp; wide multipurpose template.</p>
                        </div>
                        <div class="col-sm-5 text-center wow fadeInRight" data-wow-duration="500ms" data-wow-delay="300ms">
                            <div class="tour-button">
                                <a href="#" class="btn btn-common">TAKE THE TOUR</a>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
   </section>
    <!--/#action-->

    <section id="features">
        <div class="container">
            <div class="row">
                <div class="single-features">
                    <div class="col-sm-5 wow fadeInLeft" data-wow-duration="500ms" data-wow-delay="300ms">
                        <img src="images/home/image1.png" class="img-responsive" alt="">
                    </div>
                    <div class="col-sm-6 wow fadeInRight" data-wow-duration="500ms" data-wow-delay="300ms">
                        <h2>Experienced and Enthusiastic</h2>
                        <P>Pork belly leberkas cow short ribs capicola pork loin. Doner fatback frankfurter jerky meatball pastrami bacon tail sausage. Turkey fatback ball tip, tri-tip tenderloin drumstick salami strip steak.</P>
                    </div>
                </div>
                <div class="single-features">
                    <div class="col-sm-6 col-sm-offset-1 align-right wow fadeInLeft" data-wow-duration="500ms" data-wow-delay="300ms">
                        <h2>Built for the Responsive Web</h2>
                        <P>Mollit eiusmod id chuck turducken laboris meatloaf pork loin tenderloin swine. Pancetta excepteur fugiat strip steak tri-tip. Swine salami eiusmod sint, ex id venison non. Fugiat ea jowl cillum meatloaf.</P>
                    </div>
                    <div class="col-sm-5 wow fadeInRight" data-wow-duration="500ms" data-wow-delay="300ms">
                        <img src="images/home/image2.png" class="img-responsive" alt="">
                    </div>
                </div>
                <div class="single-features">
                    <div class="col-sm-5 wow fadeInLeft" data-wow-duration="500ms" data-wow-delay="300ms">
                        <img src="images/home/image3.png" class="img-responsive" alt="">
                    </div>
                    <div class="col-sm-6 wow fadeInRight" data-wow-duration="500ms" data-wow-delay="300ms">
                        <h2>Experienced and Enthusiastic</h2>
                        <P>Ut officia cupidatat anim excepteur fugiat cillum ea occaecat rump pork chop tempor. Ut tenderloin veniam commodo. Shankle aliquip short ribs, chicken eiusmod exercitation shank landjaeger spare ribs corned beef.</P>
                    </div>
                </div>
            </div>
        </div>
    </section>
     <!--/#features-->

    <section id="clients">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="clients text-center wow fadeInUp" data-wow-duration="500ms" data-wow-delay="300ms">
                        <p><img src="images/home/clients.png" class="img-responsive" alt=""></p>
                        <h1 class="title">Happy Clients</h1>
                        <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br> Ut enim ad minim veniam, quis nostrud </p>
                    </div>
                    <div class="clients-logo wow fadeIn" data-wow-duration="1000ms" data-wow-delay="600ms">
                        <div class="col-xs-3 col-sm-2">
                            <a href="#"><img src="images/home/client1.png" class="img-responsive" alt=""></a>
                        </div>
                        <div class="col-xs-3 col-sm-2">
                            <a href="#"><img src="images/home/client2.png" class="img-responsive" alt=""></a>
                        </div>
                         <div class="col-xs-3 col-sm-2">
                            <a href="#"><img src="images/home/client3.png" class="img-responsive" alt=""></a>
                        </div>
                         <div class="col-xs-3 col-sm-2">
                            <a href="#"><img src="images/home/client4.png" class="img-responsive" alt=""></a>
                        </div>
                         <div class="col-xs-3 col-sm-2">
                            <a href="#"><img src="images/home/client5.png" class="img-responsive" alt=""></a>
                        </div>
                         <div class="col-xs-3 col-sm-2">
                            <a href="#"><img src="images/home/client6.png" class="img-responsive" alt=""></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </section>
    <!--/#clients-->
    
    <!-- --------------------------------------------- [끝] 로그인 안 한 화면 끝 --------------------------------------------- -->
	</c:when>
	<c:otherwise>
	<!-- --------------------------------------------- [시작] 로그인 하고 난 화면 --------------------------------------------- -->
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
	    <!--/#header-->
	    <!-- --------------------------------------------- [시작] 제목 Section --------------------------------------------- -->
		<section id="page-breadcrumb">
	    	<div class="vertical-center sun">
	        	<div class="container">
	            	<div class="row">
	               		<div class="action">
	                     	<div class="col-sm-12">
	                            <h1 class="title">내 스토리북</h1>
	                            <p>회원님의 스토리북 목록입니다.</p>
	                        </div>
	                     </div>
	                </div>
	            </div>
	        </div>
	   </section>
	   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
		<c:choose>
	    	<c:when test="${fn:length(list)!=0}">
	    	<br/>
	    	<br/>
	    	<br/>
	    	<div class="container">
	    		<c:forEach  items="${list}" var="book" varStatus="i">
	    			
					<span class="books">	   					
						<div class="book">
							<img class="bookimg" src="upload/${book.book_picture_url}"/>
							
							<!-- <div class="bookmark-img">
								<img src="images/bookmark.png">
							</div> -->
							<div class="book-title">
								<p>${book.book_title}</p>
							</div>
							<a href="showStoryList.do?book_no=${book.book_no}&&email=${sessionScope.mvo.email}"><font color="#eff0f2" size="6px" id="view-icon" class="book-icons book-icons-hover" data-toggle="tooltip" title="스토리 보기" ><i class="fa fa-eye" aria-hidden="true"></i></font></a>
							<a onclick="updateBookView('${book.book_no}')"><font color="#eff0f2" size="6px" id="edit-icon" class="book-icons book-icons-hover" data-toggle="tooltip" title="스토리북 수정"><i class="fa fa-pencil" aria-hidden="true"></i></font></a>
							<a onclick="deleteBook('${book.book_no }', '${book.book_picture_url }', '${book.book_title }')"><font color="#eff0f2" size="6px" id="delete-icon" class="book-icons book-icons-hover" data-toggle="tooltip" title="스토리북 삭제"><i class="fa fa-trash-o" aria-hidden="true"></i></font></a>
							<a onclick="orderBookView('${book.book_no}')"><font color="#eff0f2" size="6px" id="order-icon" class="book-icons book-icons-hover" data-toggle="tooltip" title="스토리북 주문"><i class="fa fa-shopping-cart" aria-hidden="true"></i></font></a>
							<!-- #ba3535 #a01414 #b2002c #211ca8 #5a2d18--><!-- <i class="fa fa-bookmark" aria-hidden="true"></i> -->
							<c:if test="${sessionScope.mvo.email!=null}">
		    	            	<c:choose>
		        	            	<c:when test="${book.bookmark=='false'}">
		        	            		<a onclick="bookmark(${book.book_no})"><font color="#eff0f2" size="6px" class="book-icons bookmark-icon" data-toggle="tooltip" title="북마크 등록"><i class="fa fa-bookmark-o" aria-hidden="true"></i></font></a>
		        	            	</c:when>
		        	            	<c:otherwise>
		        	            		<a onclick="deleteBookmark(${book.book_no})"><font color="a01414" size="6px" class="book-icons bookmark-icon" data-toggle="tooltip" title="북마크 해제"><i class="fa fa-bookmark" aria-hidden="true"></i></font></a>
		        	            	</c:otherwise>
		        	            </c:choose>
		        	    	</c:if>
						</div>		
					</span>					 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${fn:length(list) >= 4}">
						<c:if test="${(i.index+1)%4 == 0}">
							<br/>
							<br/>
							<br/>
						</c:if>
					</c:if>
	    		</c:forEach>
	    		<span class="books">
	    			<a href="book_Insert.jsp">
		    			<div class="book" id="add-book">
							<img class="bookimg" src="images/white-bg.jpg"/>
							<div id="add-img">
								<img src="images/add.png"  data-toggle="tooltip" title="북스토리 추가">
							</div>
						</div>
					</a>
				</span>
	    	</div>
	    		<br/>
	    		<br/>
	    		<br/>
	    		<br/>
	    		<br/>
	    		<br/>
	    		<br/>
	    		<br/>
				<%-- <table align="center">
	            	<thead>
	               		<tr>
	                 		<th>이미지</th><th>BOOK_NO</th><th>BOOK_TITLE</th><th>BOOK_CREATE_DATE</th><th>BOOK_PICTURE_URL</th><th>BOOK_IS_PUBLIC</th><th>BOOK_HIT</th><th>NICK_NAME</th>
	               		</tr>
	            	</thead>
	            	<tbody>
		               	<c:forEach items="${list}" var="book">
		                  	<tr>
		                  		<!-- Book Image 부분 -->
			                  	 <td>
			                  	 	<div class="books">
									  <div class="book" >
									    <img class="bookimg" src="img/${book.book_picture_url}"/>
									  </div>
									</div>
			                  	 </td>
		                    	<td>${book.book_no}</td>
		   	            	    <td>${book.book_title}</td>
		    	                <td>${book.book_create_date}</td>
		        	            <td><a href="showStoryList.do?book_no=${book.book_no}&&email=${sessionScope.mvo.email}">${book.book_picture_url}</a></td>
		            	        <td>${book.book_is_public}</td>
		            	        <td>${book.book_hit}</td>
								<td>${book.nick }</td>
								<td>
									<c:if test="${sessionScope.mvo.email!=null}">
		    	                 		<c:choose>
		        	             			<c:when test="${book.bookmark=='false'}">
		            	         				<td><input type="button" value="북마크" onclick="bookmark(${book.book_no})"></td>
		                	     			</c:when>
		                    	 			<c:otherwise>
		                     					<td><input type="button" value="해제" onclick="deleteBookmark(${book.book_no})"></td>
		                     				</c:otherwise>
		         	            		</c:choose>         					
		          					</c:if> 
		                	   	</td>
		                  	</tr>
		                 	<tr>
				            	<td><input type="button" value="수정" id="updateBtn" onclick="updateBookView('${book.book_no}')"></td>
				               	<td><input type="button" value="삭제" id="deleteBtn" onclick="deleteBook('${book.book_no }', '${book.book_picture_url }', '${book.book_title }')"></td>
		                  	   	<td><input type="button" value="주문하기" id="orderBtn" onclick="orderBookView('${book.book_no}')"></td>
		                  	</tr>
		                  	<tr>
		                     	<td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td>
		                  	</tr>
		               	</c:forEach>
	            	</tbody>
				</table> 
				<a href="book_Insert.jsp" style="font-size: 30px;">Story Book 추가하기</a> --%>
			</c:when>
			<c:otherwise>
            <br/>
            <br/>
            <br/>
            <br/>
            <div class="container">
               <div align="center">
                  <table>
                     <tr>
                        <td><h2><b>당신의 첫 스토리북을 만들어 보세요.</b></h2></td>
                     </tr>   
                  </table>
               </div>
               <br/>
               <br/>
               <br/>
               
               <div align="center" >
                  <a href="book_Insert.jsp" class="btn btn-submit" style="width: 290px;">스토리 북 쓰기</a>
               </div>
               <br/>
               <br/>
               <br/>
               <br/>
            </div>
            
             
			</c:otherwise>
		</c:choose>
    <!-- --------------------------------------------- [끝] 로그인 하고 난 화면 끝 --------------------------------------------- -->
	</c:otherwise>
</c:choose>

	<!-- --------------------------------------------- [시작] Footer --------------------------------------------- -->
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
                <div class="col-sm-12">
                    <div class="copyright-text text-center">
                        <p>&copy; Your Company 2014. All Rights Reserved.</p>
                        <p>Designed by <a target="_blank" href="http://www.themeum.com">Themeum</a></p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!--/#footer-->
    <!-- --------------------------------------------- [끝] Footer --------------------------------------------- -->

    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/lightbox.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>   
    <!-- Book Image를 위한 부분 -->
    <script>
	/* Modernizr 2.5.3 (Custom Build) | MIT & BSD
	 * Build: http://www.modernizr.com/download/#-csstransforms3d-shiv-cssclasses-teststyles-testprop-testallprops-prefixes-domprefixes-load
	 */
	;window.Modernizr=function(a,b,c){function z(a){j.cssText=a}function A(a,b){return z(m.join(a+";")+(b||""))}function B(a,b){return typeof a===b}function C(a,b){return!!~(""+a).indexOf(b)}function D(a,b){for(var d in a)if(j[a[d]]!==c)return b=="pfx"?a[d]:!0;return!1}function E(a,b,d){for(var e in a){var f=b[a[e]];if(f!==c)return d===!1?a[e]:B(f,"function")?f.bind(d||b):f}return!1}function F(a,b,c){var d=a.charAt(0).toUpperCase()+a.substr(1),e=(a+" "+o.join(d+" ")+d).split(" ");return B(b,"string")||B(b,"undefined")?D(e,b):(e=(a+" "+p.join(d+" ")+d).split(" "),E(e,b,c))}var d="2.5.3",e={},f=!0,g=b.documentElement,h="modernizr",i=b.createElement(h),j=i.style,k,l={}.toString,m=" -webkit- -moz- -o- -ms- ".split(" "),n="Webkit Moz O ms",o=n.split(" "),p=n.toLowerCase().split(" "),q={},r={},s={},t=[],u=t.slice,v,w=function(a,c,d,e){var f,i,j,k=b.createElement("div"),l=b.body,m=l?l:b.createElement("body");if(parseInt(d,10))while(d--)j=b.createElement("div"),j.id=e?e[d]:h+(d+1),k.appendChild(j);return f=["&#173;","<style>",a,"</style>"].join(""),k.id=h,(l?k:m).innerHTML+=f,m.appendChild(k),l||(m.style.background="",g.appendChild(m)),i=c(k,a),l?k.parentNode.removeChild(k):m.parentNode.removeChild(m),!!i},x={}.hasOwnProperty,y;!B(x,"undefined")&&!B(x.call,"undefined")?y=function(a,b){return x.call(a,b)}:y=function(a,b){return b in a&&B(a.constructor.prototype[b],"undefined")},Function.prototype.bind||(Function.prototype.bind=function(b){var c=this;if(typeof c!="function")throw new TypeError;var d=u.call(arguments,1),e=function(){if(this instanceof e){var a=function(){};a.prototype=c.prototype;var f=new a,g=c.apply(f,d.concat(u.call(arguments)));return Object(g)===g?g:f}return c.apply(b,d.concat(u.call(arguments)))};return e});var G=function(a,c){var d=a.join(""),f=c.length;w(d,function(a,c){var d=b.styleSheets[b.styleSheets.length-1],g=d?d.cssRules&&d.cssRules[0]?d.cssRules[0].cssText:d.cssText||"":"",h=a.childNodes,i={};while(f--)i[h[f].id]=h[f];e.csstransforms3d=(i.csstransforms3d&&i.csstransforms3d.offsetLeft)===9&&i.csstransforms3d.offsetHeight===3},f,c)}([,["@media (",m.join("transform-3d),("),h,")","{#csstransforms3d{left:9px;position:absolute;height:3px;}}"].join("")],[,"csstransforms3d"]);q.csstransforms3d=function(){var a=!!F("perspective");return a&&"webkitPerspective"in g.style&&(a=e.csstransforms3d),a};for(var H in q)y(q,H)&&(v=H.toLowerCase(),e[v]=q[H](),t.push((e[v]?"":"no-")+v));return z(""),i=k=null,function(a,b){function g(a,b){var c=a.createElement("p"),d=a.getElementsByTagName("head")[0]||a.documentElement;return c.innerHTML="x<style>"+b+"</style>",d.insertBefore(c.lastChild,d.firstChild)}function h(){var a=k.elements;return typeof a=="string"?a.split(" "):a}function i(a){var b={},c=a.createElement,e=a.createDocumentFragment,f=e();a.createElement=function(a){var e=(b[a]||(b[a]=c(a))).cloneNode();return k.shivMethods&&e.canHaveChildren&&!d.test(a)?f.appendChild(e):e},a.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+h().join().replace(/\w+/g,function(a){return b[a]=c(a),f.createElement(a),'c("'+a+'")'})+");return n}")(k,f)}function j(a){var b;return a.documentShived?a:(k.shivCSS&&!e&&(b=!!g(a,"article,aside,details,figcaption,figure,footer,header,hgroup,nav,section{display:block}audio{display:none}canvas,video{display:inline-block;*display:inline;*zoom:1}[hidden]{display:none}audio[controls]{display:inline-block;*display:inline;*zoom:1}mark{background:#FF0;color:#000}")),f||(b=!i(a)),b&&(a.documentShived=b),a)}var c=a.html5||{},d=/^<|^(?:button|form|map|select|textarea)$/i,e,f;(function(){var a=b.createElement("a");a.innerHTML="<xyz></xyz>",e="hidden"in a,f=a.childNodes.length==1||function(){try{b.createElement("a")}catch(a){return!0}var c=b.createDocumentFragment();return typeof c.cloneNode=="undefined"||typeof c.createDocumentFragment=="undefined"||typeof c.createElement=="undefined"}()})();var k={elements:c.elements||"abbr article aside audio bdi canvas data datalist details figcaption figure footer header hgroup mark meter nav output progress section summary time video",shivCSS:c.shivCSS!==!1,shivMethods:c.shivMethods!==!1,type:"default",shivDocument:j};a.html5=k,j(b)}(this,b),e._version=d,e._prefixes=m,e._domPrefixes=p,e._cssomPrefixes=o,e.testProp=function(a){return D([a])},e.testAllProps=F,e.testStyles=w,g.className=g.className.replace(/(^|\s)no-js(\s|$)/,"$1$2")+(f?" js "+t.join(" "):""),e}(this,this.document),function(a,b,c){function d(a){return o.call(a)=="[object Function]"}function e(a){return typeof a=="string"}function f(){}function g(a){return!a||a=="loaded"||a=="complete"||a=="uninitialized"}function h(){var a=p.shift();q=1,a?a.t?m(function(){(a.t=="c"?B.injectCss:B.injectJs)(a.s,0,a.a,a.x,a.e,1)},0):(a(),h()):q=0}function i(a,c,d,e,f,i,j){function k(b){if(!o&&g(l.readyState)&&(u.r=o=1,!q&&h(),l.onload=l.onreadystatechange=null,b)){a!="img"&&m(function(){t.removeChild(l)},50);for(var d in y[c])y[c].hasOwnProperty(d)&&y[c][d].onload()}}var j=j||B.errorTimeout,l={},o=0,r=0,u={t:d,s:c,e:f,a:i,x:j};y[c]===1&&(r=1,y[c]=[],l=b.createElement(a)),a=="object"?l.data=c:(l.src=c,l.type=a),l.width=l.height="0",l.onerror=l.onload=l.onreadystatechange=function(){k.call(this,r)},p.splice(e,0,u),a!="img"&&(r||y[c]===2?(t.insertBefore(l,s?null:n),m(k,j)):y[c].push(l))}function j(a,b,c,d,f){return q=0,b=b||"j",e(a)?i(b=="c"?v:u,a,b,this.i++,c,d,f):(p.splice(this.i++,0,a),p.length==1&&h()),this}function k(){var a=B;return a.loader={load:j,i:0},a}var l=b.documentElement,m=a.setTimeout,n=b.getElementsByTagName("script")[0],o={}.toString,p=[],q=0,r="MozAppearance"in l.style,s=r&&!!b.createRange().compareNode,t=s?l:n.parentNode,l=a.opera&&o.call(a.opera)=="[object Opera]",l=!!b.attachEvent&&!l,u=r?"object":l?"script":"img",v=l?"script":u,w=Array.isArray||function(a){return o.call(a)=="[object Array]"},x=[],y={},z={timeout:function(a,b){return b.length&&(a.timeout=b[0]),a}},A,B;B=function(a){function b(a){var a=a.split("!"),b=x.length,c=a.pop(),d=a.length,c={url:c,origUrl:c,prefixes:a},e,f,g;for(f=0;f<d;f++)g=a[f].split("="),(e=z[g.shift()])&&(c=e(c,g));for(f=0;f<b;f++)c=x[f](c);return c}function g(a,e,f,g,i){var j=b(a),l=j.autoCallback;j.url.split(".").pop().split("?").shift(),j.bypass||(e&&(e=d(e)?e:e[a]||e[g]||e[a.split("/").pop().split("?")[0]]||h),j.instead?j.instead(a,e,f,g,i):(y[j.url]?j.noexec=!0:y[j.url]=1,f.load(j.url,j.forceCSS||!j.forceJS&&"css"==j.url.split(".").pop().split("?").shift()?"c":c,j.noexec,j.attrs,j.timeout),(d(e)||d(l))&&f.load(function(){k(),e&&e(j.origUrl,i,g),l&&l(j.origUrl,i,g),y[j.url]=2})))}function i(a,b){function c(a,c){if(a){if(e(a))c||(j=function(){var a=[].slice.call(arguments);k.apply(this,a),l()}),g(a,j,b,0,h);else if(Object(a)===a)for(n in m=function(){var b=0,c;for(c in a)a.hasOwnProperty(c)&&b++;return b}(),a)a.hasOwnProperty(n)&&(!c&&!--m&&(d(j)?j=function(){var a=[].slice.call(arguments);k.apply(this,a),l()}:j[n]=function(a){return function(){var b=[].slice.call(arguments);a&&a.apply(this,b),l()}}(k[n])),g(a[n],j,b,n,h))}else!c&&l()}var h=!!a.test,i=a.load||a.both,j=a.callback||f,k=j,l=a.complete||f,m,n;c(h?a.yep:a.nope,!!i),i&&c(i)}var j,l,m=this.yepnope.loader;if(e(a))g(a,0,m,0);else if(w(a))for(j=0;j<a.length;j++)l=a[j],e(l)?g(l,0,m,0):w(l)?B(l):Object(l)===l&&i(l,m);else Object(a)===a&&i(a,m)},B.addPrefix=function(a,b){z[a]=b},B.addFilter=function(a){x.push(a)},B.errorTimeout=1e4,b.readyState==null&&b.addEventListener&&(b.readyState="loading",b.addEventListener("DOMContentLoaded",A=function(){b.removeEventListener("DOMContentLoaded",A,0),b.readyState="complete"},0)),a.yepnope=k(),a.yepnope.executeStack=h,a.yepnope.injectJs=function(a,c,d,e,i,j){var k=b.createElement("script"),l,o,e=e||B.errorTimeout;k.src=a;for(o in d)k.setAttribute(o,d[o]);c=j?h:c||f,k.onreadystatechange=k.onload=function(){!l&&g(k.readyState)&&(l=1,c(),k.onload=k.onreadystatechange=null)},m(function(){l||(l=1,c(1))},e),i?k.onload():n.parentNode.insertBefore(k,n)},a.yepnope.injectCss=function(a,c,d,e,g,i){var e=b.createElement("link"),j,c=i?h:c||f;e.href=a,e.rel="stylesheet",e.type="text/css";for(j in d)e.setAttribute(j,d[j]);g||(n.parentNode.insertBefore(e,n),m(c,0))}}(this,document),Modernizr.load=function(){yepnope.apply(window,[].slice.call(arguments,0))};
	</script>
</body>
</html>
