package com.cl.cruella.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.MemoDto;
import com.cl.cruella.service.MemoService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/memo")
public class MemoController {
	
	private final MemoService memoService;
	
	// 해당 유저의 메모 전체 조회(김동규)
	@GetMapping("/memoList.do")
	@ResponseBody
	public List<MemoDto> memoList(HttpSession session) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		// List<MemoDto> list = memoService.selectMemoList(memNo);	// 사번을 활용 -> 모든 메모 정보 조회
		
		return memoService.selectMemoList(loginUser.getMemNo());
		// return list;
	}
	
	// 메모 등록(김동규)
	@PostMapping("/insertMemo.do")
	@ResponseBody
	public int insertMemo(MemoDto memo, HttpSession session) {

		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		memo.setMemNo(loginUser.getMemNo());
		
		int result = memoService.insertMemo(memo);
		
		return result;
	}
	
	// 메모 상세조회
	@GetMapping("/selectMemo.do")
	@ResponseBody
	public MemoDto selectMemo(int memoNo, HttpSession session) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		
		MemoDto memo = new MemoDto();
		memo.setMemNo(loginUser.getMemNo());
		memo.setMemoNo(memoNo);
		
		return memoService.selectMemoByNo(memo);
	}
	
	// 메모 수정(김동규)
	@PostMapping("/modifyMemo.do")
	@ResponseBody
	public int modifyMemo(MemoDto memo, HttpSession session) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		memo.setMemNo(loginUser.getMemNo());
		
		MemoDto m = memoService.selectMemoByNo(memo);
		String before = m.getMemoContent(); 	// 수정 전 메모내용
		
		String after = memo.getMemoContent();   // 수정 후 메모내용
		
		int result = 0;
		if(!before.equals(after)) { // 내용이 변경 되었을 경우
			
			result = memoService.modifyMemo(memo);
		}
		
		return result;
	}
	
	// 메모삭제(김동규)
	@PostMapping("/deleteMemo.do")
	@ResponseBody
	public int deleteMemo(int memoNo, HttpSession session) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		
		MemoDto memo = new MemoDto();
		memo.setMemoNo(memoNo);
		memo.setMemNo(loginUser.getMemNo());
		
		return memoService.deleteMemo(memo);
	}

}











