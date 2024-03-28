<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- bootstarp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
	$(function(){
		$("#up").click(function(){
			var fileType = $("#uploadFile").val().split(".").pop(); // 파일 형식 추출하기

			var formData = new FormData();
			formData.append("uFile",$("#uploadFile")[0].files[0]);
			
			if ($.inArray(fileType,['txt']) == -1) {
				Swal.fire({
					   title: '.txt 확장자만 업로드 가능',
					   icon: 'error',
				});
				$("#uploadFile").val("");
				return false;
			}
			
			$.ajax({
				url : "/fileUpload.do",
				type : "post",
				enctype : "multipart/form-data",
				data : formData,
				contentType : false,
				processData : false,
				beforeSend : function(){
					modal();
				},
	             success : function() {
	                 $('#uploadtext').text("업로드 완료");
	                 setTimeout(timeout,2000);
				}
			}); // ajax end
			
		    var timeout = function(){
		        $('#mask').remove();
		        $('#loading').remove(); 
		     }
		});
		
		   function modal(){
		      var maskHeight = $(document).height();
		      var maskWidth = window.document.body.clientWidth;
		      
		      var mask = "<div id='mask' style='position:absolute;z-indx:5;background-color: rgba(0, 0, 0, 0.13);display:none;left:0;top:0;'></div>";
		      var loading = "<div id='loading' style='background-color:white;width:500px'><h1 id='uploadtext' style='text-align:center'>업로드 진행중</h1></div>";
		      
		      $('body').append(mask);
		      $('#mask').append(loading);
		      
		      $("#mask").css({
		         'height':maskHeight,
		         'width':maskWidth
		      });
		      
		      $('#loading').css({
		         /* 'position': 'absolute',
		          'top': '50%',
		           'left': '50%',
		           'transform': 'translate(-50%, -50%)' */
		         'position': 'absolute',
		         'left': '800px',
		         'top': '100px'

		      })
		      $('#mask').show();
		      $('#loading').show();
		   }
	});
</script>
<body>
    	<form name="upload">
            <input class="form-control" type="file" id="uploadFile" accept=".txt">
        </form>
            <button class="btn btn-warning mt-2" id="up">업로드</button>
</body>
</html>