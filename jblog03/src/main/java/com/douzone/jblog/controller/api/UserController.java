package com.douzone.jblog.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.douzone.jblog.service.UserService;
import com.douzone.jblog.vo.UserVo;
import com.douzone.mysite.dto.JsonResult;

@RestController("userApiController")
@RequestMapping("/user/api")
public class UserController {
	@Autowired
	private UserService userService;
	
//	@ResponseBody
//	@RequestMapping("/checkemail")
	@GetMapping("/checkid")
	public JsonResult checkeId(
			@RequestParam(value = "id", required = true, defaultValue = "") String id) {
		UserVo userVo = userService.getUser(id);
		
		return JsonResult.success(userVo != null);
//		jsonResult.setResult("ok");
	}
}
