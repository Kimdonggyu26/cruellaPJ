package com.cl.cruella.service;

import java.util.List;

import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.MemoDto;

public interface MemoService {
	
	// 메모 리스트 조회 (전체)
	List<MemoDto> selectMemoList(String memNo);

	// 메모 작성
	int insertMemo(MemoDto memo);
	
	// 메모 조회 (메모번호 활용)
	MemoDto selectMemoByNo(MemoDto memo);
	
	// 메모 수정
	int modifyMemo(MemoDto memo);
	
	// 메모 삭제
	int deleteMemo(MemoDto memo);
	
	
}
