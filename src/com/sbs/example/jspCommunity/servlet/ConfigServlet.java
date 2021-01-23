package com.sbs.example.jspCommunity.servlet;

import java.io.InputStream;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.service.EmailService;
import com.sbs.example.jspCommunity.util.Util;

public abstract class ConfigServlet extends HttpServlet {
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);

		ServletContext context = getServletContext();
		InputStream inStream = context.getResourceAsStream("/META-INF/config.json");
		Map<String, Object> configMap = Util.getJsonMapFromFile(inStream);

		String gmailId = (String) configMap.get("gmailId");
		String gmailPw = (String) configMap.get("gmailPw");

		EmailService emailService = Container.emailService;
		emailService.init(gmailId, gmailPw, "jspCommunity", "jspCommunity");
	}
}