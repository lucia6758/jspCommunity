package com.sbs.example.jspCommunity.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Reply;
import com.sbs.example.jspCommunity.service.ReplyService;
import com.sbs.example.jspCommunity.util.Util;

public class UsrReplyController extends Controller {
	private ReplyService replyService;

	public UsrReplyController() {
		replyService = Container.replyService;
	}

	public String doWrite(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String relTypeCode = req.getParameter("relTypeCode");
		int relId = Util.getAsInt(req.getParameter("relId"), 0);
		String body = req.getParameter("body");

		if (Util.isEmpty(body)) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		if (relId == 0) {
			return msgAndBack(req, "게시글 번호를 입력해주세요.");
		}

		Article article = Container.articleService.getForPrintArticle(relId);

		if (article == null) {
			return msgAndBack(req, relId + "번 게시물이 존재하지 않습니다.");
		}

		int id = replyService.doWrite(relTypeCode, relId, loginedMemberId, body);

		return msgAndReplace(req, id + "번 댓글이 작성되었습니다.", String.format("../article/detail?id=%d", relId));
	}

	public String doDelete(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "댓글 번호를 입력해주세요.");
		}

		Reply reply = replyService.getReplyByReplyId(id);

		if (reply == null) {
			return msgAndBack(req, "존재하지 않는 댓글입니다.");
		}

		if (reply.getMemberId() != loginedMemberId) {
			return msgAndBack(req, "삭제할 권한이 없습니다.");
		}

		replyService.doDelete(id);

		return msgAndReplace(req, id + "번 댓글이 삭제되었습니다.", String.format("../article/detail?id=%d", reply.getRelId()));
	}

	public String modify(HttpServletRequest req, HttpServletResponse resp) {
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "댓글 번호를 입력해주세요.");
		}

		Reply reply = replyService.getReplyByReplyId(id);

		if (reply == null) {
			return msgAndBack(req, id + "번 댓글이 존재하지 않습니다.");
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (reply.getMemberId() != loginedMemberId) {
			return msgAndBack(req, "수정할 권한이 없습니다.");
		}

		req.setAttribute("reply", reply);
		return "usr/reply/modify";
	}

	public String doModify(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "댓글 번호를 입력해주세요.");
		}

		Reply reply = replyService.getReplyByReplyId(id);

		if (reply == null) {
			return msgAndBack(req, "존재하지 않는 댓글입니다.");
		}

		if (reply.getMemberId() != loginedMemberId) {
			return msgAndBack(req, "수정할 권한이 없습니다.");
		}

		String body = req.getParameter("body");

		if (Util.isEmpty(body)) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		Map<String, Object> modifyArgs = new HashMap<>();
		modifyArgs.put("id", id);
		modifyArgs.put("body", body);

		replyService.doModify(modifyArgs);

		return msgAndReplace(req, id + "번 댓글이 수정되었습니다.", String.format("../article/detail?id=%d", reply.getRelId()));
	}

}
