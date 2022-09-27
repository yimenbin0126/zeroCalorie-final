<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="eunbin.DTO.e_MemberDTO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="/all/resources/service/css/allService.css" rel="stylesheet">
    <link href="/all/resources/service/css/header.css" rel="stylesheet">
    <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>

	<!-- 헤더 시작 -->
    <div id="j_hi">
        <!-- <img src="./img/logo.png" id="j_logo"> -->

		<%
       		e_MemberDTO m_dto = new e_MemberDTO();
        		
        	// 로그인 유무
           	if((e_MemberDTO)session.getAttribute("user") !=null){
           		m_dto = (e_MemberDTO)session.getAttribute("user");
        %>
		<ul id="j_list">
            <li class="j_menu1 j_menu" onclick="location.href='/all/cal/<%=m_dto.getId()%>'">캘린더</li>
            <li class="j_menu2 j_menu" onclick="location.href='/all/community/listArticles.do'">커뮤니티</li>
            <li class="j_menu3 j_menu">공지사항</li>
            <li class="j_menu5 j_menu" onclick="location.href='/all/service/allService'">고객센터</li>
        </ul>
        <div id = e_nav>
        	<div id="e_welcome">
        		<%=m_dto.getNickname()%>님 환영합니다.
        	</div>
        	<form name="e_nav_btn">
	        	<input type ="hidden" name="e_logout" value="Y">                   
        	</form>
        	<!-- null 오류 방지용 시작 -->
        	<input type ='hidden' class = "j_btn1 j_btn" onclick="location.href='/all/login'" value="로그인">
            <input type ='hidden' class = "j_btn2 j_btn" onclick="location.href='/all/join'" value="회원가입">
            <!-- null 오류 방지용 끝 -->
            <!-- 나타나는 부분 시작 -->
            <input type ='button' class = "e_btn e_btn" onclick="location.href='/all/logout'" value="로그아웃">
            <input type ='button' class = "e_btn2 e_btn" onclick="location.href='/all/mypage'" value="마이페이지">
            <!-- 나타나는 부분 끝 -->
        </div>
        <%
        	} else {
        %>
        <ul id="j_list">
            <li class="j_menu1 j_menu" onclick="location.href='/all/cal/<%=m_dto.getId()%>'">캘린더</li>
            <li class="j_menu2 j_menu" onclick="location.href='/all/community/listArticles.do'">커뮤니티</li>
            <li class="j_menu3 j_menu">공지사항</li>
            <li class="j_menu5 j_menu" onclick="location.href='/all/service/allService'">고객센터</li>
        </ul>
        <div id = j_nav>
        	<!-- null 오류 방지용 시작 -->
            <input type ='hidden' class = "e_btn e_btn" onclick="location.href='/all/logout'" value="로그아웃">
            <input type ='hidden' class = "e_btn2 e_btn" onclick="location.href='/all/mypage'" value="마이페이지">               
            <!-- null 오류 방지용 끝 -->
            <!-- 나타나는 부분 시작 -->
            <input type ='button' class = "j_btn1 j_btn" onclick="location.href='/all/login'" value="로그인">
            <input type ='button' class = "j_btn2 j_btn" onclick="location.href='/all/join'" value="회원가입">
            <!-- 나타나는 부분 끝 -->
        </div>
        <%
        	}
        %>
    </div>
    <!-- 헤더 끝 -->

	<section>
		<div id="j_wrap">
			<div id="j_box">
				
				<div class="e_div">
					<!-- 카데고리 -->
					<nav class="e_nav">
						<!-- 문의 전체보기 -->
						<div class="e_nav_all" onclick="location.href='/all/service/allService'">
							<span>문의 전체보기</span>
							<img src="">
						</div>
						<!-- 자주하는 질문 -->
						<div class="e_nav_question" onclick="location.href='/all/service/question-member'">자주하는 질문</div>
						<!-- 1:1 문의 -->
						<div class="e_nav_onebyone" onclick="location.href='/all/service/oneByone'">1:1 문의</div>
					</nav>
	
					<!-- 오른쪽 카데고리 -->
					<div class="e_content">
						<div class="e_ct_header">고객센터 &gt; 문의 전체보기</div>
						<div class="e_ct_top">
							<h4>문의 유형</h4>
							<p>문의 유형을 선택하거나,</p>
							<p>왼쪽의 카데고리를 클릭하면</p>
							<p>해당 페이지로 이동이 가능합니다.</p>
						</div>
	
						<div class="e_ct_middle">
							<div class="e_question">
								<div class="e_que_title" onclick="location.href='/all/service/question-member'">
									<div>자주하는 질문</div>
								</div>
								<p class="e_que_content">
									자주하는 질문 설명<br> 자주하는 질문 설명<br> 자주하는 질문 설명<br>
								</p>
							</div>
							<div class="e_onebyone">
								<div class="e_one_title" onclick="location.href='/all/service/oneByone'">1:1 문의</div>
								<p class="e_one_content">
									1:1 문의 설명<br> 1:1 문의 설명<br> 1:1 문의 설명<br>
								</p>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>

</body>
</html>