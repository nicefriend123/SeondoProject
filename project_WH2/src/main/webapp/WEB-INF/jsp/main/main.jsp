<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>브이월드 WMTS 배경지도 사용하기 오픈레이어스 3버전 이상</title>
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- vworld -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
<style type="text/css">
#menu{
cursor:pointer;
}
a{
	color:black;
	text-decoration: none;
}
</style>

<script type="text/javascript">
var map;
var Base;
var view;
$(function() {
    Base = new ol.layer.Tile({
        name : "Base",
        source : new ol.source.XYZ({
            url : 'https://api.vworld.kr/req/wmts/1.0.0/00B30A76-519C-3E71-8784-D4F39CD26CFB/Base/{z}/{y}/{x}.png'
        })
    }); // WMTS API 사용

    view = new ol.View({
        center : ol.proj.transform([ 127.100616, 37.402142 ], 'EPSG:4326', 'EPSG:3857'),
        zoom : 6,
        maxZoom : 18,
        minZoom : 4
    });

    map = new ol.Map({
        layers : [ Base ],
        target : 'map',
        view : view
    });
    
    $("#mapview").click(function(e){
        e.preventDefault(); // 기본 동작 방지(화면 이동 방지)
        
        $.ajax({
            type:'get',
            url : '/map.do',
            dataType:'html',
            success:function(response){
                $("#views").html(response);
            },
            error:function(error){
                alert("탄소지도 페이지 불러오기 오류");
            }
        });
    });    
    
    $("#fileUpload").click(function(e){
        e.preventDefault(); // 기본 동작 방지(화면 이동 방지)
        
        $.ajax({
            type:'get',
            url : '/fileUpload.do',
            dataType:'html',
            success:function(response){
                $("#views").html(response);
            },
            error:function(error){
                alert("업로드 페이지 불러오기 오류");
            }
        });
    });
    
    $("#status").click(function(e){
        e.preventDefault(); // 기본 동작 방지(화면 이동 방지)
        
        $.ajax({
            type:'get',
            url : '/status.do',
            dataType:'html',
            success:function(response){
                $("#views").html(response);
            },
            error:function(error){
                alert("통계 페이지 불러오기 오류");
            }
        });
    });
});

</script>
</head>
<style>
.container {
	border: 1px solid black;
	width: 75%;
}

.main {
	border: 1px solid black;
	display: flex;
	margin: 5px;
}

.subcontainer {
	
}

.two {
	display: flex;
	margin: 5px;
}

.header {
	background: gray;
	color: white;
	text-align: center;
	margin: 5px;
}

.footer {
	background: gray;
	color: white;
	text-align: center;
	margin: 5px;
}

.sub-main{
	margin: 5px;
	width: 50%;
	text-align: center;
	border: 1px solid black;
}
.function {
    display: flex; /* Flexbox 사용 */
    border-top: 1px solid black;
    border-bottom: 1px solid black;
}

.nav{
	border-right: 1px solid black;
}

.function .nav,
.function .select {
    flex: 1;
}

#map{
}
</style>
<body>
<header class="bg-primary text-light py-3 ">
  <div class="container text-center">Header</div>
</header>
<div class="container-fluid d-flex flex-column m-3" style="height: 100%;">
    <div class="row flex-grow-1">
        <div class="col-md-4 d-flex flex-column">
            <div class="row">
                <div class="col-md-12 border border-dark">
                    <div class="text-center bold fs-4" style="height: 50px;">탄소 공간지도 시스템</div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 border border-dark border-end-0 border-top-0 p-0">
                    <div>
                        <%@ include file="menu.jsp"%>
                    </div>
                </div>
                    <div id = "views" class="col-md-9 p-3 border border-dark border-top-0" style="height: 915.5px;">메뉴를 선택해주세요</div>
            </div>
        </div>
        <div class="col-md-8 p-0">
            <div id="map" style="height: 966px"></div>
        </div>
    </div>
</div>
<footer class="footer mt-auto py-2 bg-dark text-light">
  <div class="container text-center">
    <p>&copy; 2024 Your Website</p>
  </div>
</footer>
</body>
</html>
