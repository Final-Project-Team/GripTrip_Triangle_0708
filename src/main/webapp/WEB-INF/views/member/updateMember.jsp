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
	    <link href="css/bootstrap.min.css" rel="stylesheet">
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
			// 로그아웃 버튼 클릭 시 confirm
    		$('#logoutA').click(function(){
    			if(confirm("로그아웃 하시겠습니까?")){
    	    		 alert("로그아웃되었습니다.")
    	    		 location.href="logout.do";
    	    	 }else{
    	    		 return;
    	    	 }
    		});
			
			var foundNick = true;
			var repassMatch = false;
			
			
			// 닉네임 중복 확인
			$('input[id=nickname]').keyup(function(){
				var userinput = $(this).val();
				
				if($('#nickname').val() != '${mvo.nickname}'){ // 원래 닉네임과 다른 닉네임 입력한 경우만
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
				}else{
					$('span#nickCheckResult').html('<font color=blue>사용 가능한 닉넴 데쓰</font>');
				}
				
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
			$('#updateFrm').submit(function(){
				if(foundNick == true){
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
                            <h1 class="title">My Profile 수정</h1>
                            <p>회원님의 개인 정보를 수정하십시오.</p>
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
					<form id="updateFrm" name="contact-form" method="post" action="updateMember.do">
						<div class="form-group">
							<input type="text" name="email" id="email" class="form-control" placeholder="${mvo.email}"  value="${mvo.email}" readonly="readonly">
							<span id="emailCheckResult"></span>
						</div>
						<div class="form-group">
							<input type="password" name="password" id="password" class="form-control" value="${mvo.password}" placeholder="${mvo.password}">
						</div>
						<div class="form-group">
							<input type="password" name="repassword" id="repassword" class="form-control" placeholder="${mvo.password}">
							<span id="repassCheckResult"></span>
						</div>
						<div class="form-group">
							<input type="text" name="nickname" id="nickname" class="form-control" value="${mvo.nickname}" placeholder="${mvo.nickname}">
							<span id="nickCheckResult"></span>
						</div>
						<div class="form-group">
							<input type="text" name="username" id="username" class="form-control" value="${mvo.username}" placeholder="${mvo.username}">
						</div>
						<div class="form-group">
							<input type="text" name="address" id="address" class="form-control" value="${mvo.address}" placeholder="${mvo.address}">
						</div>
						<div class="form-group">
							<input type="submit" name="submit" class="btn btn-submit" value="수정하기">
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

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
	<meta charset="UTF-8">
	<style>
	
	</style>
	<script type="text/javascript">	
		$(function(){
			//alert($('#email').val() + $('#password').val() + $('#address').val() + $('#nickname').val());
			// 닉네임 중복 확인
			$('input[id=nickname]').keyup(function(){
				var userinput = $(this).val();
				//alert($('#email').val() + $('#password').val() + $('#address').val() + $('#nickname').val());
				
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
				// alert($('#email').val() + $('#password').val() + $('#address').val() + $('#nickname').val());
				
				if(repassword != password){ // 비번 재확인이 비번과 다름
					$('span#repassCheckResult').html('<font color=red>비번 일치 안함</font>');
				}else{ // 비번 재확인과 비번 일치
					$('span#repassCheckResult').html('<font color=blue>비번 일치 ㅇㅋ!</font>');
					repassMatch = true;
				}
			}); // keyup()
		});
	</script>
	<title>Insert title here</title>
</head>
<body>
	<h2 align="center">회원정보 수정 페이지</h2><p>
	<form action="updateMember.do" method="post" id="regFrm">
	 	EMAIL : <input type="text" name="email" id="email" value="${mvo.email}" placeholder="${mvo.email}" value="${mvo.email}" readonly="readonly">
	 	<span id="emailCheckResult"></span>
	 	<p>
	 	PASSWORd : <input type="password" name="password" value="${mvo.password}" id="password" placeholder="${mvo.password}">
	 	<p>	
	 	CHECK PASSWORD : <input type="password" name="repassword" id="repassword" placeholder="${mvo.password}">
	 	<span id="repassCheckResult"></span>
	 	<p>
	 	NICKNAME : <input type="text" name="nickname" value="${mvo.nickname}" id="nickname" placeholder="${mvo.nickname}">
	 	<span id="nickCheckResult"></span>
	 	<p>
	 	USERNAME : <input type="text" name="username" value="${mvo.username}" id="username" placeholder="${mvo.username}">	 	
	 	<p>
	 	ADDRESS : <input type="text" name="address" value="${mvo.address}" id="address" placeholder="${mvo.address}">
	 	<p>
	 	<input type="submit" value="UPDATE">
	</form>
</body>
</html> --%>