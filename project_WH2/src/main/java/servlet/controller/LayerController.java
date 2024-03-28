package servlet.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import servlet.service.ServletService;

@Controller
public class LayerController {
	@Resource(name = "ServletService")
	private ServletService servletService;

	/*
	 * @RequestMapping(value = "/main.do", method = RequestMethod.GET) public String
	 * mainTest(ModelMap model) throws Exception {
	 * 
	 * 
	 * return "main/main"; }
	 */
	
	
}
