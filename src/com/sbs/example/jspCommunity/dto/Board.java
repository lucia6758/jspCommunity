package com.sbs.example.jspCommunity.dto;

import java.util.Map;

import lombok.Data;

@Data
public class Board {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String code;

	public Board(Map<String, Object> map) {
		this.id = (int) map.get("id");
		this.regDate = (String) map.get("regDate");
		this.updateDate = (String) map.get("updateDate");
		this.name = (String) map.get("name");
		this.code = (String) map.get("code");
	}

}
