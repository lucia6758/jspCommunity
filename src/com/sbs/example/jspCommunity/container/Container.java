package com.sbs.example.jspCommunity.container;

import com.sbs.example.jspCommunity.controller.AdmMemberController;
import com.sbs.example.jspCommunity.controller.UsrArticleController;
import com.sbs.example.jspCommunity.controller.UsrMemberController;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.MemberService;

public class Container {

	public static ArticleService articleService;
	public static ArticleDao articleDao;
	public static MemberService memberService;
	public static MemberDao memberDao;
	public static UsrMemberController memberController;
	public static UsrArticleController articleController;
	public static AdmMemberController admMemberController;

	static {
		memberDao = new MemberDao();
		articleDao = new ArticleDao();

		articleService = new ArticleService();
		memberService = new MemberService();

		admMemberController = new AdmMemberController();
		memberController = new UsrMemberController();
		articleController = new UsrArticleController();
	}

}
