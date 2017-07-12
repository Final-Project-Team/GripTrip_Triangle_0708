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

<!-- 버튼 UI -->
<link rel="stylesheet" href="http://unicorn-ui.com/buttons/css/buttons.css">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/animate.min.css" rel="stylesheet">
<link href="css/lightbox.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">
<link href="css/card.css" rel="stylesheet">
<link href="css/card-book.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">

<!--[if lt IE 9]>
	    <script src="js/html5shiv.js"></script>
	    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.js"></script>
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
	
	/* $('input[name=hotKeyword]').bind("click", function() {
		var str = $('#search').val();
		var returnStr = str.split(" ");
		
		if(returnStr.length==1){
			$('#search').val($('#search').val()+$(this).val()+" ");
			return;
		}	
		for(var i=0; i<returnStr.length-1; i++){
			if(returnStr[i]==$(this).val()){
	            return;
	         }
		}//for
		$('#search').val($('#search').val()+$(this).val()+" ");
    });//bind       */
	
    // 인기 검색어 클릭시 new
    $('input[name=hotKeyword]').bind("click", function() {
		var str = $('#keyword').val();
		var returnStr = str.split(" ");
		
		if(returnStr.length==1){
			$('#keyword').val($('#keyword').val()+$(this).val()+" ");
			return;
		}	
		for(var i=0; i<returnStr.length-1; i++){
			if(returnStr[i]==$(this).val()){
	            return;
	         }
		}//for
		$('#keyword').val($('#keyword').val()+$(this).val()+" ");
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
	
	/* // 검색 카테고리 선택되었을 때
	$('.search-option>div').click(function(){
		//alert($('input:radio:checked').val());
		alert($('.search-form').serialize());
	}); */
	
	// 검색 버튼 클릭 시
	$('#search_new').click(function(){
		var infos = $('.search-form').serialize();
		var keyword = $('input[name=keyword]').val();
		
		if(keyword.value==""){
			alert("검색어를 입력해주세요");
			return;
		}
		
		keyword = escape(encodeURIComponent(keyword.value));
		location.href="search.do?"+infos+"&from=all";
	});
});//function


//전체, 책, 스토리 선택
function selectButton(kind) {
	var keyword = '${keyword}';
	keyword = escape(encodeURIComponent(keyword));
	location.href="searchAgain.do?keyword="+keyword+"&&select=${select}"+"&&from="+kind;
}


///북마크
function deleteBookmark(kind, bno, sno) {
	if(kind=='book'){
        $(function() {
            $.ajax({
               type:"post",
               url:"bookDeleteBookmark.do",
               data:"book_no="+bno,
               dataType:"json",
                  
               success:function(data){
                  $('#'+sno).remove;
                  location.reload();
               }//callback
            });//ajax
         });//function
	}
	else{
        $(function() {
            $.ajax({
               type:"post",
               url:"storyDeleteBookmark.do",
               data:"book_no="+bno+"&&storyNo="+sno+"&&from=all",
               dataType:"json",
                  
               success:function(data){
                  $('#'+sno).remove;
                  location.reload();
               }//callback
            });//ajax
         });//function
	}
}
function bookmark(kind, bno, sno) { 
	if(kind=='book'){
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
	else{
		if(confirm("이 글을 북마크 하시겠습니까?")){
               $(function() {
                   $.ajax({
                      type:"post",
                      url:"insertBookmark.do",
                      data:"book_no="+bno+"&&storyNo="+sno+"&&from=all",
                      dataType:"json",
                         
                      success:function(data){
                         $('#'+sno).remove;
                         location.reload();
                      }//callback
                   });//ajax
                });//function
		}
	}
}

//로그인 체크
function loginCheck() {
	if(confirm("로그인을 해주세요.\n로그인 창으로 이동합니다."))	
		location.href="Login.jsp";
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
//검색 버튼 눌렀을 때
	function search() {
	var keyword = document.getElementById('search');
	if(keyword.value==""){
		alert("검색어를 입력해주세요");
		return;
	}
	keyword = escape(encodeURIComponent(keyword.value));
	location.href="search.do?select="+value+"&&keyword="+keyword+"&&from=all";
} 

// 새로운 검색창
function search_new(){
	
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
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>

							<a class="navbar-brand" href="getMyBookList.do">
								<h1>
									<img src="images/logo.png" alt="logo">
								</h1>
							</a>

						</div>
						<div class="collapse navbar-collapse">
							<ul class="nav navbar-nav navbar-right">
								<li class="active"><a href="getMyBookList.do">Home</a></li>
								<li class="dropdown"><a
									href="showMemberInfo.do?email=${sessionScope.mvo.email}">내
										프로필 조회</a></li>
								<li class="dropdown"><a href="getOrderListOfMember.do">내
										주문 내역 조회</a></li>
								<li class="dropdown"><a
									href="getBookmarks.do?email=${sessionScope.mvo.email}">내
										북마크 조회</a></li>
								<li class="dropdown"><a href="getOtherBookList.do">다른
										사람들 스토리북 구경하기</a></li>
								<li class="dropdown"><a id="logoutA">로그아웃</a></li>
							</ul>
						</div>
						<div class="search">
							<form role="form">
								<i class="fa fa-search"></i>
								<div class="field-toggle">
									<input type="text" class="search-form" autocomplete="off"
										placeholder="Search">
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
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>

							<a class="navbar-brand" href="index.jsp">
								<h1>
									<img src="images/logo.png" alt="logo">
								</h1>
							</a>

						</div>
						<div class="collapse navbar-collapse">
							<ul class="nav navbar-nav navbar-right">
								<li class="active"><a href="index.jsp">Home</a></li>
								<li class="dropdown"><a href="getAllBookList.do">다른 사람들
										스토리북 구경하기</a></li>
							</ul>
						</div>
						<div class="search">
							<form role="form">
								<i class="fa fa-search"></i>
								<div class="field-toggle">
									<input type="text" class="search-form" autocomplete="off"
										placeholder="Search">
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
	<div class="container" style="background-color: #DEDEDE; width: 100%; min-height: 200px;">
		<!-- 검색 -->
		<%-- <select id="category" onchange="category_selected()" style="width: 100px;">
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
		<input type="button" value="검색" onclick="search()"><p><br> --%>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4">
				<br/>
				<!-- --------------------------------------------- [시작] 검색창 --------------------------------------------- -->	
				<form class="search-form">
					<c:choose>
						<c:when test="${keyword==null}">
							<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요" class="search-input">
						</c:when>
						<c:otherwise>
							<input type="text" name="keyword" id="keyword" value="${keyword}" class="search-input">
						</c:otherwise>
					</c:choose>
					<!-- <input type="search" value="" placeholder="Search" class="search-input" name="keyword"> -->
					<!-- <button type="submit" class="search-button">
						<svg class="submit-button">
			      			<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#search"></use>
			    		</svg>
					</button> -->
					<div class="search-option">
						<div>
							<input name="select" type="radio" value="all" id="type-users" checked="checked">
							<label for="type-users">
							<svg class="edit-pen-title">
			          			<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
			        		</svg> 
			        		<span>ALL</span>
							</label>
						</div>
			
						<div>
							<input name="select" type="radio" value="title" id="type-posts">
							<label for="type-posts">
							<svg class="edit-pen-title">
			          			<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#post"></use>
			        		</svg>
			        		<span>TITLE</span>
							</label>
						</div>
						<div>
							<input name="select" type="radio" value="content" id="type-images">
							<label for="type-images">
							<svg class="edit-pen-title">
			          			<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#images"></use>
			        		</svg>
			        		<span>CONTENTS</span>
							</label>
						</div>
						<div>
							<input name="select" type="radio" value="location" id="type-special">
							<label for="type-special">
								<svg class="edit-pen-title">
			          				<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#special"></use>
			        			</svg>
			        			<span>LOCATION</span>
							</label>
						</div>
					</div>
				</form>
				<p>
		
	
				<svg xmlns="http://www.w3.org/2000/svg" width="0" height="0" display="none">
				  	<symbol id="search" viewBox="0 0 32 32">
				    	<path d="M 19.5 3 C 14.26514 3 10 7.2651394 10 12.5 C 10 14.749977 10.810825 16.807458 12.125 18.4375 L 3.28125 27.28125 L 4.71875 28.71875 L 13.5625 19.875 C 15.192542 21.189175 17.250023 22 19.5 22 C 24.73486 22 29 17.73486 29 12.5 C 29 7.2651394 24.73486 3 19.5 3 z M 19.5 5 C 23.65398 5 27 8.3460198 27 12.5 C 27 16.65398 23.65398 20 19.5 20 C 15.34602 20 12 16.65398 12 12.5 C 12 8.3460198 15.34602 5 19.5 5 z" />
				  	</symbol>
				  	<symbol id="user" viewBox="0 0 32 32">
				    	<path d="M 16 4 C 12.145852 4 9 7.1458513 9 11 C 9 13.393064 10.220383 15.517805 12.0625 16.78125 C 8.485554 18.302923 6 21.859881 6 26 L 8 26 C 8 21.533333 11.533333 18 16 18 C 20.466667 18 24 21.533333 24 26 L 26 26 C 26 21.859881 23.514446 18.302923 19.9375 16.78125 C 21.779617 15.517805 23 13.393064 23 11 C 23 7.1458513 19.854148 4 16 4 z M 16 6 C 18.773268 6 21 8.2267317 21 11 C 21 13.773268 18.773268 16 16 16 C 13.226732 16 11 13.773268 11 11 C 11 8.2267317 13.226732 6 16 6 z" />
				    </symbol>
				  	<symbol id="images" viewbox="0 0 32 32">
				    	<path d="M 2 5 L 2 6 L 2 26 L 2 27 L 3 27 L 29 27 L 30 27 L 30 26 L 30 6 L 30 5 L 29 5 L 3 5 L 2 5 z M 4 7 L 28 7 L 28 20.90625 L 22.71875 15.59375 L 22 14.875 L 21.28125 15.59375 L 17.46875 19.40625 L 11.71875 13.59375 L 11 12.875 L 10.28125 13.59375 L 4 19.875 L 4 7 z M 24 9 C 22.895431 9 22 9.8954305 22 11 C 22 12.104569 22.895431 13 24 13 C 25.104569 13 26 12.104569 26 11 C 26 9.8954305 25.104569 9 24 9 z M 11 15.71875 L 20.1875 25 L 4 25 L 4 22.71875 L 11 15.71875 z M 22 17.71875 L 28 23.71875 L 28 25 L 23.03125 25 L 18.875 20.8125 L 22 17.71875 z" />
				  	</symbol>
				  	<symbol id="post" viewbox="0 0 32 32">
				    	<path d="M 3 5 L 3 6 L 3 23 C 3 25.209804 4.7901961 27 7 27 L 25 27 C 27.209804 27 29 25.209804 29 23 L 29 13 L 29 12 L 28 12 L 23 12 L 23 6 L 23 5 L 22 5 L 4 5 L 3 5 z M 5 7 L 21 7 L 21 12 L 21 13 L 21 23 C 21 23.73015 21.221057 24.41091 21.5625 25 L 7 25 C 5.8098039 25 5 24.190196 5 23 L 5 7 z M 7 9 L 7 10 L 7 13 L 7 14 L 8 14 L 18 14 L 19 14 L 19 13 L 19 10 L 19 9 L 18 9 L 8 9 L 7 9 z M 9 11 L 17 11 L 17 12 L 9 12 L 9 11 z M 23 14 L 27 14 L 27 23 C 27 24.190196 26.190196 25 25 25 C 23.809804 25 23 24.190196 23 23 L 23 14 z M 7 15 L 7 17 L 12 17 L 12 15 L 7 15 z M 14 15 L 14 17 L 19 17 L 19 15 L 14 15 z M 7 18 L 7 20 L 12 20 L 12 18 L 7 18 z M 14 18 L 14 20 L 19 20 L 19 18 L 14 18 z M 7 21 L 7 23 L 12 23 L 12 21 L 7 21 z M 14 21 L 14 23 L 19 23 L 19 21 L 14 21 z" />
				  	</symbol>
				  	<symbol id="special" viewbox="0 0 32 32">
				    	<path d="M 4 4 L 4 5 L 4 27 L 4 28 L 5 28 L 27 28 L 28 28 L 28 27 L 28 5 L 28 4 L 27 4 L 5 4 L 4 4 z M 6 6 L 26 6 L 26 26 L 6 26 L 6 6 z M 16 8.40625 L 13.6875 13.59375 L 8 14.1875 L 12.3125 18 L 11.09375 23.59375 L 16 20.6875 L 20.90625 23.59375 L 19.6875 18 L 24 14.1875 L 18.3125 13.59375 L 16 8.40625 z M 16 13.3125 L 16.5 14.40625 L 17 15.5 L 18.1875 15.59375 L 19.40625 15.6875 L 18.5 16.5 L 17.59375 17.3125 L 17.8125 18.40625 L 18.09375 19.59375 L 17 19 L 16 18.40625 L 15 19 L 14 19.59375 L 14.3125 18.40625 L 14.5 17.3125 L 13.59375 16.5 L 12.6875 15.6875 L 13.90625 15.59375 L 15.09375 15.5 L 15.59375 14.40625 L 16 13.3125 z" />
				  	</symbol>
				</svg>
				<br/>
				<div style="text-align: center;">
					<a class="button button-3d button-action button-pill" onclick="selectButton('book')">#Storybook</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="button button-3d button-action button-pill" onclick="selectButton('story')">#Story</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<ahref="http://unicorn-ui.com/" class="button button-3d button-action button-pill" onclick="selectButton('all')">#All</a>
				</div>
			</div>

	<!-- --------------------------------------------- [끝] 검색창 --------------------------------------------- -->	
			<!-- <div class="col-md-1"></div> -->
			<div class="col-md-6">
				<br/>
				<!-- 검색 기법  -->
				<span>인기 검색어</span>&ensp;
				<input type="button" name="hotKeyword" value="${reportList[0]}" onclick="" class="button button-primary button-raised button-pill">&ensp; 
				<input type="button" name="hotKeyword" value="${reportList[1]}" onclick="" class="button button-primary button-raised button-pill">&ensp; 
				<input type="button" name="hotKeyword" value="${reportList[2]}" onclick="" class="button button-primary button-raised button-pill">&ensp; 
				<input type="button" name="hotKeyword" value="${reportList[3]}" onclick="" class="button button-primary button-raised button-pill">&ensp; 
				<input type="button" name="hotKeyword" value="${reportList[4]}" onclick="" class="button button-primary button-raised button-pill"><br><p>
			
				<!-- all, title, content 선택 -->
				<br/>
				<!-- <div>
					<input type="button" value="#ALL" onclick="selectButton('all')">&nbsp;&nbsp; 
					<input type="button" value="#BOOK" onclick="selectButton('book')">&nbsp;&nbsp; 
					<input type="button" value="#STORY" onclick="selectButton('story')"><p>
				</div> -->
				<span>정렬</span>&ensp;&ensp;&ensp;
				<input type="button" value="조회순" class="button button-highlight button-raised button-pill">&nbsp;&nbsp; 
				<input type="button" value="인기순" class="button button-highlight button-raised button-pill">&nbsp;&nbsp; 
				<input type="button" value="최신순" class="button button-highlight button-raised button-pill"><p>
			</div>
			<div class="col-md-1">
				<input type="button" value="검색" id="search_new" style="width: 100%;background-color: white; border-radius: 40px;height: 40px;" class="btn btn-common" >
			</div>
			<!-- <div class="col-md-6" style="background-color: black; height: 100px;"></div>
			<div class="col-md-1"></div> -->
		</div>
	</div>
	
	
	<!-- --------------------------------------------- [시작] Book List--------------------------------------------- -->
	<!-- <div class="container"> -->
	<c:if test="${keyword!=null}">
		<h4>${keyword}의검색결과..all</h4>
	</c:if>
	<c:choose>
		<c:when test="${fn:length(bookList)!=0}">
			<h2 align="center">Books</h2>
			<div class="container" style="width: 85%;">
				<div class="row">
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
																<img id="0" src="${initParam.root}images/bookmarkOff_book.png" width="50" height="50" onclick="bookmark('book',${book.book_no},0)">
															</div>
														</c:when>
														<c:otherwise>
															<div class="bookmark">
																<img id="0" src="${initParam.root}images/bookmarkOn_book.png" width="50" height="50" onclick="deleteBookmark('book',${book.book_no},0)">
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
														<h2 class="card__item-b card__item--small-b card__title-b bookTitle" style="font-size: 33px; font-family: 'Nanum Myeongjo'">
															<a href="showStoryList.do?book_no=${book.book_no}"><b>${book.book_title}</b></a>
														</h2>
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
			<!-- <a href="book_Insert.jsp" >Story Book 추가하기</a> -->
		</c:otherwise>
	</c:choose>
	<!-- </div> -->
	<!-- --------------------------------------------- [끝] Book List --------------------------------------------- -->
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />


	<!-- --------------------------------------------- [시작] Story List--------------------------------------------- -->
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
																<h2 class="card__item card__item--small card__title" style="font-size: 33px; font-family: 'Nanum Myeongjo'">
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

	<!-- --------------------------------------------- [끝] Story List--------------------------------------------- -->

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