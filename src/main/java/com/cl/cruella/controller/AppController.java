package com.cl.cruella.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/app")
public class AppController {
	
	
	@GetMapping("/app_main.do")
	public void appMainPage() {
		
	}

}
