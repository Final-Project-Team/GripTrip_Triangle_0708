<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/sunny/jquery-ui.css">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/story/story2.css" rel="stylesheet">
	<link rel="stylesheet" href="css/story/story.css">
	<link href="css/main.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<div id="info" style="width: 93%; height: auto; border: 1px solid #EEEEEE">
	<div>
	<form action="insertStoryInfo.do" name="storyFrm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="book_no" value="${book_no}">
	<input type="hidden" name="bookmark" value="false">
	<div class="row">
		<div class="col-md-6">
		<input type="text" name="storyTitle" required="required" placeholder="제목" class="form-control" width="1000px"><p><p>
		<input type="file" name="uploadFile" placeholder="파일" class="form-control"><p><p>
		<textarea rows="20" cols="30" name="storyContent" required="required" style="height: 360px; width: 370px" class="form-control"></textarea>
		</div>
		<div class="col-md-6">
			<div id="mapLayout" style="float:left; width: 50%; margin-top:30px; margin-left: -8px;">
			SEARCH LOCATION
			<input id="pac-input" class="controls" type="text" placeholder="Enter a location">
			<div id="map" style="width:380px; height:300px;"></div>
			</div>
			<div class="tripDate">
				<input type="text" id="storyTripDate" name="storyTripDate" readonly="readonly" placeholder="날짜" class="form-control"><p><p>
			</div>
			<div class="location">
				<input type="text" name="storyLocation" id="storyLocation" style="width: 250px" placeholder="Enter the address" class="form-control">
			</div>
		</div>
	</div>
	<div>
	<hr>
	<div id="public">
	<input type="checkbox" name="storyIsPublic" value="public" onclick="checkBox(0)" checked="checked">공개
	&nbsp;&nbsp;&nbsp;
	<input type="checkbox" name="storyIsPublic" value="private" onclick="checkBox(1)">비공개
	<span id="storySubmit"><input type="submit" value="Story 추가"></span>
	</div>
	</div>
	</form>
	</div>
</div><br><br>
</body>
<script type="text/javascript" src="js/story/story.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAmXUJ7uh8JaGb0kNQGwPPOAUogVORYuj4&libraries=places&callback=initMap" async defer></script>
</html>