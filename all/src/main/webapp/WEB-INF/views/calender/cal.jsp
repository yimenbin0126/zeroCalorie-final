<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*"
	import=" com.zerocalorie.calender.dto.*"
	import="com.zerocalorie.member.dto.*"
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% boolean mypage= (boolean)request.getAttribute("mypage");%>
<% String pageId= (String)request.getAttribute("pageId");%>

<% // >> 페이징 

Map chrPagingMap = (Map)request.getAttribute("chrPagingMap");

int pageNum  = (int)chrPagingMap.get("pageNum");
int countPerPage  = (int)chrPagingMap.get("countPerPage"); 
int count = (int)chrPagingMap.get("count"); 
int[] countPerPageArr = (int[])chrPagingMap.get("countPerPageArr");
int lastPage = (int)Math.ceil(((double)count/countPerPageArr[countPerPage])); //올림

String uri = (String)chrPagingMap.get("uri"); 

int section = 5;

int sec_position = (int)Math.ceil(((double)pageNum/section));
int firstNo = ((sec_position-1) * section+1);
//if( firstNo<1 ){ firstNo = 1; }
int lastNo = firstNo +section -1;
if( lastNo > lastPage ){ lastNo = lastPage; }
%>
<!-- 이미지 아이콘 관련 -->
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<title>캘린더</title>
<link rel="stylesheet" href="/all/resources/calender/css/cal.css">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c8aa6c385f8c2a6200d1715e4b45d568&libraries=services"></script>
<script src="/all/resources/calender/js/cal.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	window.onload=function(){

	<%  Map<String, Integer> pageDateInfo = new HashMap();
			// 날짜 정보 받아옴
		pageDateInfo = (Map) request.getAttribute("pageDateInfo");
		
		int year =(int) pageDateInfo.get("pageYear");
		int month = (int) pageDateInfo.get("pageMonth");	
		int date = (int) pageDateInfo.get("pageDate");
		
		String pageDate = year +"-"+month+"-"+date;
		
		System.out.println(  "html에서 받는 date : "+ pageDate);%>
	
		let now = new Date();
		
		// 받아온 날짜 세팅
		let year = <%=year%>;
		let month = <%=month%> ;
		
		let date = <%=date%> ;
		
		$("#todo_date").text(year+'-'+(month+1)+'-'+date);
		
		let data = ajax_bind(year, month);

		// 기본 달력 날짜 그려주기
		//yoo_drawCalendar(year, month);
		
		//오늘 날짜 셀만 표시
		//today_mark(year, month);
				
		// 달력에 받아온 데이터값 넣기 
		//yoo_addDataCal();
	
		// 이전달 버튼 눌렸을 때 
		//yoo_click_pre_month(year,month);
		
		// 다음달 버튼 눌렸을 때 
		//yoo_click_next_month(year,month);
		
		// 달력 안에 cell 눌렀을때
		// click_cell(data);
		
		// 수정 버튼 눌렀을때
		update_contents();
		
		// 수정 취소 버튼 눌렸을 때
		update_contents_cancel();
		
		// 댓글 달기 버튼 눌렀을때
		click_rpl_chr_btn();
		
		// 응원메세지 댓글 입력 버튼 눌렀을 때
		//click_cheerMsgRplAdd();
		
		// 페이징 select 
		selected_fn();
		
		// 위치와 날씨 받아오기
		location_weather();
		
	}
	
	

// 이전달 버튼 눌렸을 때 
function yoo_click_pre_month(year,month){
	$("#pre_month").off("click").on("click",function(){
		
		// todo_date에 날짜 지우기
		$("#todo_date").text('');
		
		// 각 todolist 항목 지우기
		$(".workout").empty();
		$(".food").empty();
		
		month -= 1;
		
		// 1월[0] 이전이면 연도 줄이고, 달 12월로 세팅
		if (month < 0) {
			year -= 1;
			month = 11;
		}
										
		let clickDate = '';
		clickDate += $('#yoo_h5_year').text();
		clickDate += '-'+$('#yoo_h3_cal').text();
		console.log(clickDate);
					         
		// 날짜값 전송			        
		document.querySelector(".pageYearhidden").setAttribute("value", year);
		document.querySelector(".pageMonthhidden").setAttribute("value", month);
		document.querySelector(".pageDatehidden").setAttribute("value", <%=date%>);

//		document.sendPageDateInfo.method = "post";
//		document.sendPageDateInfo.action = "";
//		document.sendPageDateInfo.submit();

		ajax_bind(year, month);
	});
}

//다음달 버튼 눌렸을 때 
function yoo_click_next_month(year,month){
		$("#next_month").off("click").on("click",function(){
			
			// todo_date에 날짜 지우기
			$("#todo_date").text('');
			
			// 각 todolist 항목 지우기
			$(".workout").empty();
			$(".food").empty();
		
		
		month += 1;
		// 12월([11]) 넘어가면
		if (month > 11) {
			year += 1;
			month = 0;
		}
										
		let clickDate = '';
		clickDate += $('#yoo_h5_year').text();
		clickDate += '-'+$('#yoo_h3_cal').text();
		console.log(clickDate);
					         
		// 날짜값 전송			        
		document.querySelector(".pageYearhidden").setAttribute("value", year);
		document.querySelector(".pageMonthhidden").setAttribute("value", month);
		document.querySelector(".pageDatehidden").setAttribute("value", <%=date%>);

//		document.sendPageDateInfo.method = "post";
//		document.sendPageDateInfo.action = "";
//		document.sendPageDateInfo.submit();

		ajax_bind(year, month);
	});
}
	
//달력에 받아온 데이터값 넣기 form
function yoo_addDataCal() {
	
	<%List<TodoListDTO> calTodolist = (ArrayList)request.getAttribute("calTodolist");%>
	
	// cursor_hand : 숫자가표시된 hover 되는 cell만 검색
	document.querySelectorAll(".cursor_hand").forEach(function(item, index){
		
	<%TodoListDTO calTodoListDTO = new TodoListDTO();
	
		// todolist 하나씩 꺼내온다
		for(int ii =0 ; ii < calTodolist.size() ; ii++){
			calTodoListDTO = (TodoListDTO)calTodolist.get(ii);%>
	
			// 날짜와 = 클릭가능한 달력 index(0부터)가 같으면 내용 입력
			if(<%=calTodoListDTO.getTdl_date().substring(8,10)%> == (index-1)) {
				let ctl = document.createElement("li");
				
				<%// 카테고리 색 바꾸는 부분
				String setCtgColor="green";
					if( calTodoListDTO.getTdl_category().equals("운동")){setCtgColor="red"; }
					else if( calTodoListDTO.getTdl_category().equals("식단")){setCtgColor="blueviolet"; }%>
				
				// 카테고리명과 컨텐츠
				let m = '<a style="color: <%=setCtgColor%>; text-decoration: none;">';
					m+= '<%=calTodoListDTO.getTdl_category()%></a> ';
					m+= '<%=calTodoListDTO.getTdl_contents()%>';
							
				ctl.innerHTML= m;
				
				// ul에 li로 추가
				item.querySelector("ul").appendChild(ctl);

				// title 부분
				item.setAttribute("title", item.querySelector("ul").innerText);			
			} 
		<%}%>   
	}); 
}

// 캘린더 데이터 받아옴 ajax
function ajax_bind(year, month, data) {

		
		let option = {
			url: "/all/cal/${pageId}/calenderJSON.do",
			type: "get",
			dataType: 'json',
			async : false,
			data: {'pageYear': year, 'pageMonth': month },
			success: function (data) {
				try {
					// console.log(data);
					console.log("year : ", year, ", month : ", month);
					
					// 기본 달력 날짜 그려주기
					yoo_drawCalendar(year, month);
					
					//달력에 받아온 ajax 데이터값 넣기 
					yoo_addDataCal_ajax(data);
					
					//오늘 날짜 셀만 표시
					today_mark(year, month);
					
					// 다음달 버튼 눌렀을때
					yoo_click_next_month(year,month);

					// 이전달 버튼 눌렸을 때 
					yoo_click_pre_month(year,month);
					
					// 달력 안에 cell 눌렀을때
					click_cell(data);

				
				} catch (err) {
					console.log("ERR", err);
				}
			},
			error: function (err) { 
				console.log("ERR view click", err);
			},
			complete: function (data) {
				console.log("완료", data);
			}
		}
		$.ajax(option);
		return data;
}
	


//달력에 받아온 ajax 데이터값 넣기 
function yoo_addDataCal_ajax(data) {

	console.log(" data.length : ",data.length);
		
	// cursor_hand : 숫자가표시된 hover 되는 cell만 검색
	document.querySelectorAll(".cursor_hand").forEach(function(item, index){
			
		// todolist 하나씩 꺼내온다
		for(let i = 0; i<data.length; i++){
			//console.log(" data[i].tdl_category : ",data[i].tdl_category, ", i :",i);
			//console.log(" data[i].tdl_date.substring(8,11) : ",data[i].tdl_date.substring(8,11), ", i :",i);
			
			
			// 날짜와 = 클릭가능한 달력 index(0부터)가 같으면 내용 입력
			if(data[i].tdl_date.substring(8,10) == (index-1)) {
				let ctl = document.createElement("li");
				
				// 카테고리 색 바꾸는 부분
				let setCtgColor="green";
				if( data[i].tdl_category=="운동"){setCtgColor="red"; }
				else if( data[i].tdl_category=="식단"){setCtgColor="blueviolet"; }
				
				// 카테고리명과 컨텐츠
				let m = '<a style="color: '+setCtgColor+'; text-decoration: none;">';
					m+= data[i].tdl_category+'</a> ';
					m+= data[i].tdl_contents;
				
				ctl.innerHTML= m;
				
				// ul에 li로 추가
				item.querySelector("ul").appendChild(ctl);

				// title 부분
				item.setAttribute("title", item.querySelector("ul").innerText);			
			}
		}
	}); 
}			
	


// 페이징 select selected 설정
function selected_fn() {

	document.querySelectorAll("select option")[<%=countPerPage%>].setAttribute("selected","selected");
}

// select_line onclick 함수
function select_line_fn(){
	
	let selectLine = document.querySelector("select option:checked").value;
	document.querySelector("#countPerPage").setAttribute("value",selectLine );
	document.select_line_frm.submit();   
}

//오늘 날짜 셀 표시
function today_mark(year, month) {
	let now = new Date();
	
	// 모든 셀에 표시 지우고 시작
	$(".cell").removeClass("today_mark");	
	//console.log(">>> getDate : ", now.getDate());
	
	// 연도, 월이 일치하면 해당컬럼에 표시
	if(year==now.getFullYear()){
		//console.log(">>>year : ", year, ", getFullYear : ", now.getFullYear());
		if(month ==now.getMonth()){
			//console.log(">>>month : ", month, ", getMonth : ", now.getMonth());
			$(".cursor_hand[data-calnum="+ now.getDate()+"]").addClass("today_mark");	
		}
	}
}

//달력 안에 cell 눌렀을때
function click_cell(data){
	// td가 눌렸을때 내용물이 존재하면 2022-11-16 형식으로 돌려준다
	$("td").off("click").on("click",function(){
		console.log( $(this).text()); // day

		
		let clicked_year = $('#yoo_h5_year').text();
		let clicked_month = $('#yoo_h3_cal').text()-1;
		let clicked_date = $(this).attr("data-calnum");
		console.log("clicked_date : ",clicked_date);	
		
		// 값이 있는 cell을 클릭하면
		if($(this).attr("data-calnum")){
			let clickDate = '';
			clickDate += $('#yoo_h5_year').text();
			clickDate += '-'+$('#yoo_h3_cal').text();
			clickDate += '-'+$(this).attr("data-calnum");
			console.log("clickDate : ",clickDate);	
			
			// todo_date에 날짜 채우기
			$("#todo_date").text(clickDate);
			
			
			// document.querySelector("#clickDatehidden").setAttribute("value", clickDate);	//숫자 눌렀을때
			$("#clickDatehidden").attr("value",clickDate );//숫자 눌렀을때

			

 			$(".pageYearhidden").attr("value",$('#yoo_h5_year').text() );// year
			$(".pageMonthhidden").attr("value",($('#yoo_h3_cal').text()-1) );// month
			$(".pageDatehidden").attr("value",clicked_date );// date 
			

//			document.sendPageDateInfo.method = "post";
//			document.sendPageDateInfo.action = "";
//			document.sendPageDateInfo.submit();
	
			// todolist에 값을 채워준다
			filled_todolist_ajax(clicked_year, clicked_month, clicked_date, data  );
		}else{
			
			// todo_date에 날짜 지우기
			$("#todo_date").text('');
			
			// 각 todolist 항목 지우기
			$(".workout").empty();
			$(".food").empty();
		}
		
	});
}

//ajax 값을 todolist에 표시
function filled_todolist_ajax(clicked_year, clicked_month, clicked_date, data ) {

	//console.log("데이터오냐 : "+data);
	clicked_date = String(clicked_date).padStart(2,"0");

	let workout = document.querySelector(".workout");
	let workout_contents ='' ;

	let food = document.querySelector(".food");
	let food_contents ='';
	
	// todolist 하나씩 꺼내온다
	for(let i = 0; i< data.length; i++){
		
		// 날짜와 = 클릭가능한 달력 index(0부터)가 같으면 내용 입력
		if(data[i].tdl_date.substring(8,10) == String(clicked_date).trim()) {
			
			console.log("같음");
			console.log(">>(data[i].tdl_date.substring(8,10) : ", (data[i].tdl_date));
			console.log(">>len : ", (data[i].tdl_date.substring(8,10)).length);
			console.log(">>clicked_date : ",String( clicked_date));
			console.log(">>len : ",String( clicked_date).length);
			
			if( data[i].tdl_category=="운동"){
				workout_contents += '<li class="j_li"><span class="mod_hidden">';
				workout_contents += data[i].tdl_contents+'</span>';
				
				// 내 페이지 라면 표시되게
				if(<%=mypage%>){
	               // 운동 todolist 삭제 form
	               workout_contents += '<form  action="'+ '<%=pageId%>'+'/todoListDel" method="post" class="tdl_del_form" >';
	               workout_contents += '<button type="submit" class="button_del mod_hidden"><img src="/all/resources/calender/img/cancel_icon.png"  class="del_icon"></button>';
	               workout_contents += '<input type="hidden" name="tdl_no" value="'+data[i].tdl_no+'"/>';
	               workout_contents += '<input type="hidden" class="pageYearhidden" name="pageYear" value="'+clicked_year+'"/>';
	               workout_contents += '<input type="hidden" class="pageMonthhidden" name="pageMonth" value="'+clicked_month+'"/>';
	               workout_contents += '<input type="hidden" class="pageDatehidden" name="pageDate" value="'+clicked_date+'"/></form>';
	               
	               // 운동 todolist 수정 form
	               workout_contents += '<form  action="'+ '<%=pageId%>'+'/todoListMod" method="post" class= "tdl_mod_form" onSubmit="return tdl_contents_form(this)">';
	   
	               workout_contents += '<input type="hidden" name="tdl_category" value="운동"/>';
	               workout_contents += '<input type="hidden" name="tdl_no" value="'+data[i].tdl_no+'"/>';
	               workout_contents += '<input type="hidden" class="pageYearhidden" name="pageYear" value="'+clicked_year+'"/>';
	               workout_contents += '<input type="hidden" class="pageMonthhidden" name="pageMonth" value="'+clicked_month+'"/>';
	               workout_contents += '<input type="hidden" class="pageDatehidden" name="pageDate" value="'+clicked_date+'"/>';
	               
	               // 수정하기 버튼
	               workout_contents += '<button type="button" class="button_mod mod_hidden"><img src="/all/resources/calender/img/edit_icon.png" class="mod_icon"></button>';
	               workout_contents += '<input type="text" class="contents_hide contents_hide_text" name="tdl_contents" maxlength="300" value="'+data[i].tdl_contents+'"/>';

	               // 수정 등록 버튼
	               workout_contents += '<button type="submit" class="contents_hide contents_hide_btn"><img src="/all/resources/calender/img/check_icon.png" class="modCheck_icon"></button>';
	                  
	               // 수정 취소 버튼
	               workout_contents += '<button type="button" class="contents_hide contents_hide_btn button_mod_cancle"><img src="/all/resources/calender/img/cancel_icon.png"  class="modCancel_icon"></button></form>';
	             }

			}else if( data[i].tdl_category=="식단"){
				food_contents += '<li class="j_li "><span class="mod_hidden">';
				food_contents += data[i].tdl_contents+'</span>';
				
				// 내 페이지 라면 표시되게
				if(<%=mypage%>){
		               // 식단 todolist 삭제 form
		               food_contents += '<form  action="'+ '<%=pageId%>'+'/todoListDel" method="post" class="tdl_del_form" >';
		               food_contents += '<button type="submit" class="button_del mod_hidden"><img src="/all/resources/calender/img/cancel_icon.png"  class="del_icon"></button>';
		               food_contents += '<input type="hidden" name="tdl_no" value="'+data[i].tdl_no+'"/>';
		               food_contents += '<input type="hidden" class="pageYearhidden" name="pageYear" value="'+clicked_year+'"/>';
		               food_contents += '<input type="hidden" class="pageMonthhidden" name="pageMonth" value="'+clicked_month+'"/>';
		               food_contents += '<input type="hidden" class="pageDatehidden" name="pageDate" value="'+clicked_date+'"/></form>';
		               
		               // 식단 todolist 수정 form
		               food_contents += '<form  action="'+ '<%=pageId%>'+'/todoListMod" method="post" class= "tdl_mod_form" onSubmit="return tdl_contents_form(this)">';
		               
		               food_contents += '<input type="hidden" name="tdl_category" value="식단"/>';
		               food_contents += '<input type="hidden" name="tdl_no" value="'+data[i].tdl_no+'"/>';
		               food_contents += '<input type="hidden" class="pageYearhidden" name="pageYear" value="'+clicked_year+'"/>';
		               food_contents += '<input type="hidden" class="pageMonthhidden" name="pageMonth" value="'+clicked_month+'"/>';
		               food_contents += '<input type="hidden" class="pageDatehidden" name="pageDate" value="'+clicked_date+'"/>';
		               
		               // 수정하기 버튼
		               food_contents += '<button type="button" class="button_mod mod_hidden"><img src="/all/resources/calender/img/edit_icon.png" class="mod_icon"></button>';
		               food_contents += '<input type="text" class="contents_hide contents_hide_text" name="tdl_contents" maxlength="300" value="'+data[i].tdl_contents+'"/>';

		               // 수정 등록 버튼
		               food_contents += '<button type="submit" class="contents_hide contents_hide_btn"><img src="/all/resources/calender/img/check_icon.png" class="modCheck_icon"></button>';
		                  
		               // 수정 취소 버튼
		               food_contents += '<button type="button" class="contents_hide contents_hide_btn button_mod_cancle"><img src="/all/resources/calender/img/cancel_icon.png"  class="modCancel_icon"></button></form>';
		             }
			}
		}
	}
	//workout_contents += '<br></li>';
	//food_contents += '<br></li>';
	console.log("workout : ", workout_contents);
	console.log("food : ", food_contents);
	workout.innerHTML=workout_contents;
	food.innerHTML=food_contents;
	
	
	//>>>>>> 늦게 생성되었기 때문에 todolist 관련 이벤트 붙여줌
	
	// todolist 수정 취소 버튼 눌렸을 때
	update_contents_cancel();

	// todolist 수정 버튼 눌렀을때
	update_contents();

}


function location_weather() {

    navigator.geolocation.getCurrentPosition((position)=>{
        let lat = position.coords.latitude;
        let lon = position.coords.longitude;
        console.log(position);
        console.log("위도",lat);
        console.log("경도",lon);
        
        my_weather(lat, lon);
        my_locate(lat, lon);
        
    })
}

function my_weather(lat, lon) {
	let my_url = 'https://api.openweathermap.org/data/2.5/weather?lang=kr&lat='+lat+'&lon='+lon+'&appid=0c350e82b8f45443bc6f0a6e331e915e';

    $.ajax({
        //url:my_url2,
        //data : JSON.stringify({'lang':'kr', 'lat': lat, 'lon': lon, 'lon': '0c350e82b8f45443bc6f0a6e331e915e'}),
        //type : "post",
        url:my_url,
        data : {},
        type:"get",
        dataType : "json",
        async : false,
        success: function (weatherdata) {
            console.log(weatherdata);
            console.log(weatherdata.name, ':', weatherdata.weather[0].description );
            $("#my_weather").text(weatherdata.weather[0].description);
        },
        error: function (err) { //json 자체가 실패했을떄
            console.log("ERR view click", err);
        }
    })
	
}

function my_locate(lat, lon){
        let geocoder = new kakao.maps.services.Geocoder();

        let coord = new kakao.maps.LatLng(lat, lon);
        let callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                // console.log(result);
                $("#my_loacation").text(result[0].address.region_2depth_name+result[0].address.region_3depth_name);
                console.log(result[0].address.region_2depth_name+result[0].address.region_3depth_name);
            }
        }
        geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
}

</script>
<%
e_MemberDTO sessionUser = new e_MemberDTO();
	sessionUser = (e_MemberDTO)session.getAttribute("user");
%>	
	<div id="j_wrap">
	
		<!-- 내용 표시 div(하얀색) -->
		<div id="j_box">
		
			<!-- 프로필, 응원메세지, 회원목록(친구찾기) div -->
			<div id="yoo_pro_chr_find_obj">
			
				<!-- 프로필 div -->
				<div id="yoo_profile_obj">
					 
					<% CalPageMbDTO calPageMbDTO = (CalPageMbDTO)request.getAttribute("calPageMbDTO"); %>
					<!-- 프로필 사진 -->
					<img class="pro_img" src="/all/cal/pro_img.do?fileName=<%=calPageMbDTO.getPro_img() %>" >
					<br>
					<!-- 닉네임 표시 -->
					<strong><%=calPageMbDTO.getNickname()%> </strong> 님의<br> 페이지입니다
				</div>
				
				<!-- 응원 메세지 div -->
				<div id="yoo_chr_obj">
				
					<!-- 응원메세지 입력창과 버튼 --> 
					<form name="cheerMsgAdd_frm" action="<%=pageId%>/cheerMsgAdd" enctype="utf-8" method="post" onSubmit="return click_CheerMsgAdd(this)">
						<div id="yoo_chr_input_btn">
							<input id="yoo_chr_input" name="CHR_MSG" type="text" placeholder="응원메세지 남기기! 300자까지 입력 가능합니다!! " maxlength="300"><input id="yoo_chr_btn" type="submit" value="입력" >
							<input type="hidden" name="command" value="cheerMsgAdd" />
							<input type="hidden" name="CHR_PARENTS_NO" value="0" />
						</div>
					</form>
							
					<!--응원메세지 출력창-->
					<div id="yoo_chr_view">
						<% List<CheerMsgDTO> cheerMsglist = (ArrayList)chrPagingMap.get("list"); %>
						
						<% CheerMsgDTO cheerMsgDTO = new CheerMsgDTO();
						
	                    for(int i =0 ; i < cheerMsglist.size() ; i++){ %>

	                    	<!-- 응원메세지 1줄 div -->
							<div class='yoo_chr_msg'>
								<% cheerMsgDTO = (CheerMsgDTO)cheerMsglist.get(i);%>
								<!-- DEPTH -->
								<% // 대댓글 댓글 표현을 위한 여백 
								for( int depth=0; depth<(cheerMsgDTO.getDepth()-1)*2; depth++) {%>	
								&nbsp;
								<%} 
									if(cheerMsgDTO.getDepth()>1){%>
									ㄴ
									<% }%>
								<!--  메세지 내용이 null이 아니면 내용 표시 -->	
								<% if(cheerMsgDTO.getChr_msg() !=null){%>
								<!-- 글쓴이 -->
								<a href='  <%=cheerMsgDTO.getId() %>' style="color: gray; text-decoration: none;"> 
									<%=cheerMsgDTO.getNickname() %>
								</a>
								<!-- 메세지 -->
								<%=cheerMsgDTO.getChr_msg() %>
								<!--  메세지 내용이 null이면 삭제된 메세지로 표시 -->	
								<%}else{ %>
								삭제된 메세지 입니다
							<%} %>
							</div>
							<!-- 응원메세지 지우기 버튼 (내 페이지일 경우 또는 글쓴이)-->
							<% if(mypage || (sessionUser.getMember_no()==cheerMsgDTO.getFr_member_no()) ){ %>
								<!-- 지우기 버튼 눌렸을때 form -->
								<form method="post" action="<%=pageId%>/cheerMsgDel" encType="utf-8" class="chr_del_form">
									<input class='yoo_chr_view_del_btn del_chr' type='submit' value='지우기'>
									<input type="hidden" name="CHR_NO" value="<%= cheerMsgDTO.getChr_no()%>" />
									<input type="hidden" name="command" value="cheerMsgDel" />
								</form>
							<% } %>
							<!-- 응원메세지 댓글달기 버튼 ( 대댓글은 depth 4까지만 허용)-->
							<% if(cheerMsgDTO.getDepth()<4){%>
							<input class="chr_rpl_btn" type='button' value='댓글달기'>
							<%} %>
							<br>
							<!-- 응원 메세지 댓글 입력 -->
							<form class="chr_rpl_form" name="chr_rpl_form"  action="<%=pageId%>/cheerMsgAdd" enctype="utf-8" method="post" onSubmit="return click_CheerMsgAdd(this)" >
								ㄴ><input type="text" class="chl_rpl_input" name="CHR_MSG" maxlength="300">
								<input class='rpl_chr_btn ' type='submit' value='댓글입력' >
								<input type="hidden" name="command" value="cheerMsgAdd" />
								<input type="hidden" name="CHR_PARENTS_NO" value="<%=cheerMsgDTO.getChr_no() %>" />
							</form>
						<% } %>
						
						<!-- 댓글이 없을시 정렬이 깨져서 띄어쓰기 하나 넣음 -->
						<%if(cheerMsglist.size()==0){%>
							&nbsp;
						<% } %>
						
					</div>

					<!-- 페이징 번호 div -->
					<div id="chr_paging_div">
						<form id="select_line_frm" name="select_line_frm" action="" method="get" >
						<span style="font-size: 12px;"> 전체 댓글 개수 : ${chrPagingMap.count} </span>
							<select name="select_line" onchange="select_line_fn();" >
								<option value="0">2 줄 보기</option>
								<option value="1">3 줄 보기</option>
								<option value="2">4 줄 보기</option>
								<option value="3">5 줄 보기</option>
							</select>
							<input type="hidden" name="countPerPage" id="countPerPage" >
						</form>
						<div id="page_num_div" >
							<c:if test="<%=firstNo !=1 %>">
								<a class="paging_a" href="<%=uri%>?pageNum=<%=firstNo -1 %>&countPerPage=<%=countPerPage %>" style=" font-weight: bold;" > << </a> &nbsp;
							</c:if>
							
							<c:forEach var = "i" begin="<%=firstNo %>" end="<%=lastNo %>"> 
							
								<c:if test="${chrPagingMap.pageNum eq i }" >
									<a class="paging_a" href="<%=uri%>?pageNum=${i}&countPerPage=<%=countPerPage %>" style="color:#14279B; font-weight: bold; font-size: 23px;" > ${i } </a> &nbsp;
								</c:if>
								<c:if test="${ not (chrPagingMap.pageNum eq i) }" >
									<a class="paging_a" href="<%=uri%>?pageNum=${i}&countPerPage=<%=countPerPage %>"> ${i } </a> &nbsp;
								</c:if>
							</c:forEach>
						
							<c:if test="<%=lastNo !=lastPage %>">
								<a class="paging_a" href="<%=uri%>?pageNum=<%=lastNo +1 %>&countPerPage=<%=countPerPage %>" style=" font-weight: bold;" > >> </a> &nbsp;
							</c:if>
						</div>
					</div>

				</div>
				
				
				
				<!-- id로 친구 검색 div -->
				<div id="yoo_find_obj">
					<div id="yoo_find_input_btn"> 
						<form name="member" method="post" action="<%=pageId%>/searchUser" id="yoo_find_input_btn_frm"  onSubmit="return find_form(this)">
							<input id="yoo_find_input" type="text" placeholder="Id를 입력하세요"name="serchID" maxlength="9"><input id="yoo_find_btn" type="submit" value="입력" > 
	               			<input type="hidden" class="pageYearhidden" name="pageYear" value="<%=year%>"/> 
							<input type="hidden" class="pageMonthhidden" name="pageMonth" value="<%=month%>" /> 
							<input type="hidden" class="pageDatehidden" name="pageDate" value="<%=date%>" /> 
	               		</form>
	                </div>
	                
	                
	                <!-- 친구 검색 view -->
	            	<div id="yoo_find_view">
	            		<% 
	                	List<CalSearchMbDTO> serchMemberlist = (ArrayList<CalSearchMbDTO>)new ArrayList();
							if(request.getAttribute("serchMemberlist")!=null){
								serchMemberlist = (ArrayList<CalSearchMbDTO>)request.getAttribute("serchMemberlist");
									for(int i=0; i<serchMemberlist.size(); i++){
										CalSearchMbDTO vo = new CalSearchMbDTO();
										vo = serchMemberlist.get(i);
						%>
						
									<%if(vo.getId() ==null) {%>
										<p> 검색한 회원이 없습니다.</p>
									<% }else{%>
					            		<p><a href='<%=vo.getId() %>' style="color: gray; text-decoration: none;"> 
				                           <%=vo.getNickname() %></a>(<%=vo.getId() %>)</p>
				        <%				}
									}
								}
						%>
	            	</div> 
				</div>	
				   
			</div>
			
			<hr>
			
			<!-- 달력 div -->
			<div id="yoo_cal_obj">
				<div id=weather_div>
					<span id ="my_loacation"></span> 현재 <span id ="my_weather"></span>
				</div>
				<!-- 년, 월 표시 div -->
				<div id="disp_year_month">
					
					<!-- 연도 표시부 h5 -->
					<h5 id="yoo_h5_year"></h5>
					
					<br>
					
					<!-- 이전달 -->
					<input type="button" value=" << 이전달 " id="pre_month" class="cursor_hand">
					
					<!-- 여백 -->
					&nbsp&nbsp
					
					<!-- 월 표시 h3 -->
					<h3 id="yoo_h3_cal"></h3>
					
					<!-- 여백 -->
					&nbsp&nbsp
					
					<!-- 다음달 -->
					<input type="button" value=" 다음달 >> " id="next_month" class="cursor_hand">

					<!-- 이전달, 다음달 눌렀을때 전송되는 년,월,일 form -->
					<form name="sendPageDateInfo">
						<input type="hidden" name="pageYear" class="pageYearhidden" /> 
						<input type="hidden" name="pageMonth" class="pageMonthhidden" /> 
						<input type="hidden" name="pageDate" class="pageDatehidden" /> 
						<input type="hidden" name="tdl_date" class="clickDatehidden" />
					</form>
				</div>

				<!-- 달력 table -->
				<table id="yoo_Calendar">
				
					<thead>
						<tr>
							<th>일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th>토</th>
						</tr>
					</thead>
					
					<!-- 달력 숫자 표시부 cell -->
					<tbody id="yoo_tbody">
					
					<% for(int i=1; i<7; i++){ %>
						<tr id="yoo_tr_0<%=i%>">
						
						<% for(int j=0; j<7; j++){ %>
							<td class="cell"></td>
						<%} %>
					<%} %>
						
					</tbody>
				</table>
				
			</div>

			<!-- todolist 부분 -->
			<div class="j_todolist_wrap" >
				
				
				<!-- todolist 받아온다 -->
				<% List<TodoListDTO> todoListlist = (ArrayList)request.getAttribute("todoListlist"); %>
				
				<!-- todolist 날짜표시 -->
				<h2 id="todo_date" class="todo_margin" ></h2>
				
				<!-- 운동 -->
				<div id="j_workout" class="j_name todo_margin">
					운동
				</div>
				
				<!-- 운동 todolist list -->	
				
				<ul class = "j_ul workout todo_margin">
				
		    		<% for(int i=0; i<todoListlist.size(); i++){ %>
		    			<c:set var="i2" value="<%=i %>"/>
		    			
		    			<!--  if 카테고리 운동 -->
		    			<c:if test = "${ todoListlist[i2].tdl_category == '운동' }" >
		    			
		    				<!-- li : tdl_contents -->
			    			<li class="j_li "><span class="mod_hidden">${todoListlist[i2].tdl_contents}</span>
			    			
			    			<!--  내 페이지라면 지우기, 수정 버튼 보이게 -->
			    			<% if(mypage){ %>
			    			
			    				<!-- 운동 todolist 지우기 form -->
				    			<form  action="<%=pageId%>/todoListDel" method="post" class="tdl_del_form" >
				    				<!-- 삭제 버튼 -->
					    			<button type="submit" class="button_del mod_hidden"><img src="/all/resources/calender/img/cancel_icon.png"  class="del_icon"></button>
					    			<input type="hidden" name="tdl_no" value="${todoListlist[i2].tdl_no }"/>
					    			<input type="hidden" name="pageYear" value="<%=year%>"/> 
									<input type="hidden" name="pageMonth" value="<%=month%>" /> 
									<input type="hidden" name="pageDate" value="<%=date%>" /> 
				    			</form>	
						
								<!-- 운동 todolist 수정 form -->
						    	<form  action="<%=pageId%>/todoListMod" method="post" class= "tdl_mod_form" onSubmit="return tdl_contents_form(this)">
						    		<input type="hidden" name="tdl_no" value="${todoListlist[i2].tdl_no }"/>
						    		<input type="hidden" name="tdl_category" value="운동"/>
						    		<input type="hidden" name="pageYear" value="<%=year%>"/> 
									<input type="hidden" name="pageMonth" value="<%=month%>" /> 
									<input type="hidden" name="pageDate" value="<%=date%>" /> 
									
						    		<!-- 수정하기 버튼 -->
						    		<button type="button" class="button_mod mod_hidden"><img src="/all/resources/calender/img/edit_icon.png" class="mod_icon"></button>
						    		<input type="text" class="contents_hide contents_hide_text" name="tdl_contents" value="${todoListlist[i2].tdl_contents }" maxlength="300"/>
                   					<!-- 수정 등록 버튼 -->
                   					<button type="submit" class="contents_hide contents_hide_btn"><img src="/all/resources/calender/img/check_icon.png" class="modCheck_icon"></button>
						    		<!-- 수정 취소 버튼 -->
						    		<button type="button" class="contents_hide contents_hide_btn button_mod_cancle"><img src="/all/resources/calender/img/cancel_icon.png"  class="modCancel_icon"></button>
					    		</form>	
							<% } %> 
			    			<br>
			    			</li>
		    			</c:if>
		    			
		    		<% } %>
				</ul>
				
				<!-- 내 페이지라면 todolist 등록 버튼 보이게 -->
				<% if(mypage){ %>
				<form  action="<%=pageId%>/todoListAdd" class="todo_margin" method="post" onSubmit="return tdl_contents_form(this)">	
				    <input type="text" id="j_msg1"  name="tdl_contents" maxlength="300">
				    <input type="submit" id="j_app1" value="등록">
				    <input type="hidden" name="tdl_category" value="운동"/>
				    <input type="hidden" class="pageYearhidden" name="pageYear" value="<%=year%>"/> 
					<input type="hidden" class="pageMonthhidden" name="pageMonth" value="<%=month%>" /> 
					<input type="hidden" class="pageDatehidden" name="pageDate" value="<%=date%>" /> 
				</form>	
				<%} %>
				
				<!--/////////////////////////////////////////// -->
				
				<!-- 식단 -->
	    		<div id="j_food" class="j_name todo_margin">
		    		식단
	    		</div>
	    		
	    		<!-- 식단 todolist list -->		
				<ul class = "j_ul food todo_margin">
				
		    		<% for(int i=0; i<todoListlist.size(); i++){ %>
		    			<c:set var="i2" value="<%=i %>"/>
		    			
		    			<!--  if 카테고리 식단 -->
		    			<c:if test = "${ todoListlist[i2].tdl_category == '식단' }" >
		    			
		    				<!-- li : tdl_contents -->
			    			<li class="j_li"><span class="mod_hidden">${todoListlist[i2].tdl_contents }</span>
			    			
			    			<!--  내 페이지라면 지우기, 수정 버튼 보이게 -->
			    			<% if(mypage){ %>
			    			
			    				<!-- 식단 todolist 지우기 form -->
				    			<form  action="<%=pageId%>/todoListDel" method="post" class="tdl_del_form" >
				    				<!-- 삭제 버튼 -->
					    			<button type="submit" class="button_del mod_hidden"><img src="/all/resources/calender/img/cancel_icon.png"  class="del_icon"></button>
					    			<input type="hidden" name="tdl_no" value="${todoListlist[i2].tdl_no }"/>
					    			<input type="hidden" class="pageYearhidden" name="pageYear" value="<%=year%>"/> 
									<input type="hidden" class="pageMonthhidden" name="pageMonth" value="<%=month%>" /> 
									<input type="hidden" class="pageDatehidden" name="pageDate" value="<%=date%>" /> 
				    			</form>	
						
								<!-- 식단 todolist 수정 form -->
						    	<form  action="<%=pageId%>/todoListMod" method="post" class= "tdl_mod_form" onSubmit="return tdl_contents_form(this)">
						    		<input type="hidden" name="tdl_no" value="${todoListlist[i2].tdl_no }"/>
						    		<input type="hidden" name="tdl_category" value="식단"/>
						    		<input type="hidden" class="pageYearhidden" name="pageYear" value="<%=year%>"/> 
									<input type="hidden" class="pageMonthhidden" name="pageMonth" value="<%=month%>" /> 
									<input type="hidden" class="pageDatehidden" name="pageDate" value="<%=date%>" /> 
									
									<!-- 수정하기 버튼  --> 
						    		<button type="button" class="button_mod mod_hidden"><img src="/all/resources/calender/img/edit_icon.png" class="mod_icon"></button>
						    		<input type="text" class="contents_hide contents_hide_text" name="tdl_contents" value="${todoListlist[i2].tdl_contents }" maxlength="300"/>
                   					<!-- 수정 등록 버튼 -->
                   					<button type="submit" class="contents_hide contents_hide_btn"><img src="/all/resources/calender/img/check_icon.png" class="modCheck_icon"></button>
						    		<!-- 수정 취소 버튼 -->
						    		<button type="button" class="contents_hide contents_hide_btn button_mod_cancle"><img src="/all/resources/calender/img/cancel_icon.png"  class="modCancel_icon"></button>
					    		</form>	
							<% } %> 
			    			<br>
			    			</li>
		    			</c:if>
		    			
		    		<% } %>
				</ul>
	   			
	   			<!-- 내 페이지라면 todolist 등록 버튼 보이게 -->
				<% if(mypage){ %>
				<!-- todolist 식단 등록 -->
				<form  action="<%=pageId%>/todoListAdd" class="todo_margin" method="post" onSubmit="return tdl_contents_form(this)">	
				    <input type="text"  id="j_msg1" name="tdl_contents" maxlength="300">
				    <input type="submit" id="j_app1" value="등록">
				    <input type="hidden" name="tdl_category" value="식단"/>
				    <input type="hidden"  class="pageYearhidden xxxy" name="pageYear" value="<%=year%>"/> 
					<input type="hidden"  class="pageMonthhidden xxxm" name="pageMonth" value="<%=month%>" /> 
					<input type="hidden" class="pageDatehidden xxxd" name="pageDate" value="<%=date%>" /> 

					
				</form>	
				<%} %>
			</div>
		</div>
	</div>