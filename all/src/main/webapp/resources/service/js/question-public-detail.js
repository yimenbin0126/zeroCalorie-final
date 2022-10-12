window.onload = function(){
	form();
	btn();
}

// 뷰 데이터 전달
function form(){
	// 좋아요 버튼 누를시
	// 좋아요 X -> 좋아요 누르기
	document.querySelector('#e_like_heart_n img').addEventListener('click', (event)=>{
		$.ajax({
	        url: "/all/service/question-public-detail",
	        type:"POST",
	        data: {
	            e_heart_check : "like_Y",
	            e_bno : document.querySelector('#e_bno_value').value
	        },
	        success : function(data){
	        	// 객체 값 가져오기
	        	// 하트 칠하기
	        	document.querySelector('#e_like_heart_n').style.display = "none";
	        	document.querySelector('#e_like_heart_y').style.display = "block";
	        	// 숫자 증가
	        	var heart_num = document.querySelector('.e_like_num').innerText;
	        	document.querySelector('.e_like_num').innerText = parseInt(heart_num) + 1;
	        },
	        });
	});
	
	// 좋아요 O -> 좋아요 누르기
	document.querySelector('#e_like_heart_y img').addEventListener('click', (event)=>{
		$.ajax({
	        url: "/all/service/question-public-detail",
	        type:"POST",
	        data: {
	            e_heart_check : "like_N",
	            e_bno : document.querySelector('#e_bno_value').value
	        },
	        success : function(data){
	        	// 하트 칠하기
	        	document.querySelector('#e_like_heart_n').style.display = "block";
	        	document.querySelector('#e_like_heart_y').style.display = "none";
	        	// 숫자 감소
	        	var heart_num = document.querySelector('.e_like_num').innerText;
	        	document.querySelector('.e_like_num').innerText = parseInt(heart_num) - 1;
	        },
	        });
	});
	
	// 싫어요 버튼 누를시
	// 싫어요 X -> 싫어요 누르기
	document.querySelector('#e_dislike_heart_n img').addEventListener('click', (event)=>{
		$.ajax({
	        url: "/all/service/question-public-detail",
	        type:"POST",
	        data: {
	            e_heart_check : "dislike_Y",
	            e_bno : document.querySelector('#e_bno_value').value
	        },
	        success : function(data){
	        	// 객체 값 가져오기
	        	// 하트 칠하기
	        	document.querySelector('#e_dislike_heart_n').style.display = "none";
	        	document.querySelector('#e_dislike_heart_y').style.display = "block";
	        	// 숫자 증가
	        	var heart_num = document.querySelector('.e_dislike_num').innerText;
	        	document.querySelector('.e_dislike_num').innerText = parseInt(heart_num) + 1;
	        },
	        });
	});
	
	// 싫어요 O -> 싫어요 누르기
	document.querySelector('#e_dislike_heart_y img').addEventListener('click', (event)=>{
		$.ajax({
	        url: "/all/service/question-public-detail",
	        type:"POST",
	        data: {
	            e_heart_check : "dislike_N",
	            e_bno : document.querySelector('#e_bno_value').value
	        },
	        success : function(data){
	        	// 하트 칠하기
	        	document.querySelector('#e_dislike_heart_n').style.display = "block";
	        	document.querySelector('#e_dislike_heart_y').style.display = "none";
	        	// 숫자 감소
	        	var heart_num = document.querySelector('.e_dislike_num').innerText;
	        	document.querySelector('.e_dislike_num').innerText = parseInt(heart_num) - 1;
	        },
	     });
	});
}

function btn(){	
	console.log("드러옴");
	// 버튼 클릭
	// 글 답글 쓰기 버튼
	document.querySelector('#e_btn_reply').addEventListener('click', (event)=>{
		var e_btn_reply_form = document.e_btn_reply_form;
		var con_reply = confirm('정말 답글을 작성하시겠습니까?');
		if (con_reply == true) {
			e_btn_reply_form.method="get";
			e_btn_reply_form.action="/all/service/question-public-detail-button";
			e_btn_reply_form.submit();
		} else {
			event.preventDefault();
		}
	});

	// 글 수정 버튼
	document.querySelector('#e_btn_fix').addEventListener('click', (event)=>{
		var e_btn_fix_form = document.e_btn_fix_form;
		var con_fix = confirm('정말 글을 수정하시겠습니까?');
		if (con_fix == true) {
			e_btn_fix_form.method="get";
			e_btn_fix_form.action="/all/service/question-public-detail-button";
			e_btn_fix_form.submit();
		} else {
			event.preventDefault();
		}
	});

	// 글 삭제 버튼
	document.querySelector('#e_btn_delete').addEventListener('click', (event)=>{
		var e_btn_delete_form = document.e_btn_delete_form;
		var con_del = confirm('정말 글을 삭제하시겠습니까?');
		if (con_del == true) {
			e_btn_delete_form.method="get";
			e_btn_delete_form.action="/all/service/question-public-detail-button";
			e_btn_delete_form.submit();
		} else {
			event.preventDefault();
		}
	});
	
}