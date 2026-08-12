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
    
   <style>
   	textarea{
  		width: 400px;
  		height: 290px;
  		border: 2px solid transparent;
      outline: none; 
      resize: none !important;
   	}
   	#memoList{
   	 background-color: #e9e7fd;
   	 border-radius: 5px;
   	 }
   	#memoList > span{
   	 width: 340px;
   	 height: 23px;
   	 cursor: pointer;
   	 overflow: hidden;
   	 }
   	 #memoDiv{
   	 height: 280px;
   	 margin-top: 15px;
   	 overflow-y: scroll;
   	 }
   	 #teamListDiv{
   	 max-height: 300px;
   	 overflow-y: scroll;
   	 }
		 #memoDiv::-webkit-scrollbar,
		 #teamListDiv::-webkit-scrollbar {
		  width: 10px;  /* 세로 스크롤바의 너비 */
		  height: 8px; /* 가로 스크롤바의 높이 */
		 }
		
		 #memoDiv::-webkit-scrollbar-track,
		 #teamListDiv::-webkit-scrollbar-track {
		  background-color: #f1f1f1; /* 트랙 배경색 */
		  border-radius: 10px; /* 트랙 모서리 둥글게 */
		 }
		
			/* 스크롤바의 손잡이 (사용자가 드래그할 부분) */
			#memoDiv::-webkit-scrollbar-thumb,
			#teamListDiv::-webkit-scrollbar-thumb {
		    background-color: #7367f0; /* 손잡이 색 */
		    border-radius: 10px;     /* 손잡이 모서리 둥글게 */
		    border: 2px solid #f1f1f1; /* 손잡이의 테두리 색 (트랙과 구분됨) */
		}
			/* 스크롤바 손잡이 위에 마우스를 올렸을 때 */
			#memoDiv::-webkit-scrollbar-thumb:hover,
			#teamListDiv::-webkit-scrollbar-thumb:hover {
		    background-color: #564EB5; /* 손잡이 색을 다르게 */
		}
		.selected{
			color: #7367f0;
		}
		#searchSelect{
			width: 110px;
			height: 38px !important;
			min-height: 38px !important;
			font-size: 16px !important;
			padding-top: 0.3rem !important;
			padding-right: 1rem !important;
			padding-bottom: calc(38px - 1rem - 16px) !important;
			padding-left: 1rem !important;
			box-sizing: border-box;
		}
		#board{
			cursor: pointer;
			color: #444050;
		}
		#board:hover{
			color: #7367f0;
			transition: color 0.3s ease;
		}
		#side_myinfo::before {
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#side_myinfo.active::before {
		  border: 2px solid white; /* 테두리만 흰색으로 변경 */
		}
		#standby_box:hover {
			background-color: #f0f0f0;
		}
		#progress_box:hover {
			background-color: #f0f0f0;
		}
		#complete_box:hover {
		 background-color: #f0f0f0;
		}
		#memoList {
			margin-right: 10px;
		}
	  .title {
	  	max-width: 400px;
	  	overflow: hidden;
	  	text-overflow: ellipsis;
	  	white-space: nowrap;
	  }
   </style>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
   <div class="layout-container">
   
   
    <!-- 헤더 시작 -->
      <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- 헤더 끝 -->
    
      <div class="layout-page">

    <!-- nav 시작 -->
      <jsp:include page="/WEB-INF/views/common/nav.jsp" />
    <!-- nav 끝 -->


   <div class="content-wrapper">
   <!-- 세션 시작 -->
            <div class="container-xxl flex-grow-1 container-p-y">
              <!-- Header -->
              <div class="row">
                <div class="col-12">
                  <div class="card mb-6">
                    <div class="user-profile-header-banner">
                      <img src="${ contextPath }/assets/img/pages/profile-banner.png"alt="Banner image" class="rounded-top" style="width: 1392px;"/>
                    </div>
                    <div class="user-profile-header d-flex flex-column flex-lg-row text-sm-start text-center mb-5">
                      <div class="flex-shrink-0 mt-n2 mx-sm-0 mx-auto">
                        <img style="width: 100px; height: 100px;"
                          src="${ contextPath }<c:out value='${ loginUser.profileURL }'
                          default='/assets/img/default_profile.png' />"
                          alt="user image"
                          class="d-block h-auto ms-0 ms-sm-6 rounded user-profile-img" />
                      </div>
                      <div class="flex-grow-1 mt-3 mt-lg-5">
                        <div
                          class="d-flex align-items-md-end align-items-sm-start align-items-center justify-content-md-between justify-content-start mx-5 flex-md-row flex-column gap-4">
                          <div class="user-profile-info">
                            <h4 class="mb-2 mt-lg-6">${ loginUser.getMemName() }</h4>
                            <ul
                              class="list-inline mb-0 d-flex align-items-center flex-wrap justify-content-sm-start justify-content-center gap-4 my-2">
                              <li class="list-inline-item d-flex gap-2 align-items-center">
                                <i class="ti ti-book ti-lg"></i><span class="fw-medium">${ loginUser.getDeptName() }</span>
                              </li>
                              <li class="list-inline-item d-flex gap-2 align-items-center">
                                <i class="ti ti-mail ti-lg"></i><span class="fw-medium">${ loginUser.getEmail() }</span>
                              </li>
                              <li class="list-inline-item d-flex gap-2 align-items-center">
                                <i class="ti ti-calendar ti-lg"></i><span class="fw-medium">${ loginUser.getHireDate() }</span>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!--/ Header -->

              <!-- Navbar pills -->
              <div class="row">
                <div class="col-md-12">
                  <div class="nav-align-top">
                    <ul class="nav nav-pills flex-column flex-sm-row mb-6 gap-2 gap-lg-0">
                      <li class="nav-item">
                        <a class="nav-link active" href="javascript:void(0);">
                          <i class="ti-sm ti ti-user-check me-1_5"></i> 내 정보
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="${contextPath}/member/myinfo_workLog.do">
                        	<i class="ti-sm ti ti-users me-1_5"></i> 근태관리
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <!--/ Navbar pills -->

              <!-- User Profile Content -->
              <div class="row">
                <div class="col-xl-4 col-lg-5 col-md-5">
                  <!-- About User -->
                  <div class="card mb-6">
                    <div class="card-body">
                      <small class="card-text text-uppercase text-muted small">내 정보</small>
                      <ul class="list-unstyled my-3 py-1">
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-user ti-lg"></i><span class="fw-medium mx-2">이름:</span>
                          <span>${ loginUser.getMemName() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-briefcase ti-lg"></i><span class="fw-medium mx-2">부서:</span>
                          <span>${ loginUser.getDeptName() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-tag ti-lg"></i><span class="fw-medium mx-2">직급:</span>
                          <span>${ loginUser.getPosName() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-calendar ti-lg"></i><span class="fw-medium mx-2">입사일:</span> <span>${ loginUser.getHireDate() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-lock ti-lg"></i><span class="fw-medium mx-2">주민등록번호:</span>
                          <span>${ loginUser.getMemSSN() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-phone-call ti-lg"></i><span class="fw-medium mx-2">전화번호:</span>
                          <span>${ loginUser.getPhone() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-building ti-lg"></i><span class="fw-medium mx-2">사번:</span>
                          <span>${ loginUser.getMemNo() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-mail ti-lg"></i><span class="fw-medium mx-2">이메일:</span>
                          <span>${ loginUser.getEmail() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-home ti-lg"></i><span class="fw-medium mx-2">주소:</span>
                          <span>${ loginUser.getAddress() }</span>
                        </li>
                        <li class="d-flex align-items-center mb-4">
                          <i class="ti ti-coin ti-lg"></i><span class="fw-medium mx-2">계좌번호:</span>
                          <span>${ loginUser.getAccount() }</span>
                        </li>
                      </ul>
                    </div>
                  </div>

                  <!--/ About User -->
                  
                  <!-- 메모목록 -->
                  <div class="card mb-6" style="height: 420px;">
                    <div class="card-body">
                      <small class="card-text text-uppercase text-muted small">Memo</small> 
                      <i class="ti ti-edit ti-sm" style="margin-left: 310px; cursor: pointer;" onclick="fnOpenMemoModal();"></i>
                      <div id="memoDiv"></div>
                    </div>
                  </div>
                  
                  <!-- 메모등록 모달 -->
	                  <div class="modal fade" id="insertMemoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	                    <div class="modal-dialog">
	                        <div class="modal-content" style="width: 450px; height: 450px;">
	                            <div class="modal-header" style="background-color: #CEC9FF;">
	                                <h5 class="modal-title" id="exampleModalLabel" style="color: white; margin-bottom: 12px;">Memo</h5>
	                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                            </div>
	                            <div class="modal-body">
	                               <textarea id="insertMemoInput" name="memoContent"></textarea>
	                            </div>
	                            <div class="modal-footer justify-content-center">
	                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btn_memo_insert" onclick="fnInsertMemo();">등록</button>
	                                <button type="button" class="btn btn-primary" id="btn_memo_cancel" data-bs-dismiss="modal">취소</button>
	                            </div>
	                        </div>
	                    </div>
	                  </div>
                  
                  <!-- 메모 조회 및 수정 모달 -->
                  <input type="hidden" name="memoNo" id="modifyMemoNo" value="">
	                  <div class="modal fade" id="selectMemoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	                    <div class="modal-dialog">
	                        <div class="modal-content" style="width: 450px; height: 450px;">
	                            <div class="modal-header" style="background-color: #CEC9FF;">
	                                <h5 class="modal-title" id="exampleModalLabel" style="color: white; margin-bottom: 12px;">Memo</h5>
	                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                            </div>
	                            <div class="modal-body">
	                               <textarea id="insertMemoInput_edit" name="memoContent"></textarea>
	                            </div>
	                            <div class="modal-footer justify-content-center">
	                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btn_memo_insert" onclick="fnModifyMemo();">수정</button>
	                                <button type="button" class="btn btn-primary" id="btn_memo_cancel" data-bs-dismiss="modal">취소</button>
	                            </div>
	                        </div>
	                    </div>
	                  </div>
									

                  <!-- 전자서명 등록영역 -->
                  <div class="card mb-6">
                    <div class="card-body">
                      <div style="display: flex;">
                        <span><h2>나의 서명</h2></span>
                        <span style="position: relative; left: 145px;">
                          <div class="col-lg-4 col-md-6">
                            <small class="text-light fw-medium"></small>
                            <div class="mt-4">
                              <!-- Button trigger modal -->
                              <button
                                type="button"
                                class="btn btn-primary"
                                data-bs-toggle="modal"
                                data-bs-target="#basicModal" style="width: 75px;">
                                등록
                              </button>
      
                              <!-- Modal -->
                              <div class="modal fade" id="basicModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                  <div class="modal-content" style="top: 150px;">
                                    <div class="modal-header">
                                      <h5 class="modal-title" id="exampleModalLabel1">서명작성</h5>
                                      <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                      <div class="row">
                                        <div class="col mb-4">

                                          <!-- 서명 그리는 영역 -->
                                          <canvas id="canvas" width="515" height="400" style="border: 3px solid #000;"></canvas>

                                        </div>
                                      </div>
                                     
                                    </div>
                                    <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        닫기
                                      </button>
                                      <button type="button" class="btn btn-danger" id="clear_btn">
                                        초기화
                                      </button>
                                      <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="sign_save_btn">저장</button>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </span>

                      </div>

                      <!-- 서명이 메인에 보일 영역 -->
                      <div style="height: 322px; width: 100%; border: 1px solid;">
                        <img id="sign_image" alt="" style="max-width: 100%; max-height: 100%; object-fit: contain;" />  
                        <!-- object-fit: contain; : 비율은 유지하되 이미지가 왜곡되지 않게 하는 속성 -->
                      </div>




                    </div>
                  </div>

	<!-- 전자서명 스크립트 -->
	<script>
         
		// 전자서명 영역에 기존에 등록된 서명 보이게
		function fnLoadSign(){
			
			const signPath = '${loginUser.getSignPath()}';
			if (signPath) {
				$('#sign_image').attr('src', 'data:image/png;base64,' + signPath);
			}
			
		}
	
		$(document).ready(function(){
			
			const canvas = document.getElementById("canvas");
			const context = canvas.getContext("2d");  
			let drawing = false; // 서명 그리는 동안 -> true

			
			// 서명 작성 시작
			$('#canvas').on('mousedown',function(){
				drawing = true;
				context.beginPath();
			});

			// 서명 작성 진행
			$('#canvas').on('mousemove',function(event){
			  
				if(!drawing) return; // 마우스 클릭을 뗐을때 그리기 종료
				
				const x = event.clientX - canvas.getBoundingClientRect().left;
				const y = event.clientY - canvas.getBoundingClientRect().top;
				context.lineTo(x,y);
				context.stroke();
			
			});

			// 서명 작성 종료
			$('#canvas').on('mouseup',function(){
			  
				drawing = false;
				context.closePath();
			
			});

			// 초기화버튼 클릭시
			$('#clear_btn').on('click',function(){
				context.clearRect(0, 0, canvas.width, canvas.height);
			});

	    // 저장버튼 클릭시
			$('#sign_save_btn').on('click',function(){
			 
				const signPath = canvas.toDataURL();	// 캔버스의 내용 -> 데이터URL(이미지데이터를 Base64로 인코딩한 문자)로 변환
				
			  
			  
			  $.ajax({
			  	url: '${contextPath}/member/saveSign.do',
			  	type: 'POST',
			  	data: {
					signPath: signPath
			  		},
			  	success: function(res){
			  		
			  		if(res == 'YYY'){
				   		alert('전자서명이 등록되었습니다.');
				
						$('#sign_image').attr('src', signPath);
			   		
			  		}else{
			   			alert('전자서명 등록에 실패했습니다. 다시 시도해주세요.');
			   		
			  		}
			  	}
			  })
			  
			});
             
             
	  })
	</script>
	
  <!-- 전자서명 스크립트 -->  

                  <!--/ Profile Overview -->
                </div>

                <div class="col-xl-8 col-lg-7 col-md-7">
                  <!-- Activity Timeline -->
                  <!-- 팀게시판 영역 (재운님 코드)-->
                  <div class="row">
                    <!-- 나의 소속팀 목록 -->
                    <div class="col-lg-12 col-xl-6" >
                      <div class="card card-action mb-6" style="height: 400px;">
                        <div class="card-header align-items-center">
                          <i class="ti ti-users ti-lg"></i>
                          <h5 class="card-action-title mb-0" style="margin-left: 15px;">${ loginUser.getDeptName() }</h5> <!-- 나의 소속팀이 보이게 -->
                        </div>
                        <div class="card-body"> <!-- 나의 소속팀 전체 리스트 조회 영역 -->
                        	<div id="teamListDiv">
                        	</div>
                        </div>
                      </div>
                    </div>
                    <!--/ 나의 소속팀 목록 -->
                    <!-- 나의 결재 문서함 -->
                    <div class="col-lg-12 col-xl-6">
                      <div class="card card-action mb-6">
                        <div class="card-header align-items-center">
                          <i class="ti ti-file-search ti-lg"></i>
                          <h5 class="card-action-title mb-0" style="margin-left: 15px;">내 결재 문서함</h5>
                        </div>
                        <div class="card-body">
                          <div id="standby_box" style="width: 320px; height: 100px; margin-left: 20px; border-bottom: 1px solid #CDCCCE; display: flex; gap: 45px; cursor: pointer;"
                           onclick="location.href='${contextPath}/app/box_standby.do'">
                            <div>
                              <img src="${ contextPath }/assets/img/customizer/wlblue.png"
                                  style="width: 70px; height: 70px; margin-top: 10px;"/>
                            </div>
                            <div style="margin-top: 35px;">
                              <span style="font-size: 20px;">결재 대기함</span>
                              <span style="font-size: 20px; margin-left: 24px;" id="app_standby"></span>
                            </div>
                          </div>
                          <div id="progress_box" style="width: 320px; height: 100px; margin-left: 20px; border-bottom: 1px solid #CDCCCE; display: flex; gap: 45px; cursor: pointer;"
                           onclick="location.href='${contextPath}/app/box_progress.do'">
                            <div>
                              <img src="${ contextPath }/assets/img/customizer/wlgray.png"
                                  style="width: 70px; height: 70px; margin-top: 10px;"/>
                            </div>
                            <div style="margin-top: 35px;">
                              <span style="font-size: 20px;">결재 진행함</span>
                              <span style="font-size: 20px; margin-left: 20px;" id="app_progress"></span>
                            </div>
                          </div>
                          <div id="complete_box" style="width: 320px; height: 100px; margin-left: 20px; display: flex; gap: 45px; cursor: pointer;"
                           onclick="location.href='${contextPath}/app/box_complete.do'">
                            <div>
                              <img src="${ contextPath }/assets/img/customizer/wlgreen.png"
                                  style="width: 70px; height: 70px; margin-top: 10px;"/>
                            </div>
                            <div style="margin-top: 35px;">
                              <span style="font-size: 20px;">결재 완료함</span>
                              <span style="font-size: 20px; margin-left: 24px;" id="app_success"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!--/ 나의결재문서함 -->
                  </div>
                  <div class="card" style="height: 815px;">
                    <div class="d-flex align-items-center">
		                  <div style="margin: 20px;">
		                    <a id="board" class="btn btn-primary" style="font-size: 20px; color: white" href="${contextPath}/board/boardList.do">
		                      <c:choose>
		                        <c:when test="${loginUser.deptCode eq 'S1'}">영업총괄팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'S2'}">인사팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'S3'}">지원팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T1'}">남성의류팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T2'}">여성의류팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T3'}">식품팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T4'}">스포츠팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T5'}">뷰티팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T6'}">명품팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T7'}">문화센터팀 </c:when>
		                        <c:when test="${loginUser.deptCode eq 'T8'}">디지털 및 가전팀 </c:when>
		                        <c:otherwise>기타부서팀</c:otherwise>
		                      </c:choose>
		                      게시판
		                    </a>                   
		                  </div>

		                  <div class="ms-auto d-flex">
		                  </div>
		                </div>
		             		<div class="card-datatable table-responsive pt-3"> 
								  		<table class="datatables-basic table text-center">
								    		<thead>
								      		<tr>
								            <th style="width: 10%;">번호</th>
								            <th style="width: 15%;">작성자</th>
								            <th style="width: 40%;">제목</th>
								            <th style="width: 15%;">작성일</th>
								            <th style="width: 10%;">조회수</th>
								            <th style="width: 10%;">댓글수</th>
								      		</tr>
								    		</thead>
										    <tbody id="boardListTbody">
										      
										    </tbody>
								  		</table>
								  		</div>
											<div class="card-body">
											  <div class="row">
											    <span class="col-lg-12 d-flex justify-content-center" >
											      <div class="demo-inline-spacing">
											        <nav aria-label="Page navigation">
											          <ul class="pagination" id="paging_area">
											          </ul>
											        </nav>
											      </div>
											    </span>
											  </div>
			                </div>
                		</div>
                  
                  <!--/ 팀게시판 영역 -->                  
                  <!--/ Activity Timeline -->
                </div>
              </div>
              <!--/ User Profile Content -->
            </div>
            
            <script>
            
            </script>
   <!-- 세션 끝 -->



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
   
      
   <script>
   
   	// 페이지 로드 시 실행시킬 함수(김동규)
    window.onload = function(){
    	
    	fnMemoList();	 // 메모 전체 리스트 조회
    	fnTeamList();  //	소속팀 전체 리스트 조회
    	fnLoadSign();  // 전자서명 조회
    	fnBoardList(); // 게시판 리스트 조회
			fnAppList();   // 내 결재 문서함 조회
    }
    
    // 메모 전체 리스트 조회(김동규)
   	function fnMemoList(){
   		
   		const memNo = '${loginUser.getMemNo()}'; // 현재 로그인한 사원의 사번
   		
	   		$.ajax({
	   			url : '${contextPath}/memo/memoList.do',
	   			type: 'GET',
	   			// data: {memNo: memNo}, // 서버에서 세션값을 직접 사용 (보안 문제)
	   			success: function(res) {
	   			    let liEl = "<ul class='list-unstyled mb-2'>";

	   			    if (res.length == 0) {	// 메모가 없을 경우 보여질 문구 추가
	   			        
	   			        liEl += "<li class='text-center'>등록된 메모가 없습니다.</li>";
	   			        
	   			    } else {	// 메모가 있을 경우 목록 추가
	   			        
	   			        for (let i = 0; i < res.length; i++) {
	   			            liEl += "<li class='d-flex align-items-center pt-5 pb-5 mt-3' id='memoList'>"
	   			                    + "<span class='fw-medium mx-2' onclick='fnSelectMemo(" + res[i].memoNo + ");'>" + res[i].memoContent + "</span>"
	   			                    + "<div class='dropdown'>"
	   			                    + "<i class='ti ti-dots-vertical ti-sm' type='button' data-bs-toggle='dropdown' aria-expanded='false'></i>"
	   			                    + "<ul class='dropdown-menu'>"
	   			                    + "<li><a class='dropdown-item' onclick='fnSelectMemo(" + res[i].memoNo + ")'><i class='ti ti-zoom-in'></i>메모 열기</a></li>"
	   			                    + "<li><a class='dropdown-item' onclick='fnDeleteMemo(" + res[i].memoNo + ")'><i class='ti ti-trash'></i>메모 삭제</a></li>"
	   			                    + "</ul>"
	   			                    + "</div>"
	   			                    + "</li>";
	   			        }
	   			    }

	   			    liEl += "</ul>";
	   			    $('#memoDiv').html(liEl);
	   			},
	   			error: function(){
	   				alert('메모 목록을 불러오지 못했습니다.');
	   			}

	   	})
   	}
    
    // 메모작성 아이콘 클릭 시 열리는 새 메모 작성 모달(김동규)
    function fnOpenMemoModal(){
    	
      var memoModal = new bootstrap.Modal(document.getElementById("insertMemoModal"));

      memoModal.show();

    }
    
    
    // 메모 클릭시 해당 메모 조회(김동규)
    function fnSelectMemo(memoNo){
    	
    	var memoModal = new bootstrap.Modal(document.getElementById("selectMemoModal"));

    	$.ajax({
    		url: '${contextPath}/memo/selectMemo.do',
    		type: 'GET',
    		data: {memoNo: memoNo},
    		success: function(res){

		    	memoModal.show();
		    	
		    	$('#insertMemoInput_edit').val(res.memoContent);
		    	$('#modifyMemoNo').val(res.memoNo);
    		}
    		
    	})
    	
    }
    
    // 메모 등록
    function fnInsertMemo(){
		
    	let memNo = '${loginUser.getMemNo()}';
    	let memoContent = $('#insertMemoInput').val();
    	
    	// 작성된 내용이 없을경우 등록하지않고 모달창 종료
    	if (!memoContent) {
    		 
 	       $('#selectMemoModal').modal('hide');
 	        
 	       return;
    	   }
    	
    	$.ajax({
    		url: '${contextPath}/memo/insertMemo.do',
    		type: 'POST',
    		data: {
    			memNo: memNo,
    			memoContent: memoContent
    		},
    		success: function(res){
    			
    				$('#insertMemoInput').val('');
    				
		    		fnMemoList(); // 등록 후 전체 리스트 조회 실행
    			
    		}
    	})
    	
    }
    
    // 메모 삭제
    function fnDeleteMemo(memoNo){
    	
    	$.ajax({
    		url: '${contextPath}/memo/deleteMemo.do',
    		type: 'POST',
    		data: {memoNo: memoNo},
    		success: function(res) {
    			
    			fnMemoList();	// 삭제 후 전체 리스트 조회 재실행
    	    
    		}
    		
    	})
    }
    
    // 메모 수정
    function fnModifyMemo(){
    	
    	let memoNo = $('#modifyMemoNo').val();
    	let memoContent = $('#insertMemoInput_edit').val();

    	$.ajax({
    		url: '${contextPath}/memo/modifyMemo.do',
    		type: 'POST',
    		data: {
    			memoNo: memoNo,
    			memoContent: memoContent
    			},
    		success: function(res){
    			
    			fnMemoList();	// 수정 후 전체 리스트 조회 재실행
    			
    		}
    	})
    }
    
    // 소속팀 전체 리스트 조회
    function fnTeamList(){
    	
   		const memNo = '${loginUser.getMemNo()}'; 			 // 현재 로그인한 사원의 사번
    	const deptCode = '${loginUser.getDeptCode()}'; // 현재 로그인한 사원의 부서코드
    	
    	$.ajax({
    		url: '${contextPath}/member/teamList.do',
    		type: 'POST',
    		data: {
			    			memNo: memNo,
			    			deptCode: deptCode
			    		},
    		success: function(res){
    			
    			let liEl = '<ul class="list-unstyled mb-0">'
    			
    			for(let i = 0; i < res.length; i++){
    				
    				liEl += '<li class="mb-4">'
    							+'<div class="d-flex align-items-center">'
    								+'<div class="d-flex align-items-center">'
    									+'<div class="avatar me-2">'
    			            + '<img src="${contextPath}' + res[i].profileURL + '" alt="Avatar" class="rounded-circle"/>'
    									+'</div>'
    									+'<div class="me-2">'
    										+'<h6 class="mb-0">' + res[i].memName + '</h6>'
    										+'<small>' + res[i].email + '</small>'
    									+'</div>'
    								+'</div>'
    						  +'</li>'
    			}
    			
    			liEl += '</ul>';
    			
    			$('#teamListDiv').html(liEl);
    			
    		}
    		
    	})
    }
    
    // 팀게시판 리스트 조회
		function fnBoardList(page) {
		    $.ajax({
		        url: '${contextPath}/member/boardList.do',
		        type: 'POST',
		        data: {page: page},
		        success: function(res) {
	              let pi = res.pi; // 페이지 정보
		            let trEl = '';
		
		            // 데이터가 비어 있는 경우
		            if (!res || res.list.length == 0) {
		                trEl += '<tr>';
		                trEl += '<td colspan="6" style="text-align: center;">조회된 게시글이 없습니다.</td>';
		                trEl += '</tr>';
		            } else {
		                let count = 1;
		                res.list.forEach((board) => {
		                    let reverseCount = pi.listCount - (pi.currentPage - 1) * pi.boardLimit - (count - 1);
		
		                    
		                    trEl += '<tr data-boardno="' + board.boardNo + '">';
		                    trEl += '<td>' + reverseCount + '</td>';
		                    trEl += '<td>' + board.memName + '</td>';
		                    trEl += '<td class="title" style="cursor: pointer;">' + board.boardTitle;
		                    trEl += '</td>';
		                    trEl += '<td>' + board.boardRegistDT + '</td>';
		                    trEl += '<td>' + board.boardCount + '</td>';
		                    trEl += '<td>' + board.replyCount + '</td>';
		                    trEl += '</tr>';
		
		                    count++;
		                });
		            }
		
		            $('#boardListTbody').html(trEl);
		            
		            // 페이징바 생성 및 업데이트
		            let pagingEl = '';
		            pagingEl += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="fnBoardList(1);"><i class="ti ti-chevrons-left ti-sm"></i></a></li>';
		            pagingEl += '<li class="page-item prev ' + (pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnBoardList(' + (pi.currentPage - 1) + ');"><i class="ti ti-chevron-left ti-sm"></i></a></li>';

		            for (let i = pi.startPage; i <= pi.endPage; i++) {
		                pagingEl += '<li class="page-item ' + (i == pi.currentPage ? 'active' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnBoardList(' + i + ');">' + i + '</a></li>';
		            }

		            pagingEl += '<li class="page-item next ' + (pi.currentPage == pi.maxPage ? 'disabled' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnBoardList(' + (pi.currentPage + 1) + ');"><i class="ti ti-chevron-right ti-sm"></i></a></li>';
		            pagingEl += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="fnBoardList(' + pi.maxPage + ');"><i class="ti ti-chevrons-right ti-sm"></i></a></li>';

		            $('#paging_area').html(pagingEl);			
    		}
    	})
    }
    
    function goToPage(pageNumber) {
        window.location.href = "${contextPath}/member/boardList.do?page=" + pageNumber;
      }
    
		// 내 결재 문서함 조회
		function fnAppList(){
			
			let memNo = '${loginUser.getMemNo()}';
			
			$.ajax({
				url: '${contextPath}/member/selectAppList.do',
				type: 'POST',
				data: {memNo: memNo},
				success: function(res){
					
					$('#app_standby').html(res.A);
					$('#app_progress').html(res.B);
					$('#app_success').html(res.C);
					
				}
			})
			
		}
    
    // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
			const element = document.getElementById("side_myinfo");
			
	  	document.getElementById("mypage").classList.add("open");
	  	element.style.backgroundColor = "#958CF4";
	  	element.style.color = "white";
	  	element.classList.add("active");
	  	
	  	
		});
    
   
   </script>

   
   
</body>
</html>