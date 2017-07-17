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
    
    <!-- 검색창 -->
	<link rel="stylesheet" href="css/test1111.css">
	    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet"> 
    <link href="css/lightbox.css" rel="stylesheet"> 
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
	<link href="css/card.css" rel="stylesheet">
	<link href="css/card-book.css" rel="stylesheet">

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
    $(function() {
    	// 로그아웃 버튼 클릭 시 confirm
    	$('#logoutA').click(function(){
    		if(confirm("로그아웃 하시겠습니까?")){
        		 alert("로그아웃되었습니다.")
        		 location.href="logout.do";
        	 }else{
        		 return;
        	 }
    	});
    	
        
        // 인기 검색어 클릭 시 new 2
        $('.hotKeyword').bind("click", function() {
    		var str = $('#search').val();
    		var returnStr = str.split(" ");
    		
    		if(returnStr.length==1){
    			$('#search').val($('#search').val()+$(this).text()+" ");
    			return;
    		}	
    		for(var i=0; i<returnStr.length-1; i++){
    			if(returnStr[i]==$(this).text()){
    	            return;
    	         }
    		}//for
    		$('#search').val($('#search').val()+$(this).text()+" ");
        });//bind       
        
        
        //검색 엔터 추가..
        $("#search").keypress(function(enter) {
              if(enter.which==13){
                 search(); // 실행할 이벤트..
              }
        });//keypress
        
        // 검색창
    	$('.search-input').focus(function(){
    		$(this).parent().addClass('focus');
    	}).blur(function(){
    		$(this).parent().removeClass('focus');
    	}); // focus()
    	
    	// 카테고리 dropdown
    	$('.dropdown-toggle').dropdown();
    	
    });//function


    //전체, 책, 스토리 선택
    function selectButton(kind) {
    	var keyword = '${keyword}';
    	keyword = escape(encodeURIComponent(keyword));
    	location.href="searchAgain.do?keyword="+keyword+"&&select=${select}"+"&&from="+kind+"&&sort=";
    }


    ///북마크
    function deleteBookmark(kind, bno, sno) {
		$(function() {
        	$.ajax({
            	type:"post",
            	url:"bookDeleteBookmark.do",
               	data:"book_no="+bno,
               	dataType:"json",
                      
              	success:function(data){
                  	$('#'+bno).remove;
                  		location.reload();
               	}//callback
       		});//ajax
       	});//function
    }
    function bookmark(kind, bno, sno) { 
    	if(confirm("이 글을 북마크 하시겠습니까?")){
          	$(function() {
             	$.ajax({
                  	type:"post",
                   	url:"insertBookmark.do",
                    data:"book_no="+bno+"&&storyNo=0",
                  	dataType:"json",
                             
                 	success:function(data){
                     	$('#'+sno).remove;
                        	location.reload();
                 	}//callback
               	});//ajax
          	});//function
    	}
    }

    //로그인 체크
    function loginCheck() {
    	if(confirm("로그인을 해주세요.\n로그인 창으로 이동합니다."))	
    		location.href="index.jsp";
    }

    //검색
    var value="all";
    var category="";
    var index="";
    function category_selected() {
    	category = document.getElementById('category');
    	index = category.selectedIndex;
    	value = category.options[index].value;
    	document.getElementById('search').value="";
    }

    function search() {
        var keyword = document.getElementById('search');
        if(keyword.value==""){
           alert("검색어를 입력해주세요");
           return;
        }
        keyword = escape(encodeURIComponent(keyword.value));
        location.href="searchAgain.do?select="+value+"&&keyword="+keyword+"&&from=book&&sort=";
     }

    // 7/12 조회수순, 최신순, 인기순 정렬
	function sorting(kind) {
      	var keyword = '${keyword}';
       	keyword = escape(encodeURIComponent(keyword));
   		if(${select==""}) 
         	location.href="searchAgain.do?keyword="+keyword+"&&select=all&&from=book"+"&&sort="+kind;
      	else
           	location.href="searchAgain.do?keyword="+keyword+"&&select=${select}&&from=book"+"&&sort="+kind;
  	}
</script>
<style type="text/css">
table{
	width: 100%;
}
td{
	border: 1px solid #c2c3c4;
	width: 33%;
	height: 100px;
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
	<div class="container" style="width: 100%;">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-1">
				<select id="category" onchange="category_selected()" class="form-control" style="position: relative;top: 33px;height: 40px;">
				  <option value="all">전체</option>
				  <option value="title">제목</option>
				  <option value="content">내용</option>
				  <option value="location">장소</option>
				</select>
				
				<!-- <div class="search-option"> -->
				<!-- <input name="select" type="radio" value="all" id="type-users" checked="checked"> -->
				
			</div>
			<div class="col-md-4">
				<br/>
		<!-- --------------------------------------------- [시작] 검색창 --------------------------------------------- -->	
				<form class="search-form">
					<c:choose>
						<c:when test="${keyword==null}">
							<input type="text" name="search" id="search" placeholder="검색어를 입력하세요" class="search-input">
							
						</c:when>
						<c:otherwise>
							<input type="text" name="search" id="search" value="${keyword}" class="search-input">
							
						</c:otherwise>
					</c:choose>
				</form>
				<p>
				<i class="fa fa-search" aria-hidden="true" id="search-icon" type="button" onclick="search()"></i>

	<!-- --------------------------------------------- [끝] 검색창 --------------------------------------------- -->	
				
			</div>
			<div class="col-md-1">		
				<!-- <input type="button" onclick="search()" value="검색" style="top: 33px;position: relative;width: 100%;background-color: white; border-radius: 40px;height: 40px;" class="btn btn-common"> --> 
			</div>
			<div class="col-md-3"></div>
		</div>
			
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6" style="text-align: center;">
				<br/>
				인기검색어 &ensp;<i class="fa fa-chevron-right" aria-hidden="true"></i>&ensp;&ensp;&ensp;
				<a class="hotKeyword"><font size="4px">${reportList[0]}</font></a>&ensp;&ensp;&ensp;  
				<a class="hotKeyword"><font size="4px">${reportList[1]}</font></a>&ensp;&ensp;&ensp;   
				<a class="hotKeyword"><font size="4px">${reportList[2]}</font></a>&ensp;&ensp;&ensp; 
				<a class="hotKeyword"><font size="4px">${reportList[3]}</font></a>&ensp;&ensp;&ensp;
				<a class="hotKeyword"><font size="4px">${reportList[4]}</font></a>&ensp;&ensp;&ensp;
			</div>
			<div class="col-md-3">
			</div>
		</div>
		<br/>
		<br/>
		<br/>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<table style="width: 100%;text-align: center;">
					<tr>
						<td><a onclick="selectButton('all')">All</a></td>
						<td><a onclick="selectButton('story')">Story</a></td>
						<td style="background-color: #b71010;"><a onclick="selectButton('book')" style="color: white;">Storybook</a></td>
					</tr>
				</table>
			</div>
			<div class="col-md-3"></div>
		</div>
		<br/>
	</div>
	
	<!-- --------------------------------------------- [시작] Book List--------------------------------------------- -->	
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<%-- <c:if test="${keyword!=null}">
		<h4 align="center">${keyword}의검색결과..all</h4>
	</c:if> --%>
	<c:choose>
		<c:when test="${fn:length(bookList)!=0}">
			<div class="container" style="width: 85%;">
				<div class="row">
					<div class="col-md-12" style="text-align: center;">
						<font size="30px">STORYBOOK</font>
					</div>
					<div style="text-align: left;">
						<a class="sorting" id="new-sort" href="javascript:sorting('new')" style="font-size: 18px;text-decoration: underline;color: black;">최신순</a>&ensp;&ensp;
						<a class="sorting" id="hit-sort" href="javascript:sorting('hit')" style="font-size: 18px;color: black;">조회수순</a>&ensp;&ensp;
						<a class="sorting" id="bookmark-sort" href="javascript:sorting('bookmark')" style="font-size: 18px;color: black;">인기순</a>
					</div>
					<c:forEach items="${bookList}" var="book">
						<c:if test="${book.nick!=sessionScope.mvo.nickname}">
							<!-- book -->
							<div class="col-md-3">
								<article class="card-b" style="border: 1px solid #e9ebea; box-shadow: 10px 10px 5px #e9ebea;">
									<figure class="card__feature-b book1249-b">
										<div class="card__wrapper-b">
											<div class="storyPicture-b">
												<img src="upload/${book.book_picture_url}" class="card__img-b" alt="Bridge" width="275" height="100%" style="object-fit: cover;">
												<div class="bookmark-b">

												<c:if test="${sessionScope.mvo.email!=null}">
													<c:choose>
														<c:when test="${book.bookmark=='false'}">
															<div class="bookmark">
																<img id="${book.book_no}" src="${initParam.root}images/bookmarkOff_book.png" width="50" height="50" onclick="bookmark('book',${book.book_no},0)">
															</div>
														</c:when>
														<c:otherwise>
															<div class="bookmark">
																<img id="${book.book_no}" src="${initParam.root}images/bookmarkOn_book.png" width="50" height="50" onclick="deleteBookmark('book',${book.book_no},0)">
															</div>
														</c:otherwise>
													</c:choose>
												</c:if>
												</div>
											</div>

											<figcaption>
												<div class="card__box-b">
													<header class="card__item-b card__header-b">
														<p class="sb-letter-b">Book</p>
														<h6 class="card__item-b card__item--small-b card__label-b">${book.nick}</h6>
														<c:choose>
															<c:when test="${sessionScope.mvo.email!=null}">
																<h2 class="card__item-b card__item--small-b card__title-b bookTitle" style="font-size: 33px; font-family: 'Nanum Myeongjo'">
																	<a href="showStoryList.do?book_no=${book.book_no}"><b>${book.book_title}</b></a>
																</h2>
															</c:when>
															<c:otherwise>
																<h2 class="card__item card__item--small card__title" style="font-size: 33px; font-family: 'Nanum Myeongjo'">
																	<a href="javascript:loginCheck()">${book.book_title}</a>
																</h2>
															</c:otherwise>
														</c:choose>
													</header>

													<div class="story-down-b">
														<i class="fa fa-eye"></i>&nbsp;${book.book_hit}&nbsp; 
														<i class="fa fa-file-image-o" aria-hidden="true"></i>&nbsp;${book.storyCount}
													</div>
												</div>
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
		<!-- 북리스트 끝 -->
		</c:when>
		<c:otherwise>
			<h2>공개된 북이 없습니다.</h2>
		</c:otherwise>
	</c:choose>
	<!-- --------------------------------------------- [끝] Book List --------------------------------------------- -->
	
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