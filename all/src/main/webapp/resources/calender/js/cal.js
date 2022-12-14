
// 기본 달력 날짜 그려주기
function yoo_drawCalendar(year, month) {
	
	let now = new Date();
	
	// 시작요일 
    let monthStartDay = new Date(year, month, 1);
    let start_day = monthStartDay.getDay();
    
    // 월 날짜 갯수
    let month_count = new Date(year,month+1, 0);
    month_count= month_count.getDate();
    
    console.log("::::시작요일 : ", start_day, ", 월 날짜 갯수 : ", month_count);
    
    let j=1; // 주
    let k=1;
    let m = month_count+1;
    //let m = (month[now.getMonth()])+1   // 이번달의 날짜 수

    // 이전에 그렸던거 지우고 시작함 
    $(".cell").empty();
    
    // 이전에 셀 속성 손모양 지우고 시작함
    $(".cell").removeClass("cursor_hand");
    
    // 이전에 data-calnum 지우고 시작함
    $(".cell").removeAttr("data-calnum");


    // 현재 달 표시
    document.querySelector("#yoo_h3_cal").innerHTML=(month+1);
    document.querySelector("#yoo_h5_year").innerHTML=year;
    
    //첫주
    for(let i=start_day; i <7; i++){
       
        let h_date = document.createElement("h3");
        h_date.setAttribute("class", "yoo_td_h3");
        h_date.innerHTML=k;
        
        // 날짜 있는칸만 손모양 주고 싶어서 속성 추가해줌
        document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].classList.add("cursor_hand");
        // 날짜 그려줌
        document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].appendChild(h_date);
        // 속성 추가해줌
        document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].setAttribute("data-calnum", k);
        // 내용물 쓸 ul 추가해줌
        document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].appendChild(document.createElement("ul"));
        k++;
	}
		
	// 6th줄 지울건지 계산
	if(((month_count-k)/7)<4){
		console.log("ksdjfl");
		document.querySelector("#yoo_tr_06").classList.add("hide");
	}else{
		document.querySelector("#yoo_tr_06").classList.remove("hide");
	}
      
	// 월[이번달]+1  
    while(k<m){ 
        j++;
        for( let i=0; i <7; i++ ){
			// tr의 td 들 안에 <h3> 생성
            let h_date = document.createElement("h3"); 
            h_date.setAttribute("class", "yoo_td_h3");
            h_date.innerHTML=k;

			// 날짜 있는칸만 손모양 주고 싶어서 속성 추가해줌
        	document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].classList.add("cursor_hand");
        	// 날짜 그려줌
        	document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].appendChild(h_date);
        	// 속성 추가해줌
        	document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].setAttribute("data-calnum", k);
        	// 내용물 쓸 ul 추가해줌
        	document.getElementsByTagName("tr")[j].getElementsByTagName("td")[i].appendChild(document.createElement("ul"));
        	k++;
        
            if(!(k<m)){
				break;
			}
        }
        
        if(!(k<m)){
			break;
        }
	}
}

 // 응원메세지 표시 함수
/*function fn_yoo_chr_view(){   
	document.querySelector("#yoo_chr_btn").addEventListener("click",function(){
	let val = document.querySelector("#yoo_chr_input").value;

	let ms = document.querySelector("#yoo_chr_view");
	//let html="";                  // 1줄만 나옴
	let html=ms.innerHTML;       // 여러줄 하고싶을때 (but 전체 다시 그리는 비효율적 방법)
		html +="<div class='yoo_chr_msg'>";
		html +="        "+ val;
		html +="</div><input class='yoo_chr_view_del_btn' type='submit' value='지우기'><br>";
		ms.innerHTML = html; // .innerHTML : 덮어쓰기 기능
	});
}*/



// todolist 등록, 수정시 input text 관리 
function tdl_contents_form(form){
	// VARCHAR2(1000) 라서 편의상 한글로 계산 300자 제한
	let Max_length = 300; 

	// 날짜가 선택되지 않았으면 경고메세지
	if($("#todo_date").text() ==""){
		alert('입력을 원하는 날짜를 선택해주세요');
			 return false;
	}
	// 입력창의 내용이 비었으면 경고 메세지
	else if(form.tdl_contents.value ==""){
		 alert(' todolist 내용을 입력해주세요');
		 return false;
	}
	// 글자수 제한해서 받기 (Max_length)
	else if(form.tdl_contents.value.length > Max_length){
		alert(' 300자 이하로 적어주세요');
		 return false;
	
	// 그렇지 않을경우 입력 전달
	}else{
		return true;
	}	
}

// todolist 수정 버튼 눌렀을때
function update_contents(){
	$(".button_mod").off("click").on("click",function(){
	
		// 기존컨텐츠와 수정버튼 숨김 
		$(this).parent().parent().find(".mod_hidden").hide();
		// 입력창과 수정등록과 수정취소 버튼 보임
		$(this).parent().find(".contents_hide").show();

	});	
}

// todolist 수정 취소 버튼 눌렸을 때
function update_contents_cancel(){
	$(".button_mod_cancle").off("click").on("click",function(){
      
      	// 기존컨텐츠와 수정버튼 보임
		$(this).parent().parent().find(".mod_hidden").show();
		// 입력창과 수정등록과 수정취소 버튼 숨김
		$(this).parent().find(".contents_hide").hide();
      
	});
}


// 댓글 달기 버튼 눌렀을때
function click_rpl_chr_btn(){
	$(".chr_rpl_btn").off("click").on("click",function(){


		// 모든 댓글달기 버튼 보이게
		$(".chr_rpl_btn").show();
		// 모든 댓글 입력 폼 숨기게
		$(".chr_rpl_form").hide();
		
		// 댓글달기 버튼 누른 칸의 기존컨텐츠와 댓글 달기 버튼 숨김 
		$(this).hide();

		// 댓글달기 버튼 누른 칸의 입력창과 댓글 입력 폼 보임
		$(this).next().next().show();
	});
}

// 응원메세지 입력 버튼 눌렀을 때 input text 관리 
function click_CheerMsgAdd(form){
	// VARCHAR2(1000) 라서 편의상 한글로 계산 300자 제한
	let Max_length = 300; 
	
/*	// 입력창의 내용이 비었으면 경고 메세지
	if(document.querySelector("#yoo_chr_input").value ==""){
		 alert(' 응원 메세지 내용을 입력해주세요');
		 return false;
	// 그렇지 않을경우 입력 전달
	}else{
		return true;
	}	*/
	
	// 입력창의 내용이 비었으면 경고 메세지
	if(form.CHR_MSG.value ==""){
		 alert(' 응원 메세지 내용을 입력해주세요');
		 return false;
	}
	// 글자수 제한해서 받기 (Max_length)
	else if(form.CHR_MSG.value.length > Max_length){
		alert(' 300자 이하로 적어주세요');
		 return false;
	
	// 그렇지 않을경우 입력 전달
	}else{
		return true;
	}	
}


function find_form(form){
	// id 최대글자수가 9라서
	let Max_length = 9; 
	
	// id 검색시 영문소문자와 숫자만 받았었음
	let pattern = /^[0-9a-z]*$/;	
	
	
	// 입력창의 내용이 비었으면 경고 메세지
	if(! pattern.test(form.yoo_find_input.value)){
		 alert(' 숫자 또는 영문소문자만 입력해 주세요 ');
		 return false;
	}
	// 글자수 제한해서 받기 (Max_length)
	else if(form.yoo_find_input.value.length > Max_length){
		alert(Max_length+'자 이하로 적어주세요');
		 return false;
	
	// 그렇지 않을경우 입력 전달
	}else{
	 		$(".pageYearhidden").attr("value",$('#yoo_h5_year').text() );// year
			$(".pageMonthhidden").attr("value",($('#yoo_h3_cal').text()-1) );// month
			$(".pageDatehidden").attr("value",clicked_date );// date 
		return true;
	}	
}