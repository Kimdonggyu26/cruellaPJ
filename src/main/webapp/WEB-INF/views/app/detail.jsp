<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${ contextPath }/assets/"
  data-template="views"
  data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="${ contextPath }/resources/assets/js/config.js"></script>
    
   
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.0.272/jspdf.debug.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.js"></script>

    
</head>
<body>

<style>
#app_active::before {
	content: ''; /* 가상 요소 필수 */
	display: inline-block; /* 블록 요소 */
	width: 10px; /* 동그라미 크기 */
	height: 10px; /* 동그라미 크기 */
	border-radius: 50%; /* 완전한 원 */
	background-color: transparent; /* 배경을 투명으로 설정 */
	border: 2px solid gray; /* 초기 테두리 색상 */
}

#app_active.active::before {
	border: 2px solid white; /* 테두리만 흰색으로 변경 */
}

* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
}

.app_type {
	width: 298px;
	height: 100px;
	text-align: center;
	font-size: 30px;
	font-weight: 800;
	border: 1px solid black;
}

.app_line_div {
	display: flex;
	justify-content: right;
	border: 1px solid black;
	padding-bottom: 2px;
}

.line_title {
	position: relative;
	writing-mode: vertical-rl;
	height: 147px;
	text-align: center;
	border: 1px solid black;
}

.line_user {
	display: flex;
	flex-direction: column;
	text-align: center;
	width: 100px;
}

.line_user span {
	border: 1px solid black;
}

.signLine {
	height: 102px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.line_div {
	width: 600px;
}

.app_table_container {
	border-spacing: 0;
	height: 40px;
}

.dept_td, .app_date, .app_no, .app_title_td {
	width: 110px;
	border: 1px solid black;
}

.dept_td_result, .app_date_result {
	width: 188px;
	border: 1px solid black;
}

.app_no_result {
	width: 192px;
	border: 1px solid black;
}

.app_result_div {
	text-align: center;
}

.app_title {
	border: 1px solid black;
}

.sign_date {
	height: 23px;
}

.date-range {
	display: flex;
	align-items: center;
}

.start-date, .end-date {
	padding: 8px;
	margin: 0 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

.date-separator {
	font-size: 16px;
	margin: 0 10px;
}

.date-difference {
	font-size: 14px;
	margin-left: 10px;
}

.date-difference b {
	color: #e74c3c;
}
</style>





	<div class="layout-wrapper layout-content-navbar">
   <div class="layout-container">
   
   
    <!-- 헤더 시작 -->
      <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- 헤더 끝 -->
    
      <div class="layout-page">

    <!-- nav 시작 -->
      <jsp:include page="/WEB-INF/views/common/nav.jsp" />
      <!-- nav 끗 -->


        <!-- Session Start -->
        <div class="content-wrapper" style="height: 1500px;">
          <div class="container-xxl flex-grow-1 container-p-y">

            

            





            <!-- 양식영역 -->
            
            		<div style="display: flex; justify-content: left;">
            			<span style=""><button type="button"  id="backBtn" class="btn btn-primary" onclick="historyBack();">목록</button></span>
            			    <c:if test="${app.docStatus eq 'A' and app.memNo eq memNo}">
	            				<span style="position: relative; left: 89%;">
	            					<button type="button"  id="delect_Btn" class="btn btn-danger" >회수</button>
	            				</span>
	            			</c:if>
	            			<c:if test="${app.docStatus eq 'C' and app.memNo eq memNo}">
	            				<span style="position: relative; left: 89%; cursor: pointer;" onclick="pdf_down();">
	            					<!-- <button type="button"  onclick="ff();" class="btn btn-success" >다운받기</button> -->
	            					<img src="${contextPath}/resources/assets/img/free-icon-pdf-5453995.png"
	            					     style="width: 38px;"/>
	            				</span>
	            			</c:if>
            			
            		</div>
            		
            	
                    
                      
                      
                        <!-- 반려 모달 -->

						<div class="modal" id="myModal">
							<div class="modal-dialog" style="top: 235px;">
								<div class="modal-content">

									<!-- Modal Header -->
									<div class="modal-header">
										<span><h4 class="modal-title">반려메세지</h4></span>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal"></button>
									</div>

									<!-- Modal body -->
									<div class="modal-body">
									<!-- 반려메세지 입력창 -->
										<input type="text" class="form-control"
											placeholder="반려메세지를 입력해주세요."
											aria-describedby="defaultFormControlHelp" id="reason_result" name="reason"/>
									</div>

									<!-- Modal footer -->
									<div class="modal-footer">
									
										<button type="button" class="btn btn-success" id="success_btn"
											>확인</button>
											
										<button type="button" class="btn btn-danger"
											data-bs-dismiss="modal">취소</button>
									</div>

								</div>
							</div>
						</div>
						<!-- /반려모달 -->
						
						





				<div class="col-12" style="margin-top: 20px;" id="content_div">
                  <div class="card mb-6">



                    <table class="app_table_container">
                      <thead>
                        <tr>
                          <td class="app_type">
                          	<span id="form_type_result">
                          		<c:choose>
                          			<c:when test="${app.docType eq '기안서' }">
                          				기&nbsp;&nbsp;안&nbsp;&nbsp;서
                          			</c:when>
                          			<c:when test="${app.docType eq '품의서' }">
                          				품&nbsp;&nbsp;의&nbsp;&nbsp;서
                          			</c:when>
                          			<c:when test="${app.docType eq '연차신청서' }">
                          				연&nbsp;&nbsp;차&nbsp;&nbsp;신&nbsp;&nbsp;청&nbsp;&nbsp;서
                          			</c:when>
                          			<c:when test="${app.docType eq '증명서신청서' }">
                          				증&nbsp;&nbsp;명&nbsp;&nbsp;서&nbsp;&nbsp;신&nbsp;&nbsp;청&nbsp;&nbsp;서
                          			</c:when>
                          			<c:when test="${app.docType eq '지각사유서' }">
                          				지&nbsp;&nbsp;각&nbsp;&nbsp;/&nbsp;&nbsp;불&nbsp;&nbsp;참&nbsp;&nbsp;사유서
                          			</c:when>
                          			<c:when test="${app.docType eq '요청서' }">
                          				요&nbsp;&nbsp;청&nbsp;&nbsp;서
                          			</c:when>
                          		</c:choose>
                          	
                          	</span>
                          </td>
                          <td class="line_div">
                            <span class="app_line_div">

							
                              <span class="line_title">
                              <b>결재선</b>
                              <input type="hidden" id="maxOrder"  value="${app.maxOrder }"> <!-- 기안문서의 최종결재순서 -->
                              <input type="hidden" id="docOrder"  value="${app.docOrder }"> <!-- 기안문서의 결재순서 -->
                              
                              </span>
                              
                              
                              
                              <c:forEach var="a" items="${app.rovalList}">
                              
                              <span class="line_user">
                                <span>${a.deptName}</span>
                                <span class="signLine">
                                
                                
                                <c:choose>
                                	<c:when test="${ a.appStatus ne 'A' }">
			                               <!-- 현재 결재자(a)가 결재를 한 상태일 경우  -->
			                               <c:choose>
			                               	<c:when test="${ a.appStatus eq 'N'}">
			                               		<b style="color:red;">반려</b>
			                               	</c:when>
			                               	<c:otherwise>
			                               		<img class="signImg_div" src="data:image/png;base64,${ a.signPath }" style="width: 100px; height: 100px;">
			                               	</c:otherwise>
			                               </c:choose>
			                               
                                	</c:when>
                                	<c:when test="${ a.rvNo eq memNo }">
                                		<!-- 현재 결재자(a)가 결재를 안했는데 그게 나일 경우 -->
                                		<img class="signImg_div" style="display:none;width: 100px; height: 100px;">
		                 				<input type="hidden" id="app_roval_level"  value="${a.appLevel}"> <!-- 결재자순서 -->
		                             	<button type="button" class="signbtn_div btn btn-dark">서명</button>
                                	</c:when>
                                	<c:otherwise>
		                                <!-- 현재 결재자(a)가 결재를 안했는데 그게 다른 사람일 경우 -->		                             	
		                             	서명
                 					</c:otherwise>
                 				</c:choose>
                 				
                 				
                                
                                </span>
                                <span class="sign_date">${a.memName}</span>
                              </span>
                              
                              </c:forEach>
                              
                              


                            </span>
                          </td>
                        </tr>
                      </thead>
                    </table>

                    <!-- db 조회해서 담기 -->
                    <table class="app_table_container">
                      <tr class="app_result_div">
                        <td class="dept_td">기안부서</td>
                        <td class="dept_td_result">${app.deptName }</td>
                        <td class="app_date">직급</td>
                        <td class="app_date_result">${app.posName }</td>
                        <td class="app_no">기안일</td>
                        <td class="app_no_result">${app.docDt }</td>
                        
                 
                        
                      </tr>
                    </table>
                   

                    <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">기안자</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black; ">
                          <span style="position: relative; left: 10px;" id="userNo_value" >
                          	<input type="hidden" id="doc_no_result" value="${app.docNo}">
                          </span>
                          <span id="ref_list_div" style="position: relative; left: 8px;">${app.memName }</span>
                        </td>
                      </tr>
                    </table>
                    
                    
                    <c:if test="${app.docType eq '증명서신청서' }">
                    <!-- 증명서일때 -->
                    <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">발행날짜</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black; ">

                          <span class="date-range" style="position: relative;left: 10px;">
                            
                          </span>
                        

                        </td>
                      </tr>
                    </table>
                    <!-- /증명서일때 -->
                    </c:if>
                    
                    
                    <c:if test="${app.docType eq '연차신청서' }">
                    <!-- 연차신청서일때 -->
                    <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">휴가종류</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black; ">
                          <span style="position: relative; left: 10px;">연차</span>
                        </td>
                      </tr>
                    </table>
                    
                    
                    
                     <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">기간 및 일시</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black; ">
							<span style="position: relative; left: 12px;">
								${app.appDateStart } ~ ${app.appDateEnd }
							</span>
                          
                        </td>
                      </tr>
                    </table>
                    <!-- /연차신청서일때 -->
                    </c:if>
                    
                    
                    <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">제목</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black;">
                          <span style="position: relative;left: 12px;">${app.docTitle }</span>
                            
                          <!-- 제목글자수 제한 조건을 걸거나 아니면 리스트 조회시 보이는 글자수 제한 걸기 -->
                        </td>
                      </tr>
                    </table>
                    
                    
                <c:if test="${app.docType eq '지각사유서' }">    
                 <table>
                  <tr>
                   <td style="border: 1px solid black;width: 169px; text-align: center;">사유</td>
                   <td>
				</c:if>
				
                    <div style="border: 1px solid black;">
                      <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                          <div class="row">

                            <!-- Full Editor -->
                            <div class="col-12">
                              <div class="card">

                                <div class="card-body" style="height: 500px;">
		
									${app.docContent } 
									<br>
									<br>
									<span style="color:red;">${app.reason}</span>

                                </div>
                              </div>
                            </div>
                            <!-- /Full Editor -->
                          </div>
                        </div>
                      </div>
                    </div>
                    
                    
                 <c:if test="${app.docType eq '지각사유서' }">  
                   </td>
                 </tr>
           	   </table>
                </c:if> 
                    
                    
                    
              
                    

                    <!-- file input -->
                    <div class="card" style="border: 1px solid; border-radius: 0;">
                      <h5 class="card-header"></h5>
                      <div class="card-body">
                        <div class="mb-4">
                        <!-- 파일 -->
                        
                     <div class="btn-group">
                      <button
                        type="button"
                        class="btn btn-outline-secondary dropdown-toggle"
                        data-bs-toggle="dropdown"
                        aria-expanded="false">
                        첨부파일(${app.attachCount})
                      </button>
                      
                      
                      <c:choose>
                      <c:when test="${app.attachCount == 0 }">
                      
                      <ul class="dropdown-menu" style="display:none;">
                        
                       <c:forEach var="a" items="${app.attachList}">
                       	  <li>
		                      <a href="${contextPath}${a.filePath}/${a.filesystemName}"  download="${a.originalName}">
		                        ${a.originalName}
		                       </a>
		                       <br>
		                 </li>      
		               </c:forEach>
                      </ul>
                      
                     </c:when>
                     <c:otherwise>
                     
                     <ul class="dropdown-menu" id="dropdown-menu">
                        
                       <c:forEach var="a" items="${app.attachList}">
                       	  <li>
		                      <a href="${contextPath}${a.filePath}/${a.filesystemName}"  download="${a.originalName}">
		                        ${a.originalName}
		                       </a>
		                       <br>
		                 </li>      
		               </c:forEach>
                      </ul>
                     
                     </c:otherwise>
                     </c:choose>
                      
                    </div>
                    
                   
                    
                   
                 
                          
                        </div>

                      </div>
                    </div>
                    <!-- /file input -->
					<input type="hidden" name="docContent" id="docContentInput" />
					
					


          </div>
        </div>
        <!-- /session -->


        <!-- </div> -->
        <!-- /레이아웃 컨테이너 -->


        <!-- </div> -->


        <!-- </div> -->


<script>
	
$(document).ready(function(){
	
	 var count = 0;
	
	
 // 전자서명 
	  $('.signbtn_div').on('click', function(){
	        
	        const signData = '${loginUser.signPath}';
	        const sign = signData ? 'data:image/png;base64,' + signData : '';
	       
	        
	        if(sign == '' || sign == null){
	        	$(this).closest('.line_user')
	             .find('.signLine').html('${loginUser.memName}');
	        
	        }else{
	        	$(this).closest('.line_user')
	             .find('.signImg_div')
	             .css('display', 'block') 
	             .attr('src', sign); 
	        }
	        
	        	$(this).remove();
	        
	        
	       count++;
	       
	    }); 
	    
	
	  

 // 뒤로가기
	  function historyBack(){
			    history.back();
	  }
 
 $('#backBtn').on('click',function(){
			 historyBack();
 })
 
 
 
 
 
 $('#last_sign_success').on('click',function(){ // 결재 버튼
	 
	
	 const signData = '${loginUser.signPath}';
	 const imgSrc = signData ? 'data:image/png;base64,' + signData : '';
	 

	 if (count == 0){ 
	   alert('서명을 해주세요')
	   
	 }else{
		 
		 if(confirm('결재 하시겠습니까?')){
			 
		   $.ajax({
			   url: '${contextPath}/app/ajaxSuccess.do',
			   type: 'POST',
			      contentType: 'application/json', 
			      data:JSON.stringify({
			        signPath: imgSrc, // 전자서명 이미지경로
			        docNo: parseInt($('#doc_no_result').val(), 10), // 문서번호
			        maxOrder: parseInt($('#maxOrder').val(), 10),  // 결재선 최종 순서 
			        docOrder: parseInt($('#docOrder').val(), 10),  // 결재선 현재 순서 
			        appLevel: parseInt($('#app_roval_level').val(), 10),  // 현재 결재자의 순서 
			      	memNo: '${memNo}',
			      	appDateStart : '${app.appDateStart }',
			      	appDateEnd : '${app.appDateEnd }',
			      	docType : '${app.docType}',
			      	docMemNo : '${app.memNo}'
			      	
			      }),
			   success: function(res){
				   	if(res>0){
				   		alert('성공적으로 결재하였습니다');
				   		location.href = '${contextPath}/app/box_main.do';
				   		
				   	}
			   }
		   })
		   
		 }
	   
	 }
	 
	 
 })
 
 
 
 
 
 $('#success_btn').on('click',function(){ // 반려버튼
	 
	 
		if($('#reason_result').val() == ""){
			alert('반려메세지를 입력해주세요')
									
		}else{
			
			if(confirm('반려하시겠습니까?')){
				
			$.ajax({
				url: '${contextPath}/app/ajaxCompanion.do',
				type: 'POST',
				contentType: 'application/json',
				data : JSON.stringify({
						reason : $('#reason_result').val(),
						memNo: '${memNo}',
						docNo: parseInt($('#doc_no_result').val(), 10)
					}),
				success:function(res){
						if(res>0){
							$('#myModal').modal('hide'); 
							alert('성공적으로 반려하였습니다');
							location.href = '${contextPath}/app/box_main.do';
												
						}
					}
			})
		}
									
									
		}
	})
	
	
	
	/* 회수버튼 클릭시 */
		$('#delect_Btn').on('click',function(){
            	if(confirm("기안서를 회수 하시겠습니까?")){
            		$.ajax({
            		url: '${contextPath}/app/ajaxAppDeleteBack.do',
            		type: 'POST',
            		data:{
            			  docNo : $('#doc_no_result').val()
            			},
            		success:function(res){
            			if(res>0){
            				alert('기안서를 회수하였습니다');
            				location.href = '${contextPath}/app/box_main.do';
            									
            				}
            			}
            							
            		})
            	}
         })
	  
	  
	
})


	// pdf 다운 함수
function pdf_down() {
	
		$('#dropdown-menu').css('display','none');	
	
	   const element = document.getElementById('content_div');  // PDF로 변환할 요소
	    
	    const options = {
	        margin:       10,    // 여백
	        filename:     '${app.docType}.pdf', // 파일 이름
	        image:        { type: 'jpeg', quality: 0.98 },
	        html2canvas:  { scale: 1 },   // 해상도 설정
	        jsPDF:        { unit: 'mm', format: 'a3', orientation: 'portrait' }
	    };

	    // html2pdf 라이브러리를 사용하여 선택한 요소를 PDF로 변환
	    html2pdf()
	        .from(element)   // PDF로 변환할 요소
	        .set(options)     // 옵션 설정
	        .save();          // PDF 파일 저장
  }



</script>









   


     
<c:forEach var="i" items="${app.rovalList }">
<c:if test="${ i.rvNo eq memNo}">
 <div style="display: flex; justify-content: right;">
             			
        <button type="button" class="btn btn-warning" id="last_sign_fail" data-bs-toggle="modal" data-bs-target="#myModal">반려</button>
        <span style="width: 52px;"></span>
        <button type="button" class="btn btn-success" id="last_sign_success">결재</button>
                        
  </div>
</c:if>
</c:forEach>


	<style>
		.content-footer {
			position: relative;
	    	top: 310px;
		}
		
		
	
	</style>
	
	
	
	
	   <script>
     // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
		const element = document.getElementById("app_box_active");
			
	  	document.getElementById("app_main_active").classList.add("open");
	  	element.style.backgroundColor = "#958CF4";
	  	element.style.color = "white";
	  	element.classList.add("active");
	  	
	  	
		});
        
        
        </script>


   <!-- 푸터 시작 -->
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   <!-- 푸터 끝 -->
   
   <div class="content-backdrop fade"></div>
   <!-- wrapper 닫기 -->
   </div>
   
   <!-- nav layout page 닫기 -->
   </div>
   
   <!-- layout-container 닫기 -->
   </div>
     <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>

    <!-- Drag Target Area To SlideIn Menu On Small Screens -->
    <div class="drag-target"></div>
   
   
   <!-- layout wrapper 닫기 -->
   </div>
   
   
 
  
   



   
   
</body>
</html>