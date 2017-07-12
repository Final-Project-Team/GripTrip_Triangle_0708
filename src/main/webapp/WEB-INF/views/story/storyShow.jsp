<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/lightbox.css" rel="stylesheet"> 
    <link href="css/animate.min.css" rel="stylesheet"> 
	<link href="css/story/story2.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
<script type="text/javascript">
$(function(){	
      $('.recommentTr').hide();
      $('.updateCommentTr').hide();
      $('.updateComment').hide();
      $('.reComment').hide();
      
	   // 로그아웃 버튼 클릭 시 confirm
	  	$('#logoutA').click(function(){
	  		if(confirm("로그아웃 하시겠습니까?")){
	      		 alert("로그아웃되었습니다.")
	      		 location.href="logout.do";
	      	 }else{
	      		 return;
	      	 }
	  	});
	   
	   // 스토리 리스트 돌아가기
	  $('#storyListBtn').click(function () {
	          location.href="showStoryList.do?book_no=${story.book.book_no}&&email=${sessionScope.mvo.email}";
	  });//click
      
      // 스토리 삭제
      $('#storyDeleteBtn').click(function(){
         if(confirm("정말로 삭제하시겠습니까?")){
            location.href="deleteStory.do?storyNo=${story.storyNo}&&book_no=${story.book.book_no}";
         }
      }); // click()
      
      
      // 스토리 수정
      $('#storyUpdateBtn').click(function(){
         location.href="showUpdate.do?storyNo=${story.storyNo}&&book_no=${story.book.book_no}";         
      }); // click()
      
      
      // 댓글 쓰기
      $('#writeCommentForm').submit(function(){
         return true;
      }); // submit() 
      
      
      // 답글 쓰기 버튼 클릭
      $('a.recommentA').click('click', function(){
		$(this).parent().parent().hide();
		$(this).parent().parent().parent().parent().parent().find('.reComment').show();
      }); // click()
      
      
      // 답글 취소 버튼 클릭
      $('.cancelRecommentA').click(function(){
		$(this).parent().parent().parent().hide();
		$(this).parent().parent().children().prev('.post-comment').show();
		$(this).parent().parents().children('.post-comment').children().find('ul').show();
      }); // click();
      
    
      // 댓글 수정 버튼 클릭
      $('.commentUpdateA').click(function(){
		var content = $(this).parent().parents().prev('#comment').text();
		
		$(this).parent().parent().parent().hide();
		$(this).parent().parent().parent().parent().next('.updateComment').show();
		$(this).parent().parent().parent().parent().next().find('textarea').val(content);
      }); // 
      
      // 댓글 수정 취소
      $('.cancelUpdateCommentBtn').click(function(){
		$(this).parent().parent().parent().hide();
		$(this).parents().children('.post-comment').children().show();
      });

      if(${story.bookmark==false}){
          $('#bookmarkDelete').hide();
       }else{
          $('#bookmarkInsert').hide();
       }
     });
     
     //function>북마크, 해제 버튼 북마크 상황에 맞게 받아오기  
  	function bookmark(bno, sno){
        $(function() {
           $.ajax({
              type:"post",
              url:"insertBookmark.do",
              data:"book_no="+bno+"&&storyNo="+sno,
              dataType:"json",
              
              success:function(data){
                 $('#bookmarkInsert').hide();
                 $('#bookmarkDelete').show();
                 }//callback
             });//ajax
          });//function
       }//function>bookmark
     function deleteBookmark(bno, sno){
          $(function() {
             $.ajax({
               type:"post",
               url:"storyDeleteBookmark.do",
               data:"book_no="+bno+"&&storyNo="+sno,
               dataType:"json",
               
               success:function(data){
                  $('#bookmarkDelete').hide();
                  $('#bookmarkInsert').show();
               }//callback
             });//ajax
          });//function
       }
</script>
<style type="text/css">

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
							<h1 class="title">스토리 페이지</h1>
							<p>스토리의 상세 정보입니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
      
	<section id="blog-details" >
        <div class="container">
              <div class="single-blog" id="storyDetail">
                  <div class="post-thumb">
                    <c:if test="${story.storyPictureUrl!=null}">
                      <img src="upload/${story.storyPictureUrl}" style="width: 900px; height: 400px;">
                      <div class="post-overlay">
                         <c:choose>
                         <c:when test="${story.storyTripDate==null}">
                             <span class="uppercase">
                             <br><br><br>
                             <font style="color: white;" class="storyDate">&nbsp;${story.storyCreateDate}</font></span>
                          </c:when>
                          <c:otherwise>
                             <span class="uppercase">
                             <br><br><br>
                             <font style="color: white;">&nbsp;${story.storyTripDate}</font></span>
                          </c:otherwise>
                          </c:choose>
                      </div>
                       </c:if>
                  </div>
                  <div class="post-content overflow">
                  <h2 class="post-title bold">${story.storyTitle}</h2>
                      <h3 class="post-author"><a href="#">Posted by ${nickname}</a></h3>
                      <c:if test="${story.storyLocation!=null}">
                      at ${story.storyLocation}<br>
                      </c:if>
                      <br>
                      ${story.storyContent}
                      <div class="post-bottom overflow">
                        <ul class="nav navbar-nav post-nav">
                             <c:if test="${sessionScope.mvo.email!=null}">
								<li><a href="#" onclick="bookmark(${story.book.book_no},${story.storyNo})" id="bookmarkInsert"><i class="fa fa-bookmark-o"></i></a></li>
								<li><a href="#" onclick="deleteBookmark(${story.book.book_no},${story.storyNo})" id="bookmarkDelete"><i class="fa fa-bookmark"></i></a></li>
							</c:if>
                             <li><a href="#">${story.storyHit} hits</a></li>
                              <li><a href="#"><i class="fa fa-comments"></i>${countComment} Comments</a></li>
                              <c:if test="${sessionScope.mvo.email==story.member.email}">
                              <li><a href="#" id="storyUpdateBtn"><i class="fa fa-pencil"></i>수정</a></li>
                              <li><a href="#" id="storyDeleteBtn"><i class="fa fa-trash"></i>삭제</a></li>
                                 <c:if test="${story.storyIsPublic=='private'}">
                                        <li><a href="#"><i class="fa fa-lock" aria-hidden="true"></i></a></li>
                                 </c:if>
                              </c:if>
                              <li><a href="#" id="storyListBtn"><i class="fa fa-undo"></i>Story List</a></li>
                        </ul>
                        </div>
                           <br><br>
                        <div class="response-area">
						<h2 class="bold">Comments</h2>
						<ul class="media-list">
							<li class="media">
								<div id="comment">
                          			<c:choose>
               							<c:when test="${requestScope.cList != null}">
               								<c:forEach var="comment" items="${requestScope.cList}" varStatus="i">
               									<div class="all-comment">
				                              	<div class="post-comment">
				                              		<div class="row">
				                              			<div class="col-md-2">
				                              				<span id="re-comment">
               											<c:forEach begin="1" end="${comment.depth}">
	                                 						<%-- <img alt="" src="${initParam.root}images/re.png" width="50" height="50"> --%>
	                                 						re:
	                        							</c:forEach>
	                        						</span>
				                              			</div>
				                              		</div>
				                              		<span id="re-comment">
               											<c:forEach begin="1" end="${comment.depth}">
	                                 						<%-- <img alt="" src="${initParam.root}images/re.png" width="50" height="50"> --%>
	                        							</c:forEach>
	                        						</span>
				                          			<span class="media-body">
				                           				<span><i class="fa fa-user"></i>Posted by <a href="#">${comment.member.nickname}</a></span>
				                                   		<p id="comment">
				                                   		<c:if test="${comment.commentIsPublic=='private'}">
					                                      	<a href="#">
					                                      		<i class="fa fa-lock" aria-hidden="true"></i>
					                                      	</a>
				                                     	</c:if>
                                      					&nbsp;${comment.commentContent}</p>
                                     					<ul class="nav navbar-nav post-nav">
				                                       		<li><a href="#"><i class="fa fa-clock-o"></i>${comment.commentCreateDate}</a></li>
				                                        	<li><a class="recommentA"><i class="fa fa-reply"></i>Reply</a></li>
				                                     		<c:if test="${comment.member.email == sessionScope.mvo.email}">
								                            	<li><a class="commentUpdateA">[수정]</a></li>
								                            	<li><a href="removeComment.do?commentNo=${comment.commentNo}&&storyNo=${comment.story.storyNo}&&book_no=${story.book.book_no}">[삭제]</a></li>
			                          						</c:if>
				                                    	</ul>
				                                	</span>
				                            	</div>
				                          		<div class="updateComment">
						                         	<form action="updateComment.do" method="post">
							                       		<input type="hidden" name="storyNo" value="${story.storyNo}">
							                       		<input type="hidden" name="commentNo" value="${comment.commentNo}">
							                      		<input type="hidden" name="book_no" value="${story.book.book_no}">
							                      		<!-- 아이디-->
							                    		<div>${comment.member.nickname}</div>
	                          
							                 			<!-- 본문 작성-->
							                        	<div>
							                        		<textarea name="commentContent" rows="4" cols="90"></textarea>
							                         	</div>
							                           
							                            <!-- 댓글 등록 버튼 -->
							                     		<c:choose>
							                       			<c:when test="${comment.commentIsPublic == 'public'}">
							                                    <input type="radio" name="commentIsPublic" value="public" checked="checked">공개<p>
							                                    <input type="radio" name="commentIsPublic" value="private">비공개<p>
							                             	</c:when>
							                      			<c:otherwise>
							                               		<input type="radio" name="commentIsPublic" value="public">공개<p>
							                                    <input type="radio" name="commentIsPublic" value="private" checked="checked">비공개<p>
							                              	</c:otherwise>
							                           	</c:choose>
							                           	<input type="submit" class="updateCommentBtn" value="수정완료"><br/>
							                            <input type="button" class="cancelUpdateCommentBtn" value="수정취소">
						                        	</form>
						                        </div>
					                        	<div class="reComment">
						                        	<form action="writeRecomment.do" method="post" class="recommentFrm">
							                           <input type="hidden" name="lineNo" value="${i.index}">
							                           <input type="hidden" name="storyNo" value="${comment.story.storyNo}">
							                           <input type="hidden" name="parentCommentNo" value="${comment.commentNo}">
							                           <input type="hidden" name="parentCommentEmail" value="${comment.member.nickname}">
							                           <input type="hidden" name="groupId" value="${comment.groupId}">
							                           <input type="hidden" name="orderId" value="${comment.orderId}">
							                           <input type="hidden" name="depth" value="${comment.depth}">
							                           <span>${comment.member.nickname}님에 대한 답글</span>
							                           <textarea class="recomment" name="commentContent" rows="2" cols="80" required="required"></textarea>
							                           <input type="radio" name="commentIsPublic" value="public" checked="checked">공개<p>
							                           <input type="radio" name="commentIsPublic" value="private">비공개<p>
													   <input type="submit" value="답댓달기"><br/><a class="cancelRecommentA">[취소하기]</a>
						                        	</form>
						                       	</div>
				                            	</div>
                              				</c:forEach>
                              			</c:when>
                              		</c:choose>
                              	</div>
                          	</li>
                      	</ul>                   
                  	</div><!--/Response-area-->

                  	<!-- 로그인 했을 경우만 댓글 작성가능 -->
            <c:if test="${sessionScope.mvo != null}">
            	<form action="writeComment.do" method="post">
					<input type="hidden" name="storyNo" value="${story.storyNo}">
					<input type="hidden" name="depth" value="0">
					<input type="hidden" name="orderId" value="1">
                     
                    <!-- 아이디-->
					<div>${sessionScope.mvo.nickname}</div>
                    <!-- 본문 작성-->
                    <div>
						<textarea name="commentContent" rows="4" cols="90"></textarea>
					
                    <!-- 댓글 등록 버튼 -->
					<input type="radio" name="commentIsPublic" value="public" checked="checked">공개
					<input type="radio" name="commentIsPublic" value="private">비공개
                    	
                    <input type="submit" id="writeBtn" value="댓글등록">
					</div>	
            	</form>
            </c:if>
                  </div>
              </div>
          </div>
    </section>
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