package servlet.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import servlet.service.ServletService;

@Controller
public class ServletController {
	@Resource(name = "ServletService")
	private ServletService servletService;

	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String mainTest(ModelMap model) throws Exception {

		List<Map<String, Object>> getSd = servletService.getSd();
		
		model.addAttribute("getSd", getSd);
		System.out.println("getsd :" + getSd);
		return "main/main";
	}

	
	@RequestMapping(value = "/sd.do", method =  RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> sgg(@RequestParam("sd") String sd) {
		System.out.println("선택 : " + sd);

		List<Map<String, Object>> getlist = servletService.sggList(sd);
		System.out.println("getlist :" + getlist);
		return getlist;
	}
	
	@RequestMapping(value = "/sgg.do", method =  RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> bjd(@RequestParam("sgg") String sgg) {
		System.out.println("선택 : " + sgg);

		List<Map<String, Object>> bjdlist = servletService.bjdList(sgg);

		System.out.println(bjdlist);
		return bjdlist;
	}
	
}
