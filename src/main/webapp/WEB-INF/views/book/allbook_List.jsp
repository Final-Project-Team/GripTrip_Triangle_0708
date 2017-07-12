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
		});
	
		function deleteBookmark(no) {
			location.href="bookDeleteBookmark.do?book_no="+no;
		}
		function bookmark(no) {
			if(confirm("이 글을 북마크 하시겠습니까?")){
				location.href="insertBookmark.do?book_no="+no+"&&storyNo=0";
			}
		}
		function loginCheck() {
			if(confirm("로그인 하신 후 이용 가능합니다."))	
				location.href="index.jsp";
		}
</script>
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
                            <h1 class="title">다른 사람들의 스토리북 구경하기</h1>
                            <p>여러 사람들의 스토리북과 스토리를 구경하실 수 있습니다.</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
   	<br/>
	<br/>
	<br/>
	<br/>
   <c:choose>
      <c:when test="${fn:length(list)!=0}">
         <table>
            <thead>
               <tr>
                  <th>BOOK_NO</th><th>BOOK_TITLE</th><th>BOOK_CREATE_DATE</th><th>BOOK_PICTURE_URL</th><th>BOOK_IS_PUBLIC</th><th>BOOK_HIT</th><th>NICK_NAME</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${list}" var="book">
                  <tr>
                     <td>${book.book_no}</td>
                     <td>${book.book_title}</td>
                     <td>${book.book_create_date}</td>
                     <td>
                     <c:choose>
                     	<c:when test="${sessionScope.mvo.email!=null}">
                     		<a href="showStoryList.do?book_no=${book.book_no}&&email=${sessionScope.mvo.email}">${book.book_picture_url}</a>
                     	</c:when>
                     	<c:otherwise>
                     		<a href="javascript:loginCheck()">${book.book_picture_url}</a>
                     	</c:otherwise>
                     </c:choose>                 
                     </td>
                     <td>${book.book_is_public}</td>
                     <td>${book.book_hit}</td>
                     <td>${book.nick }</td>
                     <%-- <c:if test="${book.bookmark=='false' || sessionScope.mvo.email!=null}"> --%>
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
                  </tr>
                  <tr>
                  </tr>
                  <tr>
                     <td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
      </c:when>
      <c:otherwise>
         <h2>공개된 글이 없습니다.</h2>
         <!-- <a href="book_Insert.jsp" >Story Book 추가하기</a> -->
      </c:otherwise>
   </c:choose>
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