<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">
	    <title>About Us | Triangle</title>
	    <link href="css/bootstrap.min.css?ver=1" rel="stylesheet">
	    <link href="css/font-awesome.min.css" rel="stylesheet">
	    <link href="css/lightbox.css" rel="stylesheet"> 
	    <link href="css/animate.min.css" rel="stylesheet"> 
		<link href="css/main.css" rel="stylesheet">
		<link href="css/responsive.css" rel="stylesheet">
	
	    <!--[if lt IE 9]>
		    <script src="js/html5shiv.js"></script>
		    <script src="js/respond.min.js"></script>
	    <![endif]-->       
	    <link rel="shortcut icon" href="images/ico/favicon.ico">
	    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
	    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
	    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
	    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
	</head><!--/head-->
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
	<script type="text/javascript">	
		$(function(){
			var foundEmail = true;
			var foundNick = true;
			var repassMatch = false;
			
			$('input[id=email]').keyup(function(){
				// 이메일 중복 확인
				var userinput = $(this).val();
				
				$.ajax({
					url: "isEmailExist.do",
					data: "email="+userinput,
					type: "post",
					
					success: function(result){
						foundEmail = result.found;
						
						if(foundEmail == false){	// 이멜 사용 가능
							var str = $('#email').val();
							
							var at = "@";
							var dot = ".";
							var lat = str.indexOf(at);
							var lstr = str.length;
							var ldot = str.indexOf(dot);
							
							if (str.indexOf(at) == -1) {	// 여기부터 이멜 형식 확인
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else if (str.indexOf(at) == -1 || str.indexOf(at) == 0	|| str.indexOf(at) == lstr) {
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0
									|| str.indexOf(dot) == lstr) {
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else if (str.indexOf(at, (lat + 1)) != -1) {
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else if (str.indexOf(dot, (lat + 2)) == -1) {
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else if (str.indexOf(" ") != -1) {
								$('span#emailCheckResult').html('<font color=red>이멜 형식을 지켜주시지</font>');
								foundEmail = true;
								return false;
							}else{
								$('span#emailCheckResult').html('<font color=blue>사용 가능한 이메일 데쓰</font>');	
								foundEmail = false;
							}
							
						}else{	// 이멜 사용 불가
							$('span#emailCheckResult').html('<font color=red>사용 못하는 이메일 데쓰</font>');
							foundEmail = true;
							return;
						}
					} // success
				}); // ajax()
			}); // keyup()
			
			// 닉네임 중복 확인
			$('input[id=nickname]').keyup(function(){
				var userinput = $(this).val();
				
				$.ajax({
					url: "isNicknameExist.do",
					data: "nickname="+userinput,
					type: "post",
					
					success: function(result){
						foundNick = result.found;
						//alert(result.found);
						
						if(foundNick == false){	// 이멜 사용 가능
							$('span#nickCheckResult').html('<font color=blue>사용 가능한 닉넴 데쓰</font>');
							
						}else{	// 이멜 사용 불가
							$('span#nickCheckResult').html('<font color=red>사용 못하는 닉넴 데쓰</font>');
							return;
						}
					} // success
				}); // ajax()
			}); // keyup()
			
			// 패스워드 재확인
			$('#repassword').keyup(function(){
				var password = $('#password').val();
				var repassword = $('#repassword').val();
				
				if(repassword != password || repassword == ''){ // 비번 재확인이 비번과 다름
					$('span#repassCheckResult').html('<font color=red>비번 일치 안함</font>');
				}else{ // 비번 재확인과 비번 일치
					$('span#repassCheckResult').html('<font color=blue>비번 일치 ㅇㅋ!</font>');
					repassMatch = true;
				}
			}); // keyup()
			
			// 회원 등록 하려할 때(submit 눌렀을 때)
			$('#regFrm').submit(function(){
				
					
				if(foundEmail == true){
					alert('이멜 중복 확인 다시 하삼');
					$('#email').val("");
					$('#eamil').focus();
					return false;
				}else if(foundNick == true){
					alert('닉넴 중복 확인 다시 하삼');
					$('#nickname').val("");
					$('#nickname').focus();
					return false;
				}else if(repassMatch == false){
					alert('비번 재확인 다시 하삼');
					$('#repassword').val("");
					$('#repassword').focus();
					return false;
				}else{
					return true;
				}
			});
			
		}); // function()
	</script>
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
                            <h1 class="title">Sign up</h1>
                            <p>GripTrip에 오신 것을 환영합니당 빨리 회원가입 하세요^_____^</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
    <!--/#page-breadcrumb-->
    <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->

    <section id="about-company" class="padding-top wow fadeInUp" data-wow-duration="400ms" data-wow-delay="400ms">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 text-center">
                    <img src="images/aboutus/5.png" class="margin-bottom" alt="">
                    <h1 class="margin-bottom">About Our Company</h1>
                    <p>Pork chop duis eu pig, labore sausage venison. Shankle fugiat duis, filet mignon tri-tip venison beef shank ribeye<br /> aliqua cillum dolore sed do in.</p>
                </div>
            </div>
        </div>
    </section>
    <!--/#about-company-->

	<div class="container">
		<div class="row">
			<div class="col-md-4 col-sm-12"></div>
			<div class="col-md-4 col-sm-12">
				<div class="contact-form bottom">
					<h2>Send a message</h2>
					<form id="regFrm" name="contact-form" method="post" action="registerMember.do">
						<div class="form-group">
							<input type="text" name="email" id="email" class="form-control" required="required" placeholder="이메일">
							<span id="emailCheckResult"></span>
						</div>
						<div class="form-group">
							<input type="password" name="password" id="password" class="form-control" required="required" placeholder="비밀번호">
						</div>
						<div class="form-group">
							<input type="password" name="repassword" id="repassword" class="form-control" required="required" placeholder="비밀번호 재확인">
							<span id="repassCheckResult"></span>
						</div>
						<div class="form-group">
							<input type="text" name="nickname" id="nickname" class="form-control" required="required" placeholder="닉네임">
							<span id="nickCheckResult"></span>
						</div>
						<div class="form-group">
							<input type="text" name="username" id="username" class="form-control" required="required" placeholder="이름">
						</div>
						<div class="form-group">
							<input type="text" name="address" id="address" class="form-control" required="required" placeholder="주소">
						</div>
						<div class="form-group">
							<input type="submit" name="submit" class="btn btn-submit" value="회원가입">
						</div>
					</form>
				</div>
			</div>
			<div class="col-md-4 col-sm-12"></div>
		</div>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>

	
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
    <script type="text/javascript" src="js/jquery.countTo.js"></script>
    <script type="text/javascript" src="js/main.js"></script>   
   
</body>
</html>
