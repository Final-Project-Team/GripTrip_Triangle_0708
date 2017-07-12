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
	<link href="css/card.css" rel="stylesheet">
	<link href="css/font-awesome.min.css" rel="stylesheet">

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
			
	         $('input[name=hotKeyword]').bind("click", function() {
	            $('input[name=search]').val($('input[name=search]').val()+$(this).val());
	         });//on            
	         
	       //검색 엔터 추가..
	         $("#search").keypress(function(enter) {
	               if(enter.which==13){
	                  search(); // 실행할 이벤트..
	               }
	         });//keypress
   });//function
   
   function selectButton(kind) {
      //alert("${keyword}");
      var keyword = '${keyword}';
      //alert(keyword);
      keyword = escape(encodeURIComponent(keyword));
      //alert(escape(encodeURIComponent(${keyword})));
      location.href="searchAgain.do?keyword="+keyword+"&&select=${select}"+"&&from="+kind;
   }
   
   function deleteBookmark(kind, bno, sno) {
          $(function() {
               $.ajax({
                  type:"post",
                  url:"storyDeleteBookmark.do",
                  data:"book_no="+bno+"&&storyNo="+sno,
                  dataType:"json",
                     
                  success:function(data){
                     $('#'+sno).remove;
                     location.reload();
                  }//callback
               });//ajax
            });//function
      //location.href="storyDeleteBookmark.do?book_no="+bno+"&&storyNo="+sno+"&&from=story";
   }
   
   function bookmark(kind, bno, sno) {
      if(confirm("이 글을 북마크 하시겠습니까?")){
          $(function() {
                $.ajax({
                   type:"post",
                   url:"insertBookmark.do",
                   data:"book_no="+bno+"&&storyNo="+sno,
                   dataType:"json",
                      
                   success:function(data){
                      $('#'+sno).remove;
                      location.reload();
                   }//callback
                });//ajax
             });//function
         //location.href="insertBookmark.do?book_no="+bno+"&&storyNo="+sno+"&&from=story";
      }
   }
   function loginCheck() {
      if(confirm("로그인을 해주세요.\n로그인 창으로 이동합니다."))   
         location.href="Login.jsp";
   }
   var category="";
   var index="";
   var value="all";
   function category_selected() {
      category = document.getElementById('category');
      index = category.selectedIndex;
      value = category.options[index].value;
      //alert(index+", "+value);
   }
   //검색 버튼 눌렀을 때
   function search() {
      var keyword = document.getElementById('search');
      if(keyword.value==""){
         alert("검색어를 입력해주세요");
         return;
      }
      keyword = escape(encodeURIComponent(keyword.value));
/*       alert(keyword);
      if(value=='all'){
         alert("all선택 "+value);
      }
      else if(value=='title'){
         alert("title선택 "+value);
      }
      else if(value=='content'){
         alert("content선택 "+value);
      } */
      location.href="search.do?select="+value+"&&keyword="+keyword+"&&from=all";
   }
</script>
<style type="text/css">
th {
   width: 15%;
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
                            <h1 class="title">다른 사람들의 스토리북, 스토리 구경</h1>
                            <p>다른 사람들의 스토리북과 스토리를 검색하고 구경해보세요.</p>
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
	<div class="container" style="text-align: center;">
		<!-- 검색 -->
		<select id="category" onchange="category_selected()" style="width: 100px;">
			<option value="all">전체</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="location">장소</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:choose>
			<c:when test="${keyword==null}">
				<input type="text" name="search" id="search" placeholder="검색어를 입력하세요">
			</c:when>
			<c:otherwise>
				<input type="text" name="search" id="search" value="${keyword}">
			</c:otherwise>
		</c:choose>
		<input type="button" value="검색" onclick="search()"><p><br>
			<!-- 검색 기법  -->
			<input type="button" name="hotKeyword" value="${reportList[0]}" onclick="">&ensp; 
			<input type="button" name="hotKeyword" value="${reportList[1]}" onclick="">&ensp; 
			<input type="button" name="hotKeyword" value="${reportList[2]}" onclick="">&ensp; 
			<input type="button" name="hotKeyword" value="${reportList[3]}" onclick="">&ensp; 
			<input type="button" name="hotKeyword" value="${reportList[4]}" onclick=""><br><p>
	
			<!-- all, title, content 선택 -->
		<br/>
		<div>
			<input type="button" value="#ALL" onclick="selectButton('all')">&nbsp;&nbsp; 
			<input type="button" value="#BOOK" onclick="selectButton('book')">&nbsp;&nbsp; 
			<input type="button" value="#STORY" onclick="selectButton('story')"><p>
		</div>
	</div>
      <c:if test="${keyword!=null}">
         <h4 align="center">${keyword}의 검색 결과..story</h4>
      </c:if>
      <!-- 스토리 리스트 -->
      <c:choose>
		<c:when test="${fn:length(storyList)!=0}">
			<h2 align="center">Stories</h2>
			<div class="container" style="width: 85%;">
				<div class="row">
					<c:forEach items="${storyList}" var="story">
						<c:if test="${story.member.nickname!=sessionScope.mvo.nickname}">
							<div class="col-md-3">
								<article class="card" style="border: 1px solid #e9ebea; box-shadow: 10px 10px 5px #e9ebea;">
									<figure class="card__feature story1249">
										<div class="card__wrapper">
											<div class="storyPicture">
												<c:choose>
													<c:when test="${story.storyPictureUrl!=null}">
														<img src="upload/${story.storyPictureUrl}" class="card__img" alt="waves" width="275" height="240">
													</c:when>
													<c:otherwise>
														<img src="images/img.png" class="card__img" alt="waves" width="275" height="240">
													</c:otherwise>
												</c:choose>
												<c:if test="${sessionScope.mvo.email!=null}">
													<c:choose>
														<c:when test="${story.bookmark=='false'}">
															<div class="bookmark">
																<img id="${story.storyNo}" src="${initParam.root}images/bookmarkOff_story.png" width="50" height="50" onclick="bookmark('story',${story.book.book_no},${story.storyNo})">
															</div>
														</c:when>
														<c:otherwise>
															<div class="bookmark">
																<img id="${story.storyNo}" src="${initParam.root}images/bookmarkOn_story.png" width="50" height="50" onclick="deleteBookmark('story',${story.book.book_no},${story.storyNo})">
															</div>
														</c:otherwise>
													</c:choose>
												</c:if>
											</div>

											<figcaption>
												<div class="card__box">
													<header class="card__item card__header">
														<p class="sb-letter-b">Story</p>
														<h6 class="card__item card__item--small card__label">${story.member.nickname}</h6>

														<c:choose>
															<c:when test="${sessionScope.mvo.email!=null}">
																<h2 class="card__item card__item--small card__title" >
																	<a href="showStory.do?book_no=${story.book.book_no}&&storyNo=${story.storyNo}&&email=${sessionScope.mvo.email}" style="font-size: 33px; font-family: 'Nanum Myeongjo'">${story.storyTitle}</a>
																</h2>
															</c:when>
															<c:otherwise>
																<h2 class="card__item card__item--small card__title" style="font-size: 33px; font-family: 'Nanum Myeongjo';">
																	<a href="javascript:loginCheck()">${story.storyTitle}</a>
																</h2>
															</c:otherwise>
														</c:choose>
													</header>
													<section class="card__item card__body">
														<p>${story.storyContent}</p>
													</section>
												</div>
												<span class="story-down">
													<i class="fa fa-eye"></i>&nbsp;${story.storyHit}&nbsp;
													<i class="fa fa-comments"></i>&nbsp;${story.countComment}
												</span>
												<p>
											</figcaption>
										</div>
									</figure>
								</article>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<h2>공개된 스토리가 없습니다.</h2>
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
					<img src="images/home/under.png" class="img-responsive inline"
						alt="">
				</div>
				<div class="col-md-4 col-sm-6">
					<div class="testimonial bottom">
						<h2>Testimonial</h2>
						<div class="media">
							<div class="pull-left">
								<a href="#"><img src="images/home/profile1.png" alt=""></a>
							</div>
							<div class="media-body">
								<blockquote>Nisi commodo bresaola, leberkas venison
									eiusmod bacon occaecat labore tail.</blockquote>
								<h3>
									<a href="#">- Jhon Kalis</a>
								</h3>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<a href="#"><img src="images/home/profile2.png" alt=""></a>
							</div>
							<div class="media-body">
								<blockquote>Capicola nisi flank sed minim sunt
									aliqua rump pancetta leberkas venison eiusmod.</blockquote>
								<h3>
									<a href="">- Abraham Josef</a>
								</h3>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="contact-info bottom">
						<h2>Contacts</h2>
						<address>
							E-mail: <a href="mailto:someone@example.com">email@email.com</a>
							<br> Phone: +1 (123) 456 7890 <br> Fax: +1 (123) 456
							7891 <br>
						</address>

						<h2>Address</h2>
						<address>
							Unit C2, St.Vincent's Trading Est., <br> Feeder Road, <br>
							Bristol, BS2 0UY <br> United Kingdom <br>
						</address>
					</div>
				</div>
				<div class="col-md-4 col-sm-12">
					<div class="contact-form bottom">
						<h2>Send a message</h2>
						<form id="main-contact-form" name="contact-form" method="post"
							action="sendemail.php">
							<div class="form-group">
								<input type="text" name="name" class="form-control"
									required="required" placeholder="Name">
							</div>
							<div class="form-group">
								<input type="email" name="email" class="form-control"
									required="required" placeholder="Email Id">
							</div>
							<div class="form-group">
								<textarea name="message" id="message" required="required"
									class="form-control" rows="8" placeholder="Your text here"></textarea>
							</div>
							<div class="form-group">
								<input type="submit" name="submit" class="btn btn-submit"
									value="Submit">
							</div>
						</form>
					</div>
				</div>
				<div class="col-sm-12">
					<div class="copyright-text text-center">
						<p>&copy; Your Company 2014. All Rights Reserved.</p>
						<p>
							Designed by <a target="_blank" href="http://www.themeum.com">Themeum</a>
						</p>
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