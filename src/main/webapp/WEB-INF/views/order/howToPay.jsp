<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			
			/* if(${p} == false){
				alert('비번이 일치하지 않으니 다시 입력하렴');
				$('#password').val('');
				$('#password').focus();
			}; */
			
			$('#checkPassForRemoveFrm').submit(function() {
				if(confirm("정말 탈퇴하시겠습니까?")) return true;
				else return false;
			});//submit
						
			
			$('#submit').click(function (){
				var radio = $('input[type=radio]').val();
				swal({
					  title: "OK!",
					  text: radio+"로 결제 완료.",
					  //imageUrl: "images/thumbs-up.jpg"
					});
				return true;
			});//click
			
		});//function
		
		/* function cancelOrder(orderNo) {
			if (confirm("정말 주문취소 하시겠습니까?")) {
				location.href = "cancelOrder.do?orderNo=" + orderNo;
			}
		} */
		
		
	</script>
<title>Insert title here</title>

<style type="text/css">
/* table */
/* Table Base */
.table order-list {
	font-family: arial;
	max-width: 100%;
	background-color: transparent;
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	margin-bottom: 20px;
}

.table thead th, .table tbody td {
	font-weight: normal;
	padding: 8px 15px;
	line-height: 100%;
	text-align: center;
	vertical-align: middle;
	border-top: 1px solid #dddddd;
}

.table tbody td{
	font-size: 15px;
}

.table thead th {
	background: #eeeeee;
	vertical-align: bottom;
	font-size: 18px;
	
}

.table .t-small {
	width: 10%;
}

.table .t-medium {
	width: 10%;
}

/* radio */
.radios {
	text-align: left;
	padding-top: 15px;
	padding-left: 15px;
	list-style-type: none;
	margin-bottom: 0;
}

.radios span {
	margin-bottom: 1em;
}

.radios span input[type="radio"]+label {
	font-size: 1.125em;
	font-weight: 300;
	cursor: pointer;
}

.radios span input[type="radio"]+label:before {
	content: '\f00c';
	font-family: 'FontAwesome';
	font-size: 12px;
	color: transparent;
	padding: 3px;
	background-color: #d7d7d7;
	border-radius: 50%;
	margin-right: 10px;
	vertical-align: 1px;
}

.radios span input[type="radio"]:checked+label:before {
	background-color: #2de1a8;
	color: white;
}

input[type="radio"] {
	display: none;
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
							<h1 class="title">결제 페이지</h1>
							<p>결제 방식을 선택해 주십시오.</p>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->

	<!-- --------------------------------------------- [시작] 본문 Section --------------------------------------------- -->
	<br />
	<br />
	<br />
	<section>
		<div class="container">
			<div class="col-md-12">
				<div class="row">
					<table class="table order-list">

						<thead id="order-header">
							<tr>
								<th class="t-medium">주문번호</th>
								<th class="t-medium">제목</th>
								<th class="t-small">수량</th>
								<th class="t-medium">총 금액</th>
								<!-- <th class="t-medium">주문취소</th> -->
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span class="">${order.orderNo}</span></td>
								<td><span class="">${order.book.book_title}</span></td>
								<td><span class="">${order.quantity}</span></td>
								<td><span class="">${order.totalPrice}</span></td>
								<%-- <td><a href="javascript: cancelOrder('${orderNo.orderNo}')" class="btn btn-common" >주문취소</a></td> --%>
								<%-- <td><input type="button" class="btn btn-common" value="주문취소" onclick="cancelOrder('${orderNo.orderNo}')"></td> --%>
							</tr>
						</tbody>

					</table>
				</div>
				<br /> <br />
				<div class="row">
					<div
						class="col-xs-12 col-sm-4 col-sm-offset-4 col-md-2 col-md-offset-5">
						<div class="radios">
							<form action="" id="payFrm">
								<span> <input type="radio" name="group" id="card"
									value="신용카드" checked="checked"> <label for="card">신용카드</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</span> <span> <input type="radio" name="group" id="bankbook"
									value="무통장입금"> <label for="bankbook">무통장입금</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</span> <span> <input type="radio" name="group" id="phone"
									value="휴대폰결제"> <label for="phone">휴대폰결제</label>
								</span>
								<div class="form-group">
									
									<a href="showOrderInfo.do?orderNo=${order.orderNo}" class="btn btn-submit" style="height: 50px; width: 120px; font-size: 20px;">결제</a>
									<!-- <input type="button" class="btn btn-submit" value="결제"	id="submit" style="height: 50px; width: 120px; font-size: 20px;"> -->
									<!-- <input type="button" class="btn btn-submit" value="결제" style="height: 50px; width: 120px; font-size: 20px"> -->
								</div>
								<br /> <br /> <br />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>

	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->

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

	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/lightbox.min.js"></script>
	<script type="text/javascript" src="js/wow.min.js"></script>
	<script type="text/javascript" src="js/jquery.countTo.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
</body>
</html>
