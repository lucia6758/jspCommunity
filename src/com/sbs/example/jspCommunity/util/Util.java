package com.sbs.example.jspCommunity.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Util {

	public static String getJasonText(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		String rs = "";
		try {
			rs = mapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return rs;
	}

}
