package com.cl.cruella.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.security.SecureRandom;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cl.cruella.dto.AlertDto;
import com.cl.cruella.dto.AppdocDto;
import com.cl.cruella.dto.BoardDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.NoticeDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.WorkLogDto;
import com.cl.cruella.service.AppService;
import com.cl.cruella.service.BoardService;
import com.cl.cruella.service.ChatServiceImpl;
import com.cl.cruella.service.MemberService;
import com.cl.cruella.service.NoticeService;
import com.cl.cruella.service.WorkLogService;
import com.cl.cruella.util.FileUtil;
import com.cl.cruella.util.PagingUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {
	
	private final MemberService memberService;
	private final JavaMailSender mailSender;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
	private final FileUtil fileUtil;
	private final PagingUtil pagingUtil;
	private final BoardService boardService;
	private final AppService appService;
	private final NoticeService noticeService;
	private final WorkLogService wlService;
	private final ChatServiceImpl chatServiceImpl;
	
	private static final SecureRandom SECURE_RANDOM = new SecureRandom();
	private static final String TEMP_PASSWORD_CHARACTERS =
	        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	      + "abcdefghijklmnopqrstuvwxyz"
	      + "0123456789";
	private static final int TEMP_PASSWORD_LENGTH = 10;
	
	// 대시보드(김동규)
	@GetMapping("/dashbord.do")
	public String dashbordPage(HttpSession session) {
		
		MemberDto m = (MemberDto)session.getAttribute("loginUser");
		
		MemberDto loginUser = memberService.selectMember(m);
		
		session.setAttribute("loginUser", loginUser); // 세션에 담긴 유저정보 업데이트
		
		return "redirect:/";
	}
	
	
	
	// 로그인(김동규)
	@PostMapping("/signin.do")
	public String signin(MemberDto m 	// memNo = '입력한 아이디', memPwd = '입력한 비밀번호'
								 , HttpSession session
								 , HttpServletResponse response
								 , HttpServletRequest request) throws IOException {	
		
		MemberDto loginUser = memberService.selectMember(m); // 입력값을 통한 실제정보 조회 결과
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		
		if(loginUser != null && bcryptPwdEncoder.matches(m.getMemPwd(), loginUser.getMemPwd())) {	// 암호화된 비밀번호 일치 조회
			
			List<AlertDto> alert = chatServiceImpl.alertList(loginUser);
			session.setAttribute("alert", alert);

			// 주민번호 뒷자리 '*'처리
			String maskedSSN = loginUser.getMemSSN();
			maskedSSN = maskedSSN.substring(0, maskedSSN.length() - 6) + "******"; 
			
			loginUser.setMemSSN(maskedSSN); // 주민번호 '*'처리 후 전달
			session.setAttribute("loginUser", loginUser); // 세션에 업데이트된 회원 정보 담기
			
			
			if("A".equals(loginUser.getStatus())) {	// 비밀번호 변경이 필요한 경우
				return "/member/resetPwd";			// 비밀번호 변경 페이지로
			}
			
			return "/dashboard";
			
		}else {
	        out.println("<script>alert('로그인에 실패하였습니다. 다시 시도해주세요.');");
	        out.println("location.href='" + request.getContextPath() + "/';</script>");
	        out.close();
		}
		
		return null;
	}
	
	// 로그아웃(김동규)
	@PostMapping("/logout.do")
	public String logout(HttpSession session, HttpServletRequest request) {
		
		session.invalidate(); // 세션 초기화
		
		return "redirect:/";
		
	}
	
	
	// 비밀번호변경(김동규)
	@PostMapping("/resetPwd.do")
	public String newPwdCheck(String newPwd, String checkNewPwd, HttpSession session,
			HttpServletResponse response) throws IOException {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

		if(loginUser == null) {
			return "redirect:/";
		}

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		if(newPwd == null || newPwd.isBlank() || checkNewPwd == null || !newPwd.equals(checkNewPwd)) {
			out.println("<script>alert('새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.'); history.back();</script>");
			out.close();
			return null;
		}

		int result = memberService.resetPwd(bcryptPwdEncoder.encode(newPwd), loginUser.getMemNo()); // 비밀번호 변경 실행 (암호화)

		out.println("<script>");
		if(result > 0) { // 변경 성공
			return "/member/pwdResetSuccess";
		}else {
			out.println("history.back();");
		}
		out.println("</script>");
		return "/";
	}

	 // 마이페이지 - 내정보 페이지로(김동규)
	 @GetMapping("/myinfo.do")
	 public void myinfo() {}
	 
	 // 소속 팀 전체 리스트 조회(김동규)
	 @PostMapping("/teamList.do")
	 @ResponseBody
	 public List<MemberDto> teamList(MemberDto m) {
		 
		 List<MemberDto> list = memberService.selectTeamList(m);
		 
		 return list;
	 }
	 
	 @GetMapping("/findPwd.do")
	 public void findPwd() {};
	 
	 
	 // 임시 비밀번호 발급(김동규)
	 @PostMapping("/sendCode.do")
	 @ResponseBody
	 public String sendCode(String email) {
		 
		 /* SMTP(GMAIL) 참고 블로그
		  * https://velog.io/@hellocdpa/220319-%EC%9E%84%EC%8B%9C%EB%B9%84%EB%B0%80%EB%B2%88%ED%98%B8-
		  * %EC%9D%B4%EB%A9%94%EC%9D%BC%EB%A1%9C-%EB%B3%B4%EB%82%B4%EB%8A%94-%EA%B8%B0%EB%8A%A5-
		  * %EA%B5%AC%ED%98%84
		  */
		 
		 // 1) 사용자가 입력한 이메일이 등록 되어있는지 
		 	MemberDto m = memberService.checkEmail(email); // 등록된 이메일이 있는지 조회
		 
		 	if(m != null) { // 등록된 이메일이 있을 경우
			 
		 // 2) 임시 비밀번호 생성 -> 해당 비밀번호로 회원정보 update
			 
		 	// 임시 비밀번호 생성
		 		String str = generateTemporaryPassword();
		 	// 임시 비밀번호로 변경 (암호화)
			 memberService.updatePwd(email, bcryptPwdEncoder.encode(str));	
		     
		 // 3) 메일 발송
			 SimpleMailMessage message = new SimpleMailMessage();	
			 
			 // 메일 내용
			 message.setTo(email);
			 message.setSubject("Cruella 임시 비밀번호 발급 메일입니다.");
			 message.setText("안녕하세요. 요청하신 임시비밀번호 안내 메일입니다. 회원님의 임시 비밀번호는  " + str + "  입니다."
	 					+ " 해당 번호로 로그인 후 새로운 비밀번호로 변경 해주세요.");
			 message.setFrom("hiwinter99@gmail.com");
			 message.setReplyTo("hiwinter99@gmail.com");
			 
			 mailSender.send(message); // 담아놓은 메일 내용 발송
			 
			 return "YYY";
			 
		 }	else {	// 등록된 이메일이 없을 경우
			 return "NNN";
		 }
		 
	 }
	 
	 // SecureRandom을 이용한 임시 비밀번호 생성 메서드
	 private String generateTemporaryPassword() {
		    StringBuilder password = new StringBuilder(TEMP_PASSWORD_LENGTH);

		    for (int i = 0; i < TEMP_PASSWORD_LENGTH; i++) {
		        int index =
		                SECURE_RANDOM.nextInt(TEMP_PASSWORD_CHARACTERS.length());

		        password.append(TEMP_PASSWORD_CHARACTERS.charAt(index));
		    }

		    return password.toString();
		}
	 
	 // 이메일 발송 성공 화면(김동규)
	 @GetMapping("/sentEmail.do")
	 public String sentEmail(String email, Model model) {
		 
		 model.addAttribute("email", email);
		 
		 return "/member/sentEmail";
	 }
	 
	 // 전자서명 저장(김동규)
	 @PostMapping("/saveSign.do")
	 @ResponseBody
	 public String saveSign(MemberDto m, HttpSession session) {
		 
		 MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		 m.setMemNo(loginUser.getMemNo());
		 // Base64 인코딩
		 String base64Data = m.getSignPath().split(",")[1];
		 m.setSignPath(base64Data);
		 
		 int result = memberService.saveSignPath(m); // 전자서명 저장
		 
		 if(result > 0) { // 저장 성공시
			 
	         // 세션내의 유저정보(저장 혹은 변경된 전자서명) 업데이트
	         loginUser.setSignPath(base64Data); // 세션에도 Base64 본문만 저장
	         session.setAttribute("loginUser", loginUser);
		 
			 return "YYY";
		 }else {
			 return "NNN";
		 }
		 
	 }
	 
	 // 마이페이지 - 근태관리 페이지로(김동규)
	 @GetMapping("/myinfo_workLog.do")
	 public void myinfoWorkLog(HttpSession session, Model model) {
		 
		 MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		 String memNo = loginUser.getMemNo();
			
		 List<WorkLogDto> list = wlService.allWorkTime(memNo); // 해당 유저의 출퇴근 기록 조회
		 model.addAttribute("wlList", list);
		 
		 MemberDto m = memberService.selectMember(loginUser);
		 session.setAttribute("loginUser", m);
	 }
	 
	 // 소속팀 게시판 리스트 조회(김동규 - 재운님 코드 활용)
	 @PostMapping("/boardList.do")
	 @ResponseBody
     public Map<String, Object> boardList(@RequestParam(value = "page", defaultValue = "1") int currentPage, Model model, HttpSession session) {
		 
         MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
         String deptCode = loginUser.getDeptCode();
        
         int listCount = boardService.selectBoardListCount(deptCode);

         PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);

         Map<String, Object> params = new HashMap<>();
         params.put("pi", pi);
         params.put("deptCode", deptCode);

         List<BoardDto> list = boardService.selectBoardList(params);
         params.put("list", list);

         return params;
     }
	 
	 // 공지사항 조회 (김동규 - 재운님 코드 활용)
	 @PostMapping("/noticeList.do")
	 @ResponseBody
	 public Map<String, Object> noticeList(@RequestParam(value = "page", defaultValue = "1") int currentPage, Model model, HttpSession session){
		 
         MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
         String deptCode = loginUser.getDeptCode();

         String loggedInDeptCode = deptCode != null ? deptCode : loginUser.getDeptCode();
        
         Map<String, Object> params = new HashMap<>();
         params.put("deptCode", loggedInDeptCode);

         int listCount = noticeService.selectNoticeListCount(params);

         PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
         params.put("pi", pi);

         List<NoticeDto> list = noticeService.selectNoticeList(params);
         params.put("list", list);
         

         return params;		 
	 }
	 
	 // 내 결재 문서함 조회(김동규)
	 @PostMapping("/selectAppList.do")
	 @ResponseBody
	 public Map<String, Integer> selectAppList(String memNo) {
		 
	     // 상태별 개수 저장
	     Map<String, Integer> statusCounts = new HashMap<>();
	     statusCounts.put("A", appService.selectStandbyCount(memNo));  // 대기
	     statusCounts.put("B", appService.selectProgressCount(memNo)); // 진행
	     statusCounts.put("C", appService.selectSuccessCount(memNo));  // 완료
	     
	     return statusCounts;
	 }
	 
	 // 휴가신청 목록 조회(김동규)
	 @PostMapping("/vacList.do")
	 @ResponseBody
	 public Map<String, Object> selectVacList(String memNo, @RequestParam(value = "page", defaultValue = "1") int currentPage, Model model) {
		 
		 // 페이징에 활용
		 int listCount = memberService.selectVacListCount(memNo); // 목록의 전체 개수
		 PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 5);
		 
         Map<String, Object> params = new HashMap<>();
         params.put("pi", pi);
         params.put("memNo", memNo);

         List<AppdocDto> list = memberService.selectVacList(params);
         params.put("list", list);
         return params;
	 }
	 
	 // 부서명 조회(김동규)
	 @PostMapping("/getDeptList.do")
	 @ResponseBody
	 public List<DeptDto> getDeptList() {
		 
		 List<DeptDto> list = memberService.getDeptList();
		 
		 return list;
	 }
	 
	 // 전체 사원 조회(김동규)
	 @PostMapping("/selectAll_db.do")
	 @ResponseBody
	 public List<MemberDto> selectAllMember(String memNo, String deptName) {
		 
		 // 선택된 부서명에 포함된 유저 전체 조회
		 if(deptName == null || deptName.trim().isEmpty()) { // 선택된 부서명이 없을경우 전체 조회
			 List<MemberDto> list = memberService.selectAllMember(memNo);
			 
			 return list;
		 }else {
			 List<MemberDto> list = memberService.selectAllMemberDept(memNo, deptName);
			 
			 return list;
		 }
		 
	 }
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 // 사원등록페이지로딩시사번자동생성(이예빈)
	 @GetMapping("/signup.do")
	 public void signup(Model model) {
		 String memNo = memberService.memberNo();
		 String memPwd = "111111";
		 model.addAttribute("memNo",memNo);
		 model.addAttribute("memPwd",memPwd);
	 }
	 

	
	// 사원등록(이예빈)
	@PostMapping("/insert.do")
	public String insertMember(MemberDto m, RedirectAttributes rd, @RequestParam("uploadFile") MultipartFile uploadFile) {
		log.debug("m{}", m);
		if( m.getMemPwd()== null) {
			m.setMemPwd("111111");
		} 
		
		m.setMemPwd( bcryptPwdEncoder.encode(m.getMemPwd()) );
		
		// 파일 업로드 처리
		
	    if (!uploadFile.isEmpty()) {
	        // 파일 업로드 수행
	        Map<String, String> map = fileUtil.fileupload(uploadFile, "profile");
	        String filePath = map.get("filePath") + "/" + map.get("filesystemName");

	        // MemberDto에 프로필 URL 설정
	        m.setProfileURL(filePath);
	    } else {
	        m.setProfileURL(null); // 파일이 없을 경우 null로 설정
	    }
		
		int result = memberService.insertMember(m);
			
		if(result > 0) {
			rd.addFlashAttribute("alertMsg", "성공적으로 회원가입 되었습니다");
			
			// 급여테이블에 insert됨 
			m.setPension((int)(m.getSalary()*0.045)); // 기본급에 공제항목 계산한거
			m.setHealth((int)(m.getSalary()*0.039));
			m.setCare((int)(m.getHealth()*0.05));
			m.setEmployment((int)(m.getSalary()*0.09));  
			m.setTotalSalary(m.getSalary() - (m.getPension() + m.getHealth() + m.getCare() + m.getEmployment()));
			
			log.debug("m:{}", m);
			result = memberService.insertPayment(m);
			
			
			
		}else {
			rd.addFlashAttribute("alertMsg", "회원가입실패");
	
		}
			 return "redirect:/member/employeelistview.do";
	
		}
	
	// 사원조회페이지로redirect(예빈)
	@GetMapping("/employeelistview.do")
	public String employeelistview(
	    @RequestParam(value = "page", defaultValue = "1") int currentPage,
	    Model model
	) {
	    // 1. 전체 사원 수 가져오기
	    int listCount = memberService.getMemberCount();

	    // 2. 페이징 계산
	    PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);

	    // 3. 페이징된 사원 목록 가져오기
	    List<MemberDto> list = memberService.getPagedMemberList(pi);

	    // 4. 모델에 데이터 추가
	    model.addAttribute("pi", pi); // 페이징 정보
	    model.addAttribute("list", list); // 사원 목록
	    // 5. 뷰 이름 반환
	    return "member/employeelistview"; // employee/employeelistview.jsp
	}

	

	
	// 회원정보수정페이지 이동 (이예빈)
	@GetMapping("/modifydelete.do")
	public String modifyDelete(@RequestParam("memNo") String memNo, Model model) {
	    // 1. memNo로 해당 사원 정보 조회
	    MemberDto member = memberService.selectMemberByNo(memNo);

	    // 2. 조회된 정보를 모델에 담아 수정 페이지로 전달
	    model.addAttribute("member", member);

	    // 3. 수정 페이지 뷰 이름 반환
	    return "member/modifydelete";
	}

	// 회원정보수정
	@PostMapping("/updateMember.do")
	public String updateMember(MemberDto m, RedirectAttributes rd, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile ) {
		
	    // 1. 파일 업로드 처리
	    if (!uploadFile.isEmpty()) {
	        // 파일 업로드 수행
	        Map<String, String> map = fileUtil.fileupload(uploadFile, "profile");
	        String filePath = map.get("filePath") + "/" + map.get("filesystemName");

	        // MemberDto에 프로필 URL 설정
	        m.setProfileURL(filePath);
	    } else {
	        m.setProfileURL(null); // 파일이 없을 경우 null로 설정
	    }
		// 사원정보 업데이트
		int result = memberService.updateMember(m);
		
		if(result > 0) {
			rd.addFlashAttribute("alertMsg", "성공적으로 정보수정이 되었습니다.");
		}else {
			rd.addFlashAttribute("alertMsg", "정보수정에 실패하였습니다.");
			
		}
		
		return "redirect:/member/employeelistview.do";
	}
	
	
	// 퇴사 처리 
	@PostMapping("/retire.do")
	public String retireMember(@RequestParam("memNo") String memNo, RedirectAttributes redirectAttributes) {
	    try {
	        // 1. memNo로 상태를 'N'으로 변경
	    	memberService.updateMemberRetire(memNo);

	        // 2. 성공 메시지 설정
	        redirectAttributes.addFlashAttribute("message", "퇴사 처리가 완료되었습니다.");
	    } catch (Exception e) {
	        // 3. 실패 메시지 설정
	        redirectAttributes.addFlashAttribute("errorMessage", "퇴사 처리 중 오류가 발생했습니다.");
	        e.printStackTrace();
	    }

	    // 4. 목록 페이지로 리다이렉트
	    return "redirect:/member/employeelistview.do";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	// 급여지급페이지
	@GetMapping("/salarypayment.do")
	public void salarypayment(Model model) {
		
		
		List<MemberDto> list = memberService.salarypaymentList();
		
		
		model.addAttribute("list", list);
		
		
		
	}
	
	
	// 급여지급페이지
	@GetMapping("/salarypayment2.do")
	public String salarypayment2(Model model,@RequestParam String provide) {
		
		Map<String,Object> salDate = new HashMap<>();
	
		salDate.put("provide", provide);
		
		
		List<MemberDto> list = memberService.salarypaymentList2(salDate);
		
		
		model.addAttribute("list", list);
		
		return "member/salarypayment";
		
		
	}
	
	
	
	
	// 급여지급버튼
	@ResponseBody
	@PostMapping("/payBtn.do")
	public int payBtn(@RequestBody Map<String,List<String>> request) {
		List<String> memNos = request.get("memNo");
		int result = memberService.payBtn(memNos);
		
		return result;
		
		
	}
	
	@ResponseBody
	@PostMapping("/salaryByDate.do")
	public List<MemberDto> getSalaryByDate(@RequestBody Map<String, Integer> params) {
	    int year = params.get("year");
	    int month = params.get("month");
	    return memberService.getSalaryByDate(year, month);
	}
	
	
	
	


	
	
	// 출퇴근조회(이예빈)
	@GetMapping("/checkinrecordview.do")
	public void checkinrecodeview() {}
	
	// 근무시간조회(이예빈)
	@GetMapping("/workhoursview.do")
	public void workhoursview(HttpSession session, Model model) {
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		List<WorkLogDto> wl = memberService.workhoursview(memNo);
		model.addAttribute("memNo", wl);
		
		
		
		
	}	

	
	
	// 급여명세표(이예빈)
	
	@PostMapping("/paystub.do")
	public String paystub(Model model,@RequestParam String memNo) throws ParseException {

		MemberDto list = memberService.paystub(memNo);
		

		
		model.addAttribute("list", list);

		return "/member/paystub";
	}
	
	// 폰번호유효성
	@ResponseBody
	@PostMapping("/checkPhone.do")
	public int checkPhone(@RequestParam("phone") String phone) {
		return memberService.checkPhone(phone);
	}

	// 급여내역확인
	@GetMapping("/checksalary.do")
	public void checksalary(HttpSession session, Model model) {
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		
		MemberDto cs = memberService.checksalary(memNo);
		
		
		model.addAttribute("cs", cs);
	}

	 
}
