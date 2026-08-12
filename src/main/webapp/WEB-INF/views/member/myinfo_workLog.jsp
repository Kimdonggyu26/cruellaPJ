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
   <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
   
   <link rel="stylesheet" href="${contextPath}/assets/vendor/libs/fullcalendar/fullcalendar.css" />
   <link rel="stylesheet" href="${contextPath}/assets/vendor/css/pages/app-calendar.css" />
   <style>
		#side_myworklog::before {
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#side_myworklog.active::before {
		  border: 2px solid white; /* 테두리만 흰색으로 변경 */
		}
		.fc-event-time{
			display: none;
		}
		.late-in {
    	background-color: #FFC6C7; 
    	color: FFC6C7;
  	}
  	.normal {
  		background-color: #EBEBED;
  	}
  	.absence{
  		background-color: #FF4C51;
  		color: white !important; 
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
      <!-- nav 끗 -->


          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <!-- Header -->
              <div class="row">

                <div class="col-12">
                  <div class="card mb-6">
                    <div class="user-profile-header-banner">
                      <img src="${contextPath}/assets/img/pages/profile-banner.png" alt="Banner image" style="width: 1392px;" class="rounded-top" />
                    </div>
                    <div class="user-profile-header d-flex flex-column flex-lg-row text-sm-start text-center mb-5">
                      <div class="flex-shrink-0 mt-n2 mx-sm-0 mx-auto">
                        <img
                          style="width: 100px; height: 100px;"
                          src="${ contextPath }<c:out value='${ loginUser.profileURL }'
                          default='/assets/img/default_profile.png' />"
                          alt="user image"
                          class="d-block h-auto ms-0 ms-sm-6 rounded user-profile-img" />
                      </div>
                      <div class="flex-grow-1 mt-3 mt-lg-5">
                        <div
                          class="d-flex align-items-md-end align-items-sm-start align-items-center justify-content-md-between justify-content-start mx-5 flex-md-row flex-column gap-4">
                          <div class="user-profile-info">
                            <h4 class="mb-2 mt-lg-6">${loginUser.memName}</h4>
                            <ul
                              class="list-inline mb-0 d-flex align-items-center flex-wrap justify-content-sm-start justify-content-center gap-4 my-2">
                              <li class="list-inline-item d-flex gap-2 align-items-center">
                                <i class="ti ti-book ti-lg"></i><span class="fw-medium">${loginUser.deptName}</span>
                              </li>
                              <li class="list-inline-item d-flex gap-2 align-items-center">
                                <i class="ti ti-mail ti-lg"></i><span class="fw-medium">${loginUser.email}</span>
                              </li>
                              <li class="list-inline-item d-flex gap-2 align-items-center">
                                <i class="ti ti-calendar ti-lg"></i><span class="fw-medium">${loginUser.hireDate}</span>
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
                        <a class="nav-link" href="${contextPath}/member/myinfo.do">
                          <i class="ti-sm ti ti-user-check me-1_5"></i> 내 정보
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" href="${contextPath}/member/myinfo_workLog.do">
                        <i class="ti-sm ti ti-users me-1_5"></i> 근태관리</a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <!--/ Navbar pills -->

              <!-- User Profile Content -->
              <div class="content-wrapper">
                <div class="flex-grow-1 container-p-y">
                  <div class="card app-calendar-wrapper">
                    <div class="row g-0">
    
                      <!-- Calendar & Modal -->
                      <div class="col app-calendar-content">
                        <div class="card shadow-none border-0">
                          <div class="card-body pb-0">
                            <!-- FullCalendar -->
                            <div id="calendar"></div>
                          </div>
                        </div>
                        <div class="app-overlay"></div>
                        <!-- FullCalendar Offcanvas -->
                        <div
                          class="offcanvas offcanvas-end event-sidebar"
                          tabindex="-1"
                          id="addEventSidebar"
                          aria-labelledby="addEventSidebarLabel">
                          <div class="offcanvas-header border-bottom">
                            <h5 class="offcanvas-title" id="addEventSidebarLabel">Add Event</h5>
                            <button
                              type="button"
                              class="btn-close text-reset"
                              data-bs-dismiss="offcanvas"
                              aria-label="Close"></button>
                          </div>
                          <div class="offcanvas-body">
                            <form class="event-form pt-0" id="eventForm" onsubmit="return false">
                              <div class="mb-5">
                                <label class="form-label" for="eventTitle">Title</label>
                                <input
                                  type="text"
                                  class="form-control"
                                  id="eventTitle"
                                  name="eventTitle"
                                  placeholder="Event Title" />
                              </div>
                              <div class="mb-5">
                                <label class="form-label" for="eventLabel">Label</label>
                                <select class="select2 select-event-label form-select" id="eventLabel" name="eventLabel">
                                  <option data-label="primary" value="Business" selected>Business</option>
                                  <option data-label="danger" value="Personal">Personal</option>
                                  <option data-label="warning" value="Family">Family</option>
                                  <option data-label="success" value="Holiday">Holiday</option>
                                  <option data-label="info" value="ETC">ETC</option>
                                </select>
                              </div>
                              <div class="mb-5">
                                <label class="form-label" for="eventStartDate">Start Date</label>
                                <input
                                  type="text"
                                  class="form-control"
                                  id="eventStartDate"
                                  name="eventStartDate"
                                  placeholder="Start Date" />
                              </div>
                              <div class="mb-5">
                                <label class="form-label" for="eventEndDate">End Date</label>
                                <input
                                  type="text"
                                  class="form-control"
                                  id="eventEndDate"
                                  name="eventEndDate"
                                  placeholder="End Date" />
                              </div>
                              <div class="mb-5">
                                <div class="form-check form-switch">
                                  <input type="checkbox" class="form-check-input allDay-switch" id="allDaySwitch" />
                                  <label class="form-check-label" for="allDaySwitch">All Day</label>
                                </div>
                              </div>
                              <div class="mb-5">
                                <label class="form-label" for="eventURL">Event URL</label>
                                <input
                                  type="url"
                                  class="form-control"
                                  id="eventURL"
                                  name="eventURL"
                                  placeholder="https://www.google.com" />
                              </div>
                              <div class="mb-4 select2-primary">
                                <label class="form-label" for="eventGuests">Add Guests</label>
                                <select
                                  class="select2 select-event-guests form-select"
                                  id="eventGuests"
                                  name="eventGuests"
                                  multiple>
                                  <option data-avatar="1.png" value="Jane Foster">Jane Foster</option>
                                  <option data-avatar="3.png" value="Donna Frank">Donna Frank</option>
                                  <option data-avatar="5.png" value="Gabrielle Robertson">Gabrielle Robertson</option>
                                  <option data-avatar="7.png" value="Lori Spears">Lori Spears</option>
                                  <option data-avatar="9.png" value="Sandy Vega">Sandy Vega</option>
                                  <option data-avatar="11.png" value="Cheryl May">Cheryl May</option>
                                </select>
                              </div>
                              <div class="mb-5">
                                <label class="form-label" for="eventLocation">Location</label>
                                <input
                                  type="text"
                                  class="form-control"
                                  id="eventLocation"
                                  name="eventLocation"
                                  placeholder="Enter Location" />
                              </div>
                              <div class="mb-5">
                                <label class="form-label" for="eventDescription">Description</label>
                                <textarea class="form-control" name="eventDescription" id="eventDescription"></textarea>
                              </div>
                              <div class="d-flex justify-content-sm-between justify-content-start mt-6 gap-2">
                                <div class="d-flex">
                                  <button type="submit" id="addEventBtn" class="btn btn-primary btn-add-event me-4">
                                    Add
                                  </button>
                                  <button
                                    type="reset"
                                    class="btn btn-label-secondary btn-cancel me-sm-0 me-1"
                                    data-bs-dismiss="offcanvas">
                                    Cancel
                                  </button>
                                </div>
                                <button class="btn btn-label-danger btn-delete-event d-none">Delete</button>
                              </div>
                            </form>
                          </div>
                        </div>
                      </div>
                      <!-- /Calendar & Modal -->
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-xl-8 col-lg-7 col-md-7">
                  <!-- Activity Timeline -->
                  <div class="card card-action mb-6" style="width: 1390px;">
                  <div class="card">
                    <div class="table-responsive text-nowrap">
                      <table class="table">
                        <thead>
                          <div style="display: flex; height: 80px;">
                            <div style="display: flex; margin-top: 30px;">
                              <h5 class="card-action-title" style="margin-left: 20px; margin-right: 30px; margin-left: 40px; margin-bottom: 60px;">휴가관리</h5>
                              <p style="color: #28C76F;">${loginUser.vacCount}</p>
                              &nbsp;&nbsp;/&nbsp;&nbsp;
                              <span>15</span>
                            </div>
                            <div style="position: relative; top: 20px; left: 860px; display: flex; gap: 60px;">
                              <div style="position: relative; top: 10px;">
                                사용 <span>${15-loginUser.vacCount}</span>
                                &nbsp;&nbsp;&nbsp;
                                잔여 <span style="color: #28C76F;">${loginUser.vacCount}</span>
                              </div>
                              <a href="${contextPath}/app/form_annual.do" class="btn btn-success mb-1" style="height: 45px;">
                                <i class="ti ti-plane-departure ti-xs me-2"></i>휴가 신청
                              </a>
                            </div>
                          </div>
                        </thead>
										    <thead>
										      <tr>
									            <th style="width: 15%;"><div style="margin-left: 30px;">번호</div></th>
									            <th style="width: 35%;">제목</th>
									            <th style="width: 25%;">신청일</th>
									            <th style="width: 20%;"><div style="margin-left: 10px;">진행상태</div></th>
										      </tr>
										    </thead>
                        <tbody class="table-border-bottom-0" id="vacListTbody">
                        </tbody>
                      </table>
                    </div>
										<div class="card-body">
										  <div class="row">
										    <span class="col-lg-12 d-flex justify-content-center">
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
                    
                  </div>
                  <!-- Projects table -->
                  <!--/ Projects table -->                  
                  <!--/ Activity Timeline -->

                </div>
              </div>
              <!--/ User Profile Content -->
            </div>
            <!-- / Content -->



            <div class="content-backdrop fade"></div>
          </div>
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
   
    <script src="${contextPath}/assets/js/app-calendar-events.js"></script>
    <script src="${contextPath}/assets/js/app-calendar.js"></script>
    <script src="${contextPath}/assets/vendor/libs/fullcalendar/fullcalendar.js"></script>
    
   
   <script>
   
	  	// 페이지 로드 시 실행시킬 함수(김동규)
	   window.onload = function(){
	   	
		   fnVacList(); // 휴가목록 조회
	   }

 
	   	// 사이드바 처리
			document.addEventListener("DOMContentLoaded", function () {
	 	
			const element = document.getElementById("side_myworklog");
			
		 	document.getElementById("mypage").classList.add("open");
		 	element.style.backgroundColor = "#958CF4";
		 	element.style.color = "white";
		 	element.classList.add("active");
	 	
		});
	   	

    // 휴가목록 조회
		function fnVacList(page) {
		   
		   const memNo = '${loginUser.getMemNo()}'; 
		   
		    $.ajax({
		        url: '${contextPath}/member/vacList.do',
		        type: 'POST',
		        data: {memNo: memNo},
		        success: function(res) {
		        	  let pi = res.pi; // 페이징 정보
		            let trEl = '';
		
		            // 데이터가 비어 있는 경우
		            if (!res || res.list.length == 0) {
		                trEl += '<tr>';
		                trEl += '<td colspan="6" style="text-align: center;">신청 내역이 없습니다.</td>';
		                trEl += '</tr>';
		            } else {
		                let count = 1;
		                res.list.forEach((vac) => {
		                    let reverseCount = pi.listCount - (pi.currentPage - 1) * pi.boardLimit - (count - 1);
		
		                    trEl += '<tr>';
		                    trEl += '<td><div style="margin-left: 40px;">' + reverseCount + '</div></td>';
		                    trEl += '<td class="title">' + vac.docTitle + '</td>';
		                    trEl += '<td>' + vac.docDt + '</td>';
		                    
		                    // docStatus에 따라 이미지 삽입
		                    let statusImage = '';
		                    if (vac.docStatus == 'A' || vac.docStatus == 'B') {
		                        statusImage = '<img src="${contextPath}/assets/img/customizer/checkGray.png" alt="대기" />';
		                    } else if (vac.docStatus == 'C') {
		                        statusImage = '<img src="${contextPath}/assets/img/customizer/checkGreen.png" alt="승인" />';
		                    } else if (vac.docStatus == 'D') {
		                        statusImage = '<img src="${contextPath}/assets/img/customizer/checkRed.png" alt="반려" />';
		                    }
		                    
		                    trEl += '<td>' + statusImage + '</td>';
		                    trEl += '</tr>';
		
		                    count++;
		                });
		            }
		            $('#vacListTbody').html(trEl);
		            
		            // 페이징바 생성 및 업데이트
		            let pagingEl = '';
		            pagingEl += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="fnVacList(1);"><i class="ti ti-chevrons-left ti-sm"></i></a></li>';
		            pagingEl += '<li class="page-item prev ' + (pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnVacList(' + (pi.currentPage - 1) + ');"><i class="ti ti-chevron-left ti-sm"></i></a></li>';

		            for (let i = pi.startPage; i <= pi.endPage; i++) {
		                pagingEl += '<li class="page-item ' + (i == pi.currentPage ? 'active' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnVacList(' + i + ');">' + i + '</a></li>';
		            }

		            pagingEl += '<li class="page-item next ' + (pi.currentPage == pi.maxPage ? 'disabled' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnVacList(' + (pi.currentPage + 1) + ');"><i class="ti ti-chevron-right ti-sm"></i></a></li>';
		            pagingEl += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="fnVacList(' + pi.maxPage + ');"><i class="ti ti-chevrons-right ti-sm"></i></a></li>';

		            $('#paging_area').html(pagingEl);			
    		}
    	})
    }
    function goToPage(pageNumber) {
        window.location.href = "${contextPath}/member/vacList.do?page=" + pageNumber;
      }  	
   </script>

<script type="text/javascript">
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    if (calendarEl) {
      var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        selectable: true,
        aspectRatio: 2.2,
        contentHeight: 850,
        dayMaxEvents: true,
        editable: true,
        selectMirror: true,
        textColor: 'black',
        displayEventTime: true,
        events: [
        	  <c:forEach var="list" items="${wlList}" varStatus="status">
        	    <c:choose>
        	      <c:when test="${list.status == 'A'}">
        	        {
        	          id: '${list.workNo}_absence', // 결근 이벤트 ID
        	          title: '결근', // 결근 표시
        	          start: '${list.workDate}T00:00:00', // 결근은 시간 없이 날짜만 사용
        	          end: '${list.workDate}T23:59:59', // 결근은 하루 종일
        	          extendedProps: { // 추가 데이터
        	            workDate: '${list.workDate}', // 근무 날짜
        	            workStatus: '${list.status}', // 근무 상태
        	            status: '결근' // 결근 상태
        	          },
        	          allDay: true // 하루 종일 이벤트
        	        }
        	      </c:when>
        	      <c:otherwise>
        	        {
        	          id: '${list.workNo}_in', // 출근 이벤트 ID
        	          title: '출근 ${list.clockInTime.substring(0, 5)}', // 출근 시간 표시
        	          start: '${list.workDate}T${list.clockInTime}', // 출근 시간
        	          end: '${list.workDate}T${list.clockInTime}', // 출근 시간은 끝 시간이 없으므로 start와 end가 동일
        	          extendedProps: { // 추가 데이터
        	            workDate: '${list.workDate}', // 근무 날짜
        	            workStatus: '${list.status}', // 근무 상태
        	            status: '출근'
        	          },
        	          allDay: false // 시간 기반 이벤트
                }
                <c:if test="${not empty list.clockOutTime}">
                , {
        	          id: '${list.workNo}_out', // 퇴근 이벤트 ID
        	          title: '퇴근 ${list.clockOutTime.substring(0, 5)}', // 퇴근 시간 표시
        	          start: '${list.workDate}T${list.clockOutTime}', // 퇴근 시간
        	          end: '${list.workDate}T${list.clockOutTime}', // 퇴근 시간은 끝 시간이 없으므로 start와 end가 동일
        	          extendedProps: { // 추가 데이터
        	            workDate: '${list.workDate}', // 근무 날짜
        	            workStatus: '${list.status}', // 근무 상태
        	            status: '퇴근'
        	          },
        	          allDay: false // 시간 기반 이벤트
        	        }
                </c:if>
        	      </c:otherwise>
        	    </c:choose>
        	    <c:if test="${!status.last}">,</c:if>
        	  </c:forEach>
        	],
        	eventClassNames: function(info) {
        		  var startTime = new Date(info.event.start);

        		  // 출근 이벤트이고 시간이 9시 이상인경우
        		  if (info.event.extendedProps.status === '출근' && startTime.getHours() >= 9) {
        		    return ['late-in']; 
        		  }

        		  // 결근 
        		  if (info.event.extendedProps.status === '결근') {
        		    return ['absence']; 
        		  }

        		  return ['normal']; // 기본
        		}
      });
      calendar.render();
    } else {
      console.error("캘린더 업데이트 실패");
    }
  });
</script>


</body>



</html>