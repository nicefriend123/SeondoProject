<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- bootstarp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<style type="text/css">
a{
	color:black;
	text-decoration: none;
}
</style>
</head>
<script type="text/javascript">
var tl_sd;
var tl_sgg;
var tl_bjd;
$(function(){
//시도 레이어 띄우기 및 시군구 옵션 띄우기
$('#loc').change(function() {
					var loc = $(this).val();
					var locTest = loc.split(",");
					var sdCd = locTest[0];
					var sdX = locTest[1];
					var sdY = locTest[2];
					var sdArea = locTest[3];
					var center = ol.proj.transform([parseFloat(sdX), parseFloat(sdY)], 'EPSG:4326', 'EPSG:3857');
					map.getView().setCenter(center);
					if (sdArea < 2000) {
						map.getView().setZoom(10);
					} else if (sdArea < 10000){
						map.getView().setZoom(9);
					} else if (sdArea < 20000){
						map.getView().setZoom(8);
					}
					//alert('코드: ' + sdCd + ' X: ' + sdX + ' Y: ' + sdY);
					sggcd2 = sdCd.substring(0,2);
					//var cql_filter = "sd_cd = '" + sdCd + "'";
					var cql_filter = "adm_sect_c LIKE '" + sggcd2 + "%'";
					//alert(cql_filter);
					$('#bjdSelect').children().remove();
				    $('#bjdSelect').append('<option>--법정동을 선택하세요--</option>');
					//alert(loc);
					$.ajax({
								type : "post", // 또는 "GET", 요청 방식 선택
								url : "/sd.do", // 컨트롤러의 URL 입력
								data : {"sd" : sdCd}, // 선택된 값 전송
								dataType : 'json',
								success : function(response) {
									//alert('AJAX 요청 성공!' + response);
									var sggSelect = $("#sggSelect");
									sggSelect.html("<option>--시/군/구를 선택하세요--</option>");
									sggSelect.append("<option>전체 선택</option>")
									for (var i = 0; i < response.length; i++) {
										var item = response[i];
										sggSelect.append("<option value='" + item.adm_sect_c + "," + item.x + "," + item.y + ","+ item.area +  "'>"
														+ item.sgg_nm
														+ "</option>");
									}
									//map.getView().fit((ol.proj.transform([response[0].xmax, response[0].ymax, response[0].xmin, response[0].ymin], 'EPSG:4326', 'EPSG:3857')));
								},
								error : function(xhr, status, error) {
									// 에러 발생 시 수행할 작업
									alert(xhr + "::::::" + error
											+ 'ajax 실패' + sdCd + ","
											+ sggSelect);
									// console.error("AJAX 요청 실패:", error);
								}
							});
					// 기존에 추가되었던 레이어들을 숨깁니다.
					map.getLayers().forEach(function(layer) {
						if (layer.get('name') !== 'Base') { // 기본 배경 레이어는 숨기지 않습니다.
							layer.setVisible(false);
						}
					});
					
					// 선택된 새로운 레이어를 추가하고 보이도록 설정합니다.
					tl_sggline = new ol.layer.Tile(
							{
								name : 'selectedLayer', // 선택된 레이어의 이름을 지정합니다.
								visible : true,
								source : new ol.source.TileWMS(
										{
											url : 'http://localhost:8080/geoserver/Project_nk/wms',
											params : {
												'version' : '1.1.0',
												'request' : 'GetMap',
												'CQL_FILTER' : cql_filter,
												'layers' : 'Project_nk:tl_sgg',
												'bbox' : [
													1.386872E7,
													3906626.5,
													1.4428071E7,
													4670269.5 ],
												'width' : '562',
												'height' : '768',
												'srs' : 'EPSG:3857',
												'format' : 'image/png'
											},
											serverType : 'geoserver',
										})
							});
					$('.btn.btn-warning').click(function() {
				        // 여기에 검색 버튼 클릭 시 실행될 코드 추가
				        // 예를 들어, 선택된 시/군/구 또는 법정동에 대한 데이터를 가져와서 레이어를 추가하는 코드를 작성할 수 있습니다.
				        // 레이어를 추가하는 방법은 이미 위의 코드에 구현되어 있습니다.
					map.addLayer(tl_sggline);
				    });
				});
//시군구 레이어 띄우고 법정동 옵션 띄우기
$('#sggSelect').change(function() {
					var sggSelect = $(this).val();
					var sggSelectVal = sggSelect.split(",");
					var sggCd = sggSelectVal[0];
					var sggX = sggSelectVal[1];
					var sggY = sggSelectVal[2];
					var sggArea = sggSelectVal[3];
					var center = ol.proj.transform([parseFloat(sggX), parseFloat(sggY)], 'EPSG:4326', 'EPSG:3857');
					map.getView().setCenter(center);
					if (sggArea < 2000) {
						map.getView().setZoom(10);
					} else if (sggArea < 10000){
						map.getView().setZoom(9);
					} else if (sggArea < 20000){
						map.getView().setZoom(8);
					}
					var cql_filter2 = "adm_sect_c = '" + sggCd + "'";
					//alert(sggSelect);
					$.ajax({
								type : "post",
								url : "/sgg.do",
								data : {"sgg" : sggCd},
								dataType : 'json',
								success : function(response) {
									//alert('AJAX 요청 성공!' + response + length);
									var bjdSelect = $("#bjdSelect");
									bjdSelect.html("<option>--법정동을 선택하세요--</option>");
									for (var i = 0; i < response.length; i++) {
										var item1 = response[i];
										bjdSelect.append("<option value='" + item1.bjd_cd + "," + item1.x + "," + item1.y + "'>"
														+ item1.bjd_nm
														+ "</option>");
									}
								},
								error : function(xhr, status, error) {
									alert(xhr + "::::::" + error
											+ 'ajax 실패' + sggSelectVal + ","
											+ sggSelect);
									// console.error("AJAX 요청 실패:", error);
								}
							});

					tl_sgg = new ol.layer.Tile(
							{
								name : 'selectedLayer',
								visible : true,
								source : new ol.source.TileWMS(
										{
											url : 'http://localhost:8080/geoserver/Project_nk/wms',
											params : {
												'version' : '1.1.0',
												'request' : 'GetMap',
												'CQL_FILTER' : cql_filter2,
												'layers' : 'Project_nk:a5sggview',
												'bbox' : [ 1.3867446E7,
														3906626.5,
														1.4684053E7,
														4670269.5 ],
												'width' : '768',
												'height' : '718',
												'srs' : 'EPSG:3857',
												'format' : 'image/png'
											},
											serverType : 'geoserver',
										})
							});
					$('.btn.btn-warning').click(function() {
				        // 여기에 검색 버튼 클릭 시 실행될 코드 추가
				        // 예를 들어, 선택된 시/군/구 또는 법정동에 대한 데이터를 가져와서 레이어를 추가하는 코드를 작성할 수 있습니다.
				        // 레이어를 추가하는 방법은 이미 위의 코드에 구현되어 있습니다.
					map.addLayer(tl_sgg);
				    });
				}); // $('#sggSelect').change

//법정동 옵션 띄우고 법정동 레이어 띄우기
$('#bjdSelect').change(function() {
					var bjdSelect = $(this).val();
					var bjdSelectVal = bjdSelect.split(",");
					var bjdCd = bjdSelectVal[0];
					var bjdX = bjdSelectVal[1];
					var bjdY = bjdSelectVal[2];
					var center = ol.proj.transform([parseFloat(bjdX), parseFloat(bjdY)], 'EPSG:4326', 'EPSG:3857');
					map.getView().setCenter(center);
					map.getView().setZoom(12);
					var cql_filter3 = "bjd_cd = '" + bjdCd + "'";
					
					tl_bjd = new ol.layer.Tile(
							{
								name : 'selectedLayer',
								visible : true,
								source : new ol.source.TileWMS(
										{
											url : 'http://localhost:8080/geoserver/Project_nk/wms',
											params : {
												'version' : '1.1.0',
												'request' : 'GetMap',
												'CQL_FILTER' : cql_filter3,
												'layers' : 'Project_nk:a5bjdview',
												'bbox' : [ 1.3873946E7,
														3906626.5,
														1.4428045E7,
														4670269.5 ],
												'width' : '557',
												'height' : '768',
												'srs' : 'EPSG:3857',
												'format' : 'image/png'
											},
											serverType : 'geoserver',
										})
							});
					$('.btn.btn-warning').click(function() {
				        // 여기에 검색 버튼 클릭 시 실행될 코드 추가
				        // 예를 들어, 선택된 시/군/구 또는 법정동에 대한 데이터를 가져와서 레이어를 추가하는 코드를 작성할 수 있습니다.
				        // 레이어를 추가하는 방법은 이미 위의 코드에 구현되어 있습니다.
					map.addLayer(tl_bjd);
				    });
				}); // $('#bjdSelect').change
});
		</script>
<body>

<div class="select">
		<div>
			<select id="loc" name="loc">
				<option>시/도 선택</option>
				<c:forEach items="${getSd}" var="row">
					<option value="${row.sd_cd},${row.x},${row.y},${row.area}">${row.sd_nm}</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<select id="sggSelect">
				<option>--시/군/구를 선택하세요--</option>
			</select>
		</div>
		<div>
			<select id="bjdSelect">
				<option>--법정동을 선택하세요--</option>
			</select>
		</div>
		<div>
			<select id="legend">
				<option>--범례를 선택하세요--</option>
				<option>등간격</option>
				<option>Natural Break</option>
			</select>
		</div>
		<button class="btn btn-warning">검색</button>
	</div>
</body>
</html>