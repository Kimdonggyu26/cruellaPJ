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
 	 	height: 220px;
 		margin-top: 15px;
 	 	overflow-y: scroll;
 	 }
	 #memoDiv::-webkit-scrollbar,
	 #memberListDiv::-webkit-scrollbar {
	  width: 10px;  /* 세로 스크롤바의 너비 */
	  height: 8px; /* 가로 스크롤바의 높이 */
	 }
	
	 #memoDiv::-webkit-scrollbar-track,
	 #memberListDiv::-webkit-scrollbar-track {
	  background-color: #f1f1f1; /* 트랙 배경색 */
	  border-radius: 10px; /* 트랙 모서리 둥글게 */
	 }
  	#memberListDiv{
   	 max-height: 600px;
   	 overflow-y: auto;
   	 margin-right: 10px; /* 오른쪽 외부 여백 */
   	}
	
		/* 스크롤바의 손잡이 (사용자가 드래그할 부분) */
		#memoDiv::-webkit-scrollbar-thumb,
		#memberListDiv::-webkit-scrollbar-thumb {
	    background-color: #7367f0; /* 손잡이 색 */
	    border-radius: 10px;     /* 손잡이 모서리 둥글게 */
	    border: 2px solid #f1f1f1; /* 손잡이의 테두리 색 (트랙과 구분됨) */
	}
		/* 스크롤바 손잡이 위에 마우스를 올렸을 때 */
		#memoDiv::-webkit-scrollbar-thumb:hover,
		#memberListDiv::-webkit-scrollbar-thumb:hover {
	    background-color: #564EB5; /* 손잡이 색을 다르게 */
		}
  	#side_dashboard::before{
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#side_dashboard.active::before{
		 	border: 2px solid white; /* 테두리만 흰색으로 변경 */
		}
		#memoList {
			margin-right: 10px;
		}
		#allMem {
			cursor: pointer;
			color: #444050;
		}
		#allMem:hover {
			color: #7367f0;
			transition: color 0.3s ease;
		}
		#notice {
			cursor: pointer;
			color: #444050;
			font-size: 18px;
		}
		#notice:hover {
			color: #7367f0;
			transition: color 0.3s ease;		
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
	  <!-- 이쪽에 세션정보 넣어야합니다 -->
    
    
      <div class="row g-6">
        <!-- Website Analytics -->
        <div class="col-lg-6" style="width: 450px;">
          <div>
            <div class="card">
              <div class="card-body text-center">
                <div class="dropdown btn-pinned">
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="javascript:void(0);">Share connection</a></li>
                    <li><a class="dropdown-item" href="javascript:void(0);">Block connection</a></li>
                    <li>
                      <hr class="dropdown-divider" />
                    </li>
                    <li><a class="dropdown-item text-danger" href="javascript:void(0);">Delete</a></li>
                  </ul>
                </div>
                <div class="mx-auto my-6">
                  <img src="${ contextPath }<c:out value='${ loginUser.profileURL }' default='/assets/img/default_profile.png' />" style="height: 120px; width: 120px;" alt="Avatar Image" class="rounded-circle" />
                </div>
                <h5 class="mb-0 card-title">${ loginUser.getMemName() }</h5>
                <div class="d-flex align-items-center justify-content-center my-6 gap-2">
                  <a href="javascript:;" class="me-2" style="cursor: default;"><span class="badge bg-label-secondary">${ loginUser.getDeptName() }</span></a>
                  <a href="javascript:;" style="cursor: default;"><span class="badge bg-label-warning">${ loginUser.getPosName() }</span></a>
                </div>

                <div class="d-flex align-items-center justify-content-around mb-6">
                  <div onclick="location.href='${contextPath}/app/box_standby.do'" style="cursor: pointer;">
                    <h5 class="mb-0" id="app_standby"></h5>
                    <span>결재 대기</span>
                  </div>
                  <div onclick="location.href='${contextPath}/member/myinfo_workLog.do'" style="cursor: pointer;">
                    <h5 class="mb-0">${loginUser.vacCount}</h5>
                    <span>잔여 휴가</span>
                  </div>
                  <div>
                    <h5 class="mb-0" id="todayDate"></h5>
                    <span>오늘 날짜</span>
                  </div>
                </div>
                <div class="d-flex align-items-center justify-content-center">
	                <c:choose>
	                	<c:when test="${loginUser.wlStatus == null}">
		                  <a class="btn btn-success d-flex align-items-center me-4" onclick="fnClockIn();" style="color: white">
		                  	<i class="ti-xs me-1 ti ti-clock me-2"></i>출근
		                  </a>
		                </c:when>
		                <c:when test="${loginUser.wlStatus == 'C'}">
								      <a class="btn btn-danger d-flex align-items-center me-4" onclick="fnClockOut();" style="color: white">
								        <i class="ti-xs me-1 ti ti-clock me-2"></i>퇴근
								      </a>
								    </c:when>
								    <c:otherwise>
								    	<div class="d-flex align-items-center me-4">
								        <i class="ti-xs me-1 ti ti-clock me-2"></i>근무완료 !
								      </div>
								    </c:otherwise>
	                </c:choose>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--/ Website Analytics -->

				<!-- 팀별 매출 점유율 차트 -->
				<div class="card" style="width: 480px; height: 400px;">
					<div class="card-body">
						<div style="margin: 20px;" id="categorySalesChart">
							<div style="display: flex; justify-content: space-between; align-items: center;">
							 <div>
							   <span>
							      <span style="font-size: 20px;">팀별 매출 점유율</span>
							   </span>
							 </div>
							</div>
							<div class="justify-content-between" style="display: flex;">
								<div class="d-flex justify-content-end">
									<div style="display: none;">
									  <select id="doughnutChart_yearSelect" class="select1 form-select form-select-lg" data-allow-clear="true">
									    <option value="2023">2023</option>
									    <option value="2024" selected>2024</option>
									  </select>
									</div>
									<div style="display: none;">
									  <select id="doughnutChart_monthSelect" class="select1 form-select form-select-lg" data-allow-clear="true" style="margin-left: 10px;">
									    <option value="01">1월</option>
									    <option value="02">2월</option>
									    <option value="03">3월</option>
									    <option value="04">4월</option>
									    <option value="05">5월</option>
									    <option value="06">6월</option>
									    <option value="07">7월</option>
									    <option value="08">8월</option>
									    <option value="09">9월</option>
									    <option value="10">10월</option>
									    <option value="11">11월</option>
									    <option value="12">12월</option>
									  </select>
									</div>
								</div>
							</div>
							<div>
								<div class="doughnutChart-container" style="position: relative; width: 100%;">
								  <canvas id="doughnutChart" style="width: 100%; height: 300px;"></canvas>
								</div>
							</div>		
						</div>
						<script>
						$(function() {
						  const doughnutCtx = document.getElementById('doughnutChart').getContext('2d');
						  const doughnutChart = new Chart(doughnutCtx, {
						    type: 'doughnut',
						    data: {
						      labels: [],
						      datasets: [{
						        label: '매출',
						        data: [],
						        backgroundColor: [
						          'rgb(102, 110, 232)', 'rgb(40, 208, 148)', 'rgb(253, 172, 52)', 'rgb(253, 233, 52)',
						          'rgb(223, 253, 52)', 'rgb(52, 223, 253)', 'rgb(196, 52, 253)', 'rgb(253, 52, 193)'
						        ],
						        borderWidth: 1
						      }]
						    },
						    options: {
						      responsive: true,
						      maintainAspectRatio: false,
						      plugins: {
						    	  legend: {
						    	      display: false // 범례를 비활성화
						    	    },
						        tooltip: {
						          callbacks: {
						            label: (context) => {
						              let label = context.label || '';
						              if (label) label += ': ';           
						
						              // 전체 매출 계산하기 전에 총 매출을 계산
						              const totalSales = context.chart.data.datasets[0].data.reduce((a, b) => a + (b || 0), 0);
						
						              if (context.raw !== null && context.raw !== undefined) {
						                // 퍼센트 계산
						                const percentage = totalSales > 0 ? ((context.raw / totalSales) * 100).toFixed(2) : 0;
						                
						                // 매출과 퍼센트 표시
						                label += percentage + "% (" + context.raw.toLocaleString() + "원)";
						              }
						              
						              return label;
						            }
						          }
						        },
						        datalabels: {
						           color: '#444050',
						           anchor: 'center', // 캔버스 내에서 중심을 기준으로 배치
						           align: 'center',  // 라벨 정렬을 중심으로 설정
						           formatter: (value, context) => {
						             const totalSales = context.chart.data.datasets[0].data.reduce((a, b) => a + (b || 0), 0);
						             const percentage = totalSales > 0 ? ((value / totalSales) * 100).toFixed(2) : 0;
						             const label = context.chart.data.labels[context.dataIndex];
						             // 반환된 라벨과 퍼센트를 한 줄씩 표시
						             return label;
						           },
						           font: {
						             size: 12, // 글씨 크기 설정
						             family: 'Arial',
						           },
						           padding: 0, // 텍스트와 주변 간격 설정
						           textAlign: 'center',
						         },
						      }
						    },
						    plugins: [ChartDataLabels] // datalabels 플러그인 활성화
						  });
						
						  function setInitialDate() {
						    const today = new Date();
						    const year = today.getFullYear();
						    const month = ("0" + (today.getMonth() + 1)).slice(-2);
						    
						    $('#doughnutChart_yearSelect').val(year);
						    $('#doughnutChart_monthSelect').val(month);
						    
						    updateChart(year, month);
						  }
						
						  function updateChart(year, month) {
						    $.ajax({
						      url: `${contextPath}/chart/teamSales.do`,
						      type: "POST",
						      data: JSON.stringify({ year: year, month: month }),
						      contentType: "application/json; charset=utf-8",
						      dataType: "json",
						      success: function(data) {
						
						        // 데이터 배열 초기화
						        var departments = [];
						        var sales = [];
						
						        // deptCode를 매핑하여 레이블 추가
						        const deptCodeToLabel = {
						          T1: '남성의류',
						          T2: '여성의류',
						          T3: '식품',
						          T4: '스포츠',
						          T5: '뷰티',
						          T6: '명품',
						          T7: '문화센터',
						          T8: '디지털 및 가전'
						        };
						
						        let totalSales = 0; // 총 매출 변수
						
						        // 데이터 처리
						        $.each(data, function(index, item) {
						          const deptLabel = deptCodeToLabel[item["deptCode"]] || item["deptCode"];
						          departments.push(deptLabel);
						          sales.push(item["sale"]);
						          totalSales += item["sale"]; // 총 매출 계산
						        });
						
						        // 차트 데이터 업데이트
						        doughnutChart.data.labels = departments;
						        doughnutChart.data.datasets[0].data = sales;
						
						        // 차트 갱신
						        doughnutChart.update();
						        
						        // 차트 중앙 텍스트 업데이트
						        $('#chartCenterText').text(year + "년 " + month + "월 매출: " + totalSales.toLocaleString() + "원");
						      },
						      error: function(jqXHR, textStatus, errorThrown) {
						        console.error("AJAX 요청 실패:", {
						          status: textStatus,
						          error: errorThrown,
						          response: jqXHR.responseText,
						        });
						        alert("데이터를 가져오는 데 실패했습니다.");
						      },
						    });
						  }
						
						  $('#doughnutChart_yearSelect, #doughnutChart_monthSelect').change(function() {
						    const year = $('#doughnutChart_yearSelect').val();
						    const month = $('#doughnutChart_monthSelect').val();
						    updateChart(year, month);
						  });
						  
						  setInitialDate();
						});
						</script>
					</div>
				</div>

        
        <!-- 메모목록 -->
        <div class="card" style="height: 400px; width: 430px; margin-left: 12px; background-color: rgba(135, 206, 235, 0.3);">
          <div class="card-body">
				    <h3>현재 날씨  <span id="cityName" style="font-size: 22px; float: right;"></span></h3>
				    <p><span id="temperature" style="font-size: 42px; float: right;"></span></p>
				    <p><span id="condition"></span></p>
          </div>
        </div>



			  <!-- 총매출 차트부분 -->
			  <!-- 연도 입력 및 버튼 -->
			  <div class="card" style="width: 926px; height: 528px;">
				  <div class="card-body">
					  <div class="justify-content-between" style="display: flex; align-items: center;">
					    <!-- 차트 중앙 텍스트 -->
					    <div id="lineChartCenterText" style="font-size: 20px;"></div>
					
					    <!-- 연도 선택 -->
					    <div class="d-flex justify-content-end">
					      <div>
					        <select id="lineChart_yearSelect" class="select1 form-select form-select-lg" data-allow-clear="true" style="width: 150px;">
					          <option value="2023">2023</option>
					          <option value="2024" selected>2024</option>
					        </select>
					      </div>
					    </div>
					  </div>
					
					  <br>
					
					  <!-- 라인 차트 캔버스 -->
					  <div>
					    <div class="lineChart-container" style="position: relative; width: 100%;">
					      <canvas id="lineChart" style="width: 100%;"></canvas>
					    </div>
					  </div>
					</div>
				</div>
			<div class="card" style="width: 430px; height: 530px; margin-left: 16px;">
				<div class="card-body pt-0" style="height: 400px;">
					<!-- 매장 매출 차트 -->
					<div id="storeSalesChart">
					    <!-- Dept_code 및 날짜 선택 박스 추가 -->
					    <div style="display: flex; justify-content: right; align-items: center; gap: 5px; width: 100%">
					        <div style="display: none;">
					            <label for="deptCodeSelect" class="form-label">부서 코드</label>
					            <select id="deptCodeSelect" class="form-select custom-select" data-allow-clear="true" style="width: 200px; height: 48px;">
					                <option value="T1">남성의류</option>
					                <option value="T2">여성의류</option>
					                <option value="T3">식품</option>
					                <option value="T4">스포츠</option>
					                <option value="T5">뷰티</option>
					                <option value="T6">명품</option>
					                <option value="T7">문화센터</option>
					                <option value="T8">디지털 및 가전</option>
					            </select>
					        </div>
					        <div style="margin-top: 10px;">매장별 매출 차트 (단위: 일)</div>
					    </div>
					
					    <div class="barChart-container" style="display: flex; justify-content: center; position: relative; top: 18px; width: 100%;">
					        <canvas id="barChart" style="width: 300px; height: 300px;"></canvas>
					    </div>
					</div>
					
					<script>
					const storeOptions = {
					    "T1": ["레노마셔츠", "라코스테"],
					    "T2": ["샤넬", "구찌"],
					    "T3": ["롯데마트", "홈플러스"],
					    "T4": ["나이키", "아디다스"],
					    "T5": ["아모레퍼시픽", "LG생활건강"],
					    "T6": ["루이비통", "에르메스"],
					    "T7": ["CGV", "롯데시네마"],
					    "T8": ["삼성전자", "LG전자"]
					};
					
					$(function () {
					    const barCtx = document.getElementById('barChart').getContext('2d');
					    const barChart = new Chart(barCtx, {
					        type: 'bar',
					        data: {
					            labels: [], // 매장 이름
					            datasets: [{
					                label: '매출',
					                data: [], // 매출 데이터
					                borderColor: '#4BC0C0',
					                backgroundColor: '#DBF2F2',
					                borderWidth: 1,
					                barThickness: 100
					            }]
					        },
					        options: {
					            responsive: true,
					            scales: {
					                y: {
					                    beginAtZero: true,
					                    ticks: {
					                        callback: function(value) {
					                            if (value >= 1000000000000) {
					                                return (value / 1000000000000).toFixed(2) + "조";
					                            } else if (value >= 100000000) {
					                                return (value / 100000000).toFixed(2) + "억";
					                            } else if (value >= 10000) {
					                                return (value / 10000).toFixed(2) + "만";
					                            } else {
					                                return value.toLocaleString();
					                            }
					                        }
					                    }
					                }
					            },
					            plugins: {
					                tooltip: {
					                    callbacks: {
					                        label: function(context) {
					                            const value = context.raw;
					                            if (value >= 1000000000000) {
					                                return (value / 1000000000000).toFixed(2) + "조 원";
					                            } else if (value >= 100000000) {
					                                return (value / 100000000).toFixed(2) + "억 원";
					                            } else if (value >= 10000) {
					                                return (value / 10000).toFixed(2) + "만 원";
					                            } else {
					                                return value.toLocaleString() + "원";
					                            }
					                        }
					                    }
					                }
					            }
					        }
					    });
					
					    // 날짜 상태를 전역 변수로 관리
					    let selectedStartDate = null;
					    let selectedEndDate = null;
					
					    function updateBarChart(deptCode, startDate, endDate) {
					        $.ajax({
					            url: `${contextPath}/chart/storeSales.do`,
					            type: "POST",
					            data: JSON.stringify({ deptCode: deptCode, startDate: startDate, endDate: endDate }),
					            contentType: "application/json; charset=utf-8",
					            dataType: "json",
					            success: function (data) {
					                const stores = storeOptions[deptCode];
					                const sales = stores.map(store => data.find(item => item.rvStore === store)?.sumStore || 0); // 매출 데이터 추출
					
					                barChart.data.labels = stores;
					                barChart.data.datasets[0].data = sales;
					                barChart.update();
					            },
					            error: function (jqXHR, textStatus, errorThrown) {
					                console.error("AJAX 요청 실패:", { textStatus, errorThrown, response: jqXHR.responseText });
					                alert("데이터를 가져오는 데 실패했습니다.");
					            }
					        });
					    }
					
					    // flatpickr 설정
					    const today = new Date();
					    selectedStartDate = today.toISOString().slice(0, 10); // 초기값: 오늘 날짜
					    selectedEndDate = today.toISOString().slice(0, 10);
					
					    flatpickr("#flatpickr-range", {
					        mode: "range",
					        dateFormat: "Y-m-d",
					        locale: "ko",
					        defaultDate: [today, today], // 기본값을 오늘로 설정
					        onClose: function(selectedDates) {
					            if (selectedDates.length === 2) {
					                selectedStartDate = selectedDates[0].toISOString().slice(0, 10);
					                selectedEndDate = selectedDates[1].toISOString().slice(0, 10);
					                const deptCode = $('#deptCodeSelect').val();
					                updateBarChart(deptCode, selectedStartDate, selectedEndDate);
					            }
					        }
					    });
					
					    // Dept_code 선택이 변경될 때마다 차트 업데이트
					    $('#deptCodeSelect').change(() => {
					        const deptCode = $('#deptCodeSelect').val();
					        // 변경된 부서 코드와 유지된 날짜로 차트를 업데이트
					        updateBarChart(deptCode, selectedStartDate, selectedEndDate);
					    });
					
					    // 초기 설정: 오늘 날짜로 차트 초기화
					    const initialDeptCode = $('#deptCodeSelect').val();
					    updateBarChart(initialDeptCode, selectedStartDate, selectedEndDate);
					});
					</script>
										
				</div>
			</div>
				
			</div>
			
			<script>
			$(function () {
			    const lineCtx = document.getElementById('lineChart').getContext('2d');
			    const lineChart = new Chart(lineCtx, {
			        type: 'line',
			        data: {
			            labels: [], // x축: 월
			            datasets: [{
			                label: '매출',
			                data: [], // y축: 매출 데이터
			                borderColor: 'orange',
			                backgroundColor: 'rgba(0, 0, 0, 0)', // 배경색을 투명하게 설정
			                fill: true,
			                tension: 0, // 둥글게 하지 않음
			                pointRadius: 5, // 기본 동그라미 크기
			                pointHoverRadius: 10, // 마우스를 올렸을 때 동그라미 크기
			                borderWidth: 5 // 선의 두께 설정
			            }]
			        },
			        options: {
			            responsive: true,
			            maintainAspectRatio: false,
			            plugins: {
			                legend: { display: true, position: 'top' },
			                tooltip: {
			                    callbacks: {
			                        label: (context) => {
			                            const value = context.raw;
			                            if (value >= 1000000000000) {
			                                return (value / 1000000000000).toFixed(2) + "조 원";
			                            } else if (value >= 100000000) {
			                                return (value / 100000000).toFixed(2) + "억 원";
			                            } else if (value >= 10000) {
			                                return (value / 10000).toFixed(2) + "만 원";
			                            } else {
			                                return value.toLocaleString() + "원";
			                            }
			                        }
			                    }
			                }
			            },
			            scales: {
			                x: { title: { display: false } }, // 월 표기 부분 제거
			                y: {
			                    title: { display: false }, // 매출 단위 표기 부분 제거
			                    ticks: {
			                        callback: function(value) {
			                            if (value >= 1000000000000) {
			                                return (value / 1000000000000).toFixed(2) + "조";
			                            } else if (value >= 100000000) {
			                                return (value / 100000000).toFixed(2) + "억";
			                            } else if (value >= 10000) {
			                                return (value / 10000).toFixed(2) + "만";
			                            } else {
			                                return value.toLocaleString();
			                            }
			                        }
			                    }
			                }
			            }
			        }
			    });
			
			    function updateLineChart(year) {
			        $.ajax({
			            url: `${contextPath}/chart/monthlySales.do`,
			            type: "POST",
			            data: JSON.stringify({ year: year }),
			            contentType: "application/json; charset=utf-8",
			            dataType: "json",
			            success: function (data) {
			                const months = [];
			                const sales = [];
			                data.forEach(item => {
			                    if (item.month) { // month 값이 존재하는 경우에만 처리
			                        months.push(item.month + "월");
			                        sales.push(item.sumValue);
			                    } else {
			                        console.error("month 값이 null입니다:", item); // 디버깅용으로 출력
			                    }
			                });
			
			                if (months.length === 0) {
			                    $('#lineChartCenterText').text("데이터가 없습니다.");
			                    return;
			                }
			
			                lineChart.data.labels = months;
			                lineChart.data.datasets[0].data = sales;
			                lineChart.update();
			
			                const totalSales = sales.reduce((sum, val) => sum + val, 0);
			                $('#lineChartCenterText').text("총 매출: " + totalSales.toLocaleString() + "원");
			            },
			            error: function (jqXHR, textStatus, errorThrown) {
			                console.error("AJAX 요청 실패:", { textStatus, errorThrown, response: jqXHR.responseText });
			                alert("데이터를 가져오는 데 실패했습니다.");
			            }
			        });
			    }
			
			    const initialYear = new Date().getFullYear();
			    $('#lineChart_yearSelect').val(initialYear); // 초기 값을 설정
			    updateLineChart(initialYear);
			
			    $('#lineChart_yearSelect').change(() => { // 연도 선택이 변경될 때마다 조회
			        const year = $('#lineChart_yearSelect').val();
			        if (year) updateLineChart(year);
			    });
			
			    // 현재 날짜 설정
			    const currentDate = new Date().toISOString().slice(0, 10);
			    $('#currentDate').text(currentDate);
			});
			</script>
        <!--/ 총매출 차트부분 -->

				<div style="display: flex; margin-top: 20px;">
        <!-- 사원목록 -->
        <div class="col-md-6 col-xxl-4 mb-1" style="height: 730px;">
          <div class="card h-100">
            <div class="card-header align-items-center" style="display: flex; gap: 15px;">
              <i class="ti ti-users ti-lg"></i>
              <a id="allMem" style="font-size: 18px;" href="${contextPath}/member/employeelistview.do">전직원 목록</a>
              <div id="deptList" style="display: flex; gap: 10px; flex-direction: column;"></div>
            </div>
            <div class="card-body" id="memberListDiv"> <!-- 전 사원의 리스트가 보여질영역 -->
            </div>
          </div>
        </div>
        <!--/ 사원목록 -->

				<!-- 공지사항 영역 (재운님 코드)-->
				<div class="card" style="width: 880px; margin-left: 20px;">
  				<div class="d-flex align-items-center">
   					<div style="margin: 20px;">
         			<a id="notice" class="btn btn-primary" style="color: white;" href="${contextPath}/notice/noticeList.do">공지사항</a>
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
  							</tr>
							</thead>
  						<tbody id="noticeListTbody">
    
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
	       <!--/ 공지사항 영역 -->       
	       </div>  
     </div>    
    
    
    
    
    
    
    
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
	
	    <script>
      // 메모작성 아이콘 클릭 시 열리는 새 메모 작성 모달
      function fnEnrollMemo(){
        var memoModal = new bootstrap.Modal(document.getElementById("enrollMemoModal"));

        memoModal.show();
      }

      function fnSelectMemo(){
        var memoModal = new bootstrap.Modal(document.getElementById("selectMemoModal"));

        memoModal.show();
      }

      function fnOpenMemoMenu(){
        const modal = document.getElementById('memoMenuModal');
        const modalDialog = modal.querySelector('.modal-dialog');

        // 클릭한 아이콘 위치를 기준으로 모달 위치 설정
        const icon = event.currentTarget;
        const rect = icon.getBoundingClientRect();
        modalDialog.style.top = `${rect.top + window.scrollY}px`;
        modalDialog.style.left = `${rect.right + 10 + window.scrollX}px`; // 오른쪽으로 10px 이동

        // 모달 표시
        const bootstrapModal = new bootstrap.Modal(modal);
        bootstrapModal.show();
      }

	  		
	  		
	  	
    </script>
    
		<script>

	  		
		  	// 출근 버튼 클릭시 (김동규)
		  	function fnClockIn(){
		  			
		  		
		  		const today = new Date();
		  		const clockInTime = today.toLocaleTimeString('en-GB', { hour12: false });
		  		
		  		
		  		$.ajax({
		  			url: '${contextPath}/wl/clockIn.do',
		  			type: 'POST',
		  			data: {
		  				clockInTime: clockInTime
		  					},
		  			success: function(res){
		  				alert(res + ' 출근 등록이 완료되었습니다.');
		  				
		  				window.location.reload();
		  			}
		  			
		  			})
		  		}
		  	
		  	// 퇴근 버튼 클릭시 (김동규)
		  	function fnClockOut(){
		  			
		  		
		  		const today = new Date();
		  		const clockOutTime = today.toLocaleTimeString('en-GB', { hour12: false });
		  		
		  		
		  		$.ajax({
		  			url: '${contextPath}/wl/clockOut.do',
		  			type: 'POST',
		  			data: {
		  				clockOutTime: clockOutTime
		  					},
		  			success: function(res){
		  				alert(res + '퇴근 등록이 완료되었습니다.');
		  				
		  				window.location.reload();
		  			}
		  			
		  			})
		  		}
		</script>
    	

   <script>
	  // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	 	
			const element = document.getElementById("dashboard");
			
		 	element.style.backgroundColor = "#958CF4";
		 	element.style.color = "white";
		 	element.classList.add("active");
	 	
		});

	    
	    // 메모 전체 리스트 조회(김동규)
	   	function fnMemoList(){
	   		
	   		const memNo = '${loginUser.getMemNo()}'; // 현재 로그인한 사원의 사번
	   		
		   		$.ajax({
		   			url : '${contextPath}/memo/memoList.do',
		   			type: 'POST',
		   			data: {memNo: memNo},
		   			success: function(res) {
		   			    let liEl = "<ul class='list-unstyled mb-2'>";

		   			    if (res.length == 0) {
		   			        // 메모가 없으면 문구 추가
		   			        liEl += "<li class='text-center'>등록된 메모가 없습니다.</li>";
		   			    } else {
		   			        // 메모가 있을 경우 목록 추가
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
	    		type: 'POST',
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
	    	
	    	let memNo = '${loginUser.getMemNo()}';
	    	let memoNo = $('#modifyMemoNo').val();
	    	let memoContent = $('#insertMemoInput_edit').val();

	    	$.ajax({
	    		url: '${contextPath}/memo/modifyMemo.do',
	    		type: 'POST',
	    		data: {
	    			memNo: memNo,
	    			memoNo: memoNo,
	    			memoContent: memoContent
	    			},
	    		success: function(res){
	    			fnMemoList();	// 수정 후 전체 리스트 조회 재실행
	    		}
	    	})
	    }
	    
	    function fnLoadDeptList() {
	        // 부서 목록 로드
	        $.ajax({
	            url: '${contextPath}/member/getDeptList.do', // 부서 목록 조회 API
	            type: 'POST',
	            success: function(list) {
	                let deptHtml = '<select id="deptSelect" class="select form-select form-select-lg select2-hidden-accessible" onchange="fnMemberList(this.value)" style="font-size: 16px;">';
	                deptHtml += '<option value="">전체</option>'; // "전체" 옵션 추가
	                for (let i = 0; i < list.length; i++) {
	                    deptHtml += '<option value="' + list[i].deptName + '">' + list[i].deptName + '</option>';
	                }
	                deptHtml += '</select>';
	                $('#deptList').html(deptHtml); // 부서 목록을 select로 추가
	            },
	            error: function() {
	                console.error('부서 목록을 가져오는 중 오류 발생');
	            }
	        });
	    }

	    function fnMemberList(deptName = '') {
	        // 기본값으로 전체 조회
	        let memNo = '${loginUser.getMemNo()}';

	        $.ajax({
	            url: '${contextPath}/member/selectAll_db.do',
	            type: 'POST',
	            data: { memNo: memNo, deptName: deptName },
	            success: function(res) {
	            	console.log(res);
	                let liEl = '<ul class="list-unstyled mb-0">';
	                for (let i = 0; i < res.length; i++) {
	                    liEl += '<li class="mb-4">'
	                        + '<div class="d-flex align-items-center">'
	                        + '<div class="avatar me-2">'
	                        + '<img src="${contextPath}' + res[i].profileURL + '" alt="Avatar" style="cursor: default;" class="rounded-circle"/>'
	                        + '</div>'
	                        + '<div class="me-2">'
	                        + '<h6 class="mb-0">' + res[i].memName + '</h6>'
	                        + '<small>' + res[i].email + '</small>'
	                        + '</div>'
	                        + '</div>'
	                        + '</li>';
	                }
	                liEl += '</ul>';
	                $('#memberListDiv').html(liEl);
	            },
	            error: function() {
	                console.error('사원 목록을 가져오는 중 오류 발생');
	            }
	        });
	    }


	    
	    // 공지사항 목록조회
	    function fnNoticeList(page){
	    	$.ajax({
	    		url: '${contextPath}/member/noticeList.do',
	    		type: 'POST',
	    		data: {page: page},
	    		success: function(res) {
		              let pi = res.pi; // 페이지 정보
			            let trEl = '';
			
			            // 데이터가 비어 있는 경우
			            if (!res || res.list.length == 0) {
			                trEl += '<tr>';
			                trEl += '<td colspan="6">조회된 게시글이 없습니다.</td>';
			                trEl += '</tr>';
			            } else {
			                let count = 1;
			                res.list.forEach((notice) => {
			                    let reverseCount = pi.listCount - (pi.currentPage - 1) * pi.boardLimit - (count - 1);
			
			                    
			                    trEl += '<tr data-boardno="' + notice.noticeNo + '">';
			                    trEl += '<td>' + reverseCount + '</td>';
			                    trEl += '<td>' + notice.memName + '</td>';
			                    trEl += '<td class="title">' + notice.noticeTitle;
			                    trEl += '</td>';
			                    trEl += '<td>' + notice.noticeRegistDT + '</td>';
			                    trEl += '<td>' + notice.noticeCount + '</td>';
			                    trEl += '</tr>';
			
			                    count++;
			                });
			            }
			
			            $('#noticeListTbody').html(trEl);
			            
			            // 페이징바 생성 및 업데이트
			            let pagingEl = '';
			            pagingEl += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="fnNoticeList(1);"><i class="ti ti-chevrons-left ti-sm"></i></a></li>';
			            pagingEl += '<li class="page-item prev ' + (pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnNoticeList(' + (pi.currentPage - 1) + ');"><i class="ti ti-chevron-left ti-sm"></i></a></li>';

			            for (let i = pi.startPage; i <= pi.endPage; i++) {
			                pagingEl += '<li class="page-item ' + (i == pi.currentPage ? 'active' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnNoticeList(' + i + ');">' + i + '</a></li>';
			            }

			            pagingEl += '<li class="page-item next ' + (pi.currentPage == pi.maxPage ? 'disabled' : '') + '"><a class="page-link" href="javascript:void(0);" onclick="fnNoticeList(' + (pi.currentPage + 1) + ');"><i class="ti ti-chevron-right ti-sm"></i></a></li>';
			            pagingEl += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="fnNoticeList(' + pi.maxPage + ');"><i class="ti ti-chevrons-right ti-sm"></i></a></li>';

			            $('#paging_area').html(pagingEl);			
	    		}
	    	})
	    }
	    function goToPage(pageNumber) {
	        window.location.href = "${contextPath}/member/noticeList.do?page=" + pageNumber;
	      }
	    
		// 결재 대기 갯수 조회
		function fnAppList(){
			
			let memNo = '${loginUser.getMemNo()}';
			
			$.ajax({
				url: '${contextPath}/member/selectAppList.do',
				type: 'POST',
				data: {memNo: memNo},
				success: function(res){
					
					$('#app_standby').html(res.A);
					
				}
			})
			
		}
		
		// 날씨 가져오기 (API)
		function loadWeather() {
			const city = 'Seoul';
			
			$.ajax({
				url: '${contextPath}/api/weather',
				type: 'GET',
				data: {city, city},
				success: function(res) {
					document.getElementById("cityName").textContent = res.name;
					document.getElementById("temperature").textContent = res.main.temp.toFixed(1) + " °C";
          document.getElementById("condition").innerHTML = '<img src="${contextPath}' + res.weather[0].description + '" style="width: 200px; height: 200px; margin-top: 30px;" />';
				},
				error: function(){
					console.log('날씨실패');
				}
			})
		}
		
	  // 현재 날짜 가져오기
	  const today = new Date();

	  const year = String(today.getFullYear()).slice(-2);
	  const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1 필요
	  const day = String(today.getDate()).padStart(2, '0');
	  
	  const formattedDate = year + '/' + month + '/' + day;
	  document.getElementById('todayDate').innerText = formattedDate;
	  
		
		// 페이지 로드시 실행시킬 함수
	window.onload = function(){
		
		fnNoticeList();			  // 공지사항 조회
  	fnMemberList();       // 전체 사원 리스트 조회
  	fnAppList();				  // 결재 대기중인 문서 갯수 조회.
 	  fnLoadDeptList(); 		// 부서 목록 로드
  	fnMemberList();   		// 전직원 목록 로드
  	loadWeather();   			// 날씨 조회
  	
	}
   </script>
	
	
	
</body>
</html>