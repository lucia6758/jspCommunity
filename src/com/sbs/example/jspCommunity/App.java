package com.sbs.example.jspCommunity;

public class App {

	public static String getSite() {
		return "GREEN AROUND";
	}

	public static String getLoginUrl() {
		return "http://" + getSiteDomain() + ":" + getSitePort() + "/" + getContextName() + "/usr/member/login";
	}

	private static String getContextName() {
		return "jspCommunity";
	}

	private static int getSitePort() {
		return 8083;
	}

	private static String getSiteDomain() {
		return "localhost";
	}

	public static String getMainUrl() {
		return "http://" + getSiteDomain() + ":" + getSitePort() + "/" + getContextName() + "/usr/home/main";
	}

}
