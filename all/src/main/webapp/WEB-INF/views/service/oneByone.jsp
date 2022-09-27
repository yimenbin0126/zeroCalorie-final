<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="eunbin.DAO.e_MemberDAO,eunbin.DTO.e_MemberDTO,eunbin.DAO.e_ServiceDAO,eunbin.DTO.e_ServiceDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" href="/all/resources/service/css/header.css">
<link rel="stylesheet" href="/all/resources/service/css/oneByone.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>

<body>

	<!-- 헤더 시작 -->
    <div id="j_hi">
        <!-- <img src="./img/logo.png" id="j_logo"> -->

		<%
		// 데이터 불러오기 위한 선언
		e_MemberDTO m_dto = new e_MemberDTO();

		// 로그인 유무
		if ((e_MemberDTO) session.getAttribute("user") != null) {
			m_dto = (e_MemberDTO) session.getAttribute("user");
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
					<!-- 왼쪽 카데고리 -->
					<nav class="e_nav">
						<!-- 문의 전체보기 -->
						<div class="e_nav_all" onclick="location.href='/all/service/allService'">
							문의 전체보기
						</div>
						<!-- 자주하는 질문 -->
						<div class="e_nav_question" onclick="location.href='/all/service/question-member'">
							자주하는 질문
						</div>
						<!-- 1:1 문의 -->
						<div class="e_nav_onebyone" onclick="location.href='/all/service/oneByone'">
							<div class="e_one_div">1:1 문의</div>
							<div><img src="/all/resources/service/img/category_click.png"></div>
						</div>
					</nav>

					<!-- 오른쪽 내용 -->
					<div class="e_right">
						<!-- 상단 -->
						<div class="e_hd_top">고객센터 &gt; 1:1 문의 &gt; 1:1 문의하기</div>
						<div class="e_header">
							<div class="e_hd_top_que">1:1 문의</div>
							<div class="e_hd_top_con">
								<span> 설명설명설명설명설명설명<br> 설명설명설명설명설명설명<br>
									설명설명설명설명설명설명
								</span>
							</div>
							<div>
								<button class="e_hd_top_btn">1:1 문의하기</button>
							</div>
						</div>

						<!-- 1:1 문의 내역 -->
						<div class="e_content">
							<div class="e_con_title">문의 내역</div>
							<div class="e_con_mem">
								<ul>
									<li>번호</li>
									<li>제목</li>
									<li>작성시간</li>
									<li>상태</li>
								</ul>
								<ul class="e_boardlist">
									<li>333</li>
									<li>글 제목을 수정학 ㅗ싶어요</li>
									<li>2022-01-22</li>
									<li>대기</li>
								</ul>
								<ul class="e_boardlist">
									<li>333</li>
									<li>글 제목을 수정학 ㅗ싶어요ddddddddd</li>
									<li>작성시간</li>
									<li>완료</li>
								</ul>
							</div>

						</div>

						<div class="e_paging">
							<div class="e_paging_btnleft">&lt;</div>
							<div class="e_paging_num">
								<div id="bno1">1</div>
							</div>
							<div class="e_paging_btnright">&gt;</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>

</body>
</html>