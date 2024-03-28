package servlet.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import servlet.service.ServletService;

@Controller
public class StatisticController {
	@Resource(name = "ServletService")
	private ServletService servletService;
	
	@RequestMapping(value = "/Status.do")
	public String main() {
		return "main/main";
	}
	
}
