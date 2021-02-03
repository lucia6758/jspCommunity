package com.sbs.example.jspCommunity.container;

import com.sbs.example.jspCommunity.controller.AdmMemberController;
import com.sbs.example.jspCommunity.controller.UsrArticleController;
import com.sbs.example.jspCommunity.controller.UsrHomeController;
import com.sbs.example.jspCommunity.controller.UsrLikeController;
import com.sbs.example.jspCommunity.controller.UsrMemberController;
import com.sbs.example.jspCommunity.controller.UsrReplyController;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dao.AttrDao;
import com.sbs.example.jspCommunity.dao.LikeDao;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.dao.ReplyDao;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.AttrService;
import com.sbs.example.jspCommunity.service.EmailService;
import com.sbs.example.jspCommunity.service.LikeService;
import com.sbs.example.jspCommunity.service.MemberService;
import com.sbs.example.jspCommunity.service.ReplyService;

public class Container {

	public static ArticleService articleService;
	public static ArticleDao articleDao;
	public static MemberService memberService;
	public static MemberDao memberDao;
	public static UsrMemberController memberController;
	public static UsrArticleController articleController;
	public static AdmMemberController admMemberController;
	public static UsrHomeController homeController;
	public static EmailService emailService;
	public static AttrService attrService;
	public static AttrDao attrDao;
	public static UsrReplyController replyController;
	public static ReplyService replyService;
	public static ReplyDao replyDao;
	public static LikeService likeService;
	public static LikeDao likeDao;
	public static UsrLikeController likeController;

	static {
		likeDao = new LikeDao();
		replyDao = new ReplyDao();
		attrDao = new AttrDao();
		memberDao = new MemberDao();
		articleDao = new ArticleDao();

		likeService = new LikeService();
		replyService = new ReplyService();
		attrService = new AttrService();
		emailService = new EmailService();
		articleService = new ArticleService();
		memberService = new MemberService();

		likeController = new UsrLikeController();
		replyController = new UsrReplyController();
		admMemberController = new AdmMemberController();
		memberController = new UsrMemberController();
		articleController = new UsrArticleController();
		homeController = new UsrHomeController();
	}

}
