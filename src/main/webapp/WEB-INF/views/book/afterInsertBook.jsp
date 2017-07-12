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
         
         /* $('#storyBtn').click(function(){
            $(location).attr('href', 'storyWrite.do?book_no=${book.book_no}');
         }); */
         
         $('#bookBtn').click(function(){
            $(location).attr('href', 'getMyBookList.do');
         });
      });
   </script>
   <title>Insert title here</title>
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
                            <h1 class="title">스토리북 등록</h1>
                            <p>회원님의 스토리북이 등록되었습니다.</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
   
   <c:choose>
      <c:when test="${storyExists == false}">
         <h2 align="center">${book.book_title} 북에 아직 스토리가 없습니다.</h2><p>
         <h3 align="center">첫 스토리를 작성해보시겠습니까?</h3><p>
      </c:when>
      <c:otherwise>
         <h2 align="center">${book.book_title} 북이 이쁘게 등록되었습니당.</h2><p>
         <h3 align="center">이어서 첫 스토리를 쓰실래용?</h3><p>
      </c:otherwise>
   </c:choose>
   
   <br/>
   <input type="button" value="첫 스토리 쓰기" id="storyBtn" data-toggle="modal" data-target="#storyModal">&nbsp;
   <input type="button" value="내 스토리북 목록으로 돌아가기" id="bookBtn">
   <br/>
   <br/>
   <br/>
   <br/>




<!-- -------------------- Stroy Write Modal ------------------------------- -->
<div class="modal fade" id="storyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content modal-lg">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Story 작성</h4>
      </div>
      <div class="modal-body">
         <jsp:include page="../story/storyWrite.jsp"></jsp:include>
      </div>
      <!-- <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
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

    <!-- <script type="text/javascript" src="js/jquery.js"></script> -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/lightbox.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/jquery.countTo.js"></script>
    <script type="text/javascript" src="js/main.js"></script>   
</body>
</html>