package com.cl.cruella.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cl.cruella.dto.CalendarDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.WorkLogDto;
import com.cl.cruella.service.MemberService;
import com.cl.cruella.service.WorkLogService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wl")
public class WorkLogController {
	
	private final WorkLogService wlService;
	private final MemberService memberService;


	// 출근(김동규)
	@PostMapping("/clockIn.do")
	@ResponseBody
	public String clockIn(WorkLogDto workLog, HttpSession session) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		workLog.setMemNo(loginUser.getMemNo());
	    
	    int result = wlService.clockIn(workLog); // 출근 정보 등록
	    
	    // 등록된 출근 정보를 포함하여 세션에 업데이트
	    MemberDto m = memberService.selectMember(loginUser);
	    session.setAttribute("loginUser", m);
		
		return workLog.getClockInTime();
	}
	
	// 퇴근(김동규)
	@PostMapping("/clockOut.do")
	@ResponseBody
	public String clockOut(WorkLogDto workLog, HttpSession session) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		workLog.setMemNo(loginUser.getMemNo());
		
		String clockInTime = wlService.selectClockInTime(workLog.getMemNo()); // 출근 시간 가져오기
		String clockOutTime = workLog.getClockOutTime();					  // 퇴근 시간 가져오기
		
	    int coHour = Integer.parseInt(clockOutTime.split(":")[0]); // 퇴근 시간 ??시 추출
	    int ciHour = Integer.parseInt(clockInTime.split(":")[0]);  // 출근 시간 ??시 추출
		
	    workLog.setWorkTime(coHour - ciHour); // 오늘의 근무 시간 저장 (시간단위)
	    
	    // 출퇴근 시간을 활용하여 근태 상태 변경
		if(coHour < 18) { // 조퇴
			
			workLog.setStatus("E");
			int result = wlService.clockOut(workLog);
			
		}else if(ciHour < 9) { // 정상
			
			workLog.setStatus("N");
			int result = wlService.clockOut(workLog);
			
		}else { // 지각
			
			workLog.setStatus("L");
			int result = wlService.clockOut(workLog);
			
		}
		
		// 변경된 근태 상태를 포함하여 세션에 업데이트
		loginUser.setWlStatus(workLog.getStatus());
	    session.setAttribute("loginUser", loginUser);
	    
		return clockOutTime;
		
	}
	
	// 근태기록조회(김동규)
	@PostMapping("/loadWorkLog.do")
	@ResponseBody
	public List<CalendarDto> loadWorkLog(String memNo){
		
		List<CalendarDto> list = wlService.loadWorkLog(memNo); //근태기록(출퇴근시간 조회)
		
		return list;
	}
	
	// 스케줄러 활용 결근처리 (김동규)
	@Scheduled(cron="0 0 23 * * MON-FRI")
	public void updateAbsences() {
		
		wlService.updateAbsences(); // 결근자 update(출근기록 O, 퇴근기록 X)
		wlService.insertAbsences(); // 결근자 insert(출근기록 X, 퇴근기록 X)
	}

	// 출퇴근조회(이예빈)
	@GetMapping("/checkinrecordview.do")
	public String checkinrecordview(HttpSession session, Model model) {
		
		
		Map<String,Object> wlDate = new HashMap<>();
		
		String memNo = ((MemberDto) session.getAttribute("loginUser")).getMemNo();
		
		
		wlDate.put("memNo", memNo);
		
		
		List<WorkLogDto> wd = wlService.checkinrecordview(wlDate);
		
		
		
		model.addAttribute("workLog", wd);
		
		return "/member/checkinrecordview";
		
	}
	
	
	
	
	
	
	
	@PostMapping("/checkinrecordview2.do")
	public String checkinrecordview2(Model model,
							    String year,
								String month,
								String memNo) {
		
		log.debug("year:{}", year);
		log.debug("month:{}", month);
		log.debug("memNo:{}", memNo);
		
		
		Map<String,Object> wlDate = new HashMap<>();
		
		wlDate.put("year", year);
		wlDate.put("month", month);
		wlDate.put("memNo", memNo);
		
		List<WorkLogDto> list = wlService.checkinrecordview2(wlDate);
		
		log.debug("list:{}", list);
		
		model.addAttribute("workLog", list);
		
		return "/member/checkinrecordview";
	}
	
	
	
	
	
}
