<%@page import="dao.HotelDAO"%>
<%@page import="models.Hotel"%>
<%@page import="dao.ConferenceDAO"%>
<%@page import="models.Conference"%>
<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>广西大学会议管理中心 —— 酒店浏览</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<%@include file="maincss.html"%>

<style type="text/css">
.breadcrumbs-v1.img-hotel {
	background: url("public/images/hotel.jpg") no-repeat;
	background-size: cover;
	background-position: center center;
	height: 400px;
	padding-top: 150px;
}

p {
	font-size: 18px;
	line-height: 45px;
}

.breadcrumbs-v1 h1,.pull-center {
	float: none;
	color: #ffffff;
	font-weight: bold;
	font-style: normal;
	font-size: 45px;
}

body,html,#allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
	font-family: "微软雅黑";
}
</style>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=xn87TI6tRFvdxeGbwKxDplpvDRGvhH5a"></script>
</head>

<body class="header-fixed header-fixed-space-v2" data-spy="scroll"
	data-target="#main-nav" data-offset="150" style="overflow-y:scroll;">
	<div class="wrapper">
		<%@include file="header.jsp"%>

		<%
		Conference con = null;
		ConferenceDAO condao = new ConferenceDAO();
		con = condao.getConference();
			ArrayList<Hotel> al = HotelDAO.getAllHotel();
			if(con != null && al != null && !al.isEmpty()){
		%>
		<div class="breadcrumbs-v1 img-hotel margin-bottom-30">
			<div class="container" style="text-align: center">
				<h1 class="pull-center"><%=con.getCon_name()%></h1>
			</div>
		</div>
		<div class="container" style="margin-top: 30px;">
			<div class="headline">
				<h2>酒店一览</h2>
			</div>
			<%
				for(Hotel h : al){
			%>
			<div class="row">
				<div class="col-md-3">
					<p>
						<b>酒店名：</b><br><span style="font-size: 24px;"><%=h.getHot_name()%></span></p>
				</div>
				<div class="col-md-3">
					<p>
						<b>联系电话：</b><br><%=h.getHot_tel()%></p>
				</div>
				<div class="col-md-3">
					<p>
						<b>具体地址：</b><br><%=h.getHot_address()%></p>
				</div>
				<div class="col-md-3">
					<p>
						<b>缴费详情：</b><br><%=h.getHot_capital()%></p>
				</div>
			</div>
			<div class="row"
				style="margin-bottom: 30px; border-bottom-style: solid; border-bottom-width: 1px;">
				<div class="col-md-3">
					<p>
						<b>备注：</b><br><%=h.getHot_remarks()%></p>
				</div>
				<div class="col-md-3">
					<p>
						<b>会务组房间：</b><br><%=h.getHot_room()%></p>
				</div>
				<div class="col-md-3">
					<p>
						<b>会务组联系人：</b><br><%=h.getHot_linkman()%></p>
				</div>
				<div class="col-md-3">
					<p>
						<b>就餐安排：</b><br><%=h.getHot_arrangement()%></p>
				</div>
			</div>
			<%
				}
			%>
			<div class="headline">
				<h2>详细地图</h2>
			</div>
			<div id="allmap" style="height: 350px; margin-bottom: 40px;"></div>
		</div>
		<%@include file="footer.html"%>
	</div>
	<script type="text/javascript">

		function initMap() {
			createMap();//创建地图
			setMapEvent();//设置地图事件
			addMapControl();//向地图添加控件
			addMarker();//向地图中添加marker
		}

		//创建地图函数：
		function createMap() {
			var map = new BMap.Map("allmap");//在百度地图容器中创建一个地图
			var point = new BMap.Point(108.294978, 22.844025);//定义一个中心点坐标
			map.centerAndZoom(point, 15);//设定地图的中心点和坐标并将地图显示在地图容器中
			window.map = map;//将map变量存储在全局
		}

		//地图事件设置函数：
		function setMapEvent() {
			map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
			map.enableScrollWheelZoom();//启用地图滚轮放大缩小
			map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
			map.enableKeyboard();//启用键盘上下左右键移动地图
		}

		//地图控件添加函数：
		function addMapControl() {
			//向地图中添加缩放控件
			var ctrl_nav = new BMap.NavigationControl({
				anchor : BMAP_ANCHOR_TOP_LEFT,
				type : BMAP_NAVIGATION_CONTROL_LARGE
			});
			map.addControl(ctrl_nav);
			//向地图中添加缩略图控件
			var ctrl_ove = new BMap.OverviewMapControl({
				anchor : BMAP_ANCHOR_BOTTOM_RIGHT,
				isOpen : 1
			});
			map.addControl(ctrl_ove);
			//向地图中添加比例尺控件
			//var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
			//map.addControl(ctrl_sca);
		}

		//标注点数组
		var markerArr = [
				{
					title : "广西大学大礼堂",
					content : "主会场",
					point : "108.294978|22.844025",
					isOpen : 1,
					icon : {
						w : 21,
						h : 21,
						l : 0,
						t : 0,
						x : 6,
						lb : 5
					}
				},
				<%for(Hotel h : al){%>
						{
							title : "<%=h.getHot_name()%>",
							content : "地址：<%=h.getHot_address()%><br>电话：<%=h.getHot_tel()%>",
							point : "<%=h.getHot_lnglat()%>",
							isOpen : 0,
							icon : {
								w : 21,
								h : 21,
								l : 0,
								t : 0,
								x : 6,
								lb : 5
							}
						},
						<%}%>
				
				
				 ];
		//创建marker
		function addMarker() {
			for (var i = 0; i < markerArr.length; i++) {
				var json = markerArr[i];
				var p0 = json.point.split("|")[0];
				var p1 = json.point.split("|")[1];
				var point = new BMap.Point(p0, p1);
				var iconImg = createIcon(json.icon);
				var marker = new BMap.Marker(point, {
					icon : iconImg
				});
				var iw = createInfoWindow(i);
				var label = new BMap.Label(json.title, {
					"offset" : new BMap.Size(json.icon.lb - json.icon.x + 10,
							-20)
				});
				marker.setLabel(label);
				map.addOverlay(marker);
				label.setStyle({
					borderColor : "#808080",
					color : "#333",
					cursor : "pointer"
				});
				(function() {
					var index = i;
					var _iw = createInfoWindow(i);
					var _marker = marker;
					_marker.addEventListener("click", function() {
						this.openInfoWindow(_iw);
					});
					_iw.addEventListener("open", function() {
						_marker.getLabel().hide();
					});
					_iw.addEventListener("close", function() {
						_marker.getLabel().show();
					});
					label.addEventListener("click", function() {
						_marker.openInfoWindow(_iw);
					});
					if (!!json.isOpen) {
						label.hide();
						_marker.openInfoWindow(_iw);
					}
				})();
			}
		}
		//创建InfoWindow
		function createInfoWindow(i) {
			var json = markerArr[i];
			var iw = new BMap.InfoWindow(
					"<b class='iw_poi_title' title='" + json.title + "'>"
							+ json.title + "</b><div class='iw_poi_content'>"
							+ json.content + "</div>");
			return iw;
		}
		//创建一个Icon
		function createIcon(json) {
			var icon = new BMap.Icon(
					"http://api.map.baidu.com/img/markers.png", new BMap.Size(
							json.w, json.h), {
						imageOffset : new BMap.Size(-json.l, -json.t),
						infoWindowOffset : new BMap.Size(json.lb + 5, 1),
						offset : new BMap.Size(json.x, json.h)
					});
			return icon;
		}
		initMap();//创建和初始化地图
	</script>
	<%
		}
	%>
	<%@include file="mainjs.html"%>
</body>
</html>
