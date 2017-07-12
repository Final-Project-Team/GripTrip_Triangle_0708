package spring.trip.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

 

@Controller
public class FileDownloadController {
	/*private String path
	="C:\\HNC\\shr\\SpringPro3\\eclipse\\workspace\\SpringMVC18_Board_FileUpload\\src\\main\\webapp\\upload\\";*/
 
	@RequestMapping("pdfDownload.do")
	public ModelAndView pdfDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap map = new HashMap();
		map.put("path", "C:\\HNC\\shr\\");
		
		return new ModelAndView("downloadView",map);
	}
}

