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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import servlet.service.ServletService;

@Controller
public class FileUploadController {
	
	@Resource(name = "ServletService")
	private ServletService servletService;
	
	@GetMapping("/read-json")
	public String readJson() throws IOException {
		URL url = new URL("http://localhost/json");
		HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
				
		BufferedReader br = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
		String line1;
		String result = "";
		while ((line1 = br.readLine()) != null) {
		    result += line1;
		}
		System.out.println("변환 전 : " + result);
		
		ObjectMapper mapper = new ObjectMapper();
		
		@SuppressWarnings("unchecked")
		Map<String, Object> map = mapper.readValue(result, Map.class);
		System.out.println("변환 후 " + map);
		//{result=[{name=홍길동, addr=서울, age=23}, {name=임길동, addr=한양, age=200}]}
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) map.get("result");
		
		for (Map<String, Object> m : resultList) {
			System.out.println("name : " + m.get("name"));
			System.out.println("age : " + m.get("age"));
			System.out.println("addr : " + m.get("addr"));
		}
		
		return "출력위치";
	}
	
	@GetMapping("/read-file")
	public String readfile() throws IOException {	
		return "fileUpload";
	}
	
	@PostMapping("/read-file")
	public @ResponseBody String readfile2(@RequestParam("upFile") MultipartFile upFile) throws IOException {
		System.out.println(upFile.getName());
		System.out.println(upFile.getContentType());
		System.out.println(upFile.getSize());
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		InputStreamReader isr = new InputStreamReader(upFile.getInputStream());
		BufferedReader br = new BufferedReader(isr);
		
		String line = null;
		while ((line = br.readLine()) != null) {
			Map<String, Object> m = new HashMap<>();
			String[] lineArr = line.split("\\|");
			m.put("date",			lineArr[0]); //사용_년월			date
			m.put("addr", 			lineArr[1]); //대지_위치			addr
			m.put("newAddr", 		lineArr[2]); //도로명_대지_위치		newAddr
			m.put("sigungu",		lineArr[3]); //시군구_코드			sigungu
			m.put("bubjungdong",	lineArr[4]); //법정동_코드			bubjungdong
			m.put("addrCode", 		lineArr[5]); //대지_구분_코드		addrCode
			m.put("bun", 			lineArr[6]); //번					bun
			m.put("si",				lineArr[7]); //지					si
			m.put("newAddrCode",	lineArr[8]); //새주소_일련번호		newAddrCode
			m.put("newAddr", 		lineArr[9]); //새주소_도로_코드		newAddr
			m.put("newAddrUnder", 	lineArr[10]); //새주소_지상지하_코드newAddrUnder
			m.put("newAddrBun",		lineArr[11]); //새주소_본_번		newAddrBun
			m.put("newAddrBun2",	lineArr[12]); //새주소_부_번		newAddrBun2
			m.put("usekwh",			lineArr[13]); //사용_량(KWh)		usekwh
			list.add(m);			
		}
		br.close();
		isr.close();
		
		return "fileUpload";
	}
	
}
