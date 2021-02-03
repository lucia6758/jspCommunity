package com.sbs.example.jspCommunity.service;

import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.ReplyDao;
import com.sbs.example.jspCommunity.dto.Reply;

public class ReplyService {
	private ReplyDao replyDao;

	public ReplyService() {
		replyDao = Container.replyDao;
	}

	public int doWrite(String relTypeCode, int relId, int loginedMemberId, String body) {
		return replyDao.doWrite(relTypeCode, relId, loginedMemberId, body);
	}

	public List<Reply> getForPrintRepliesByRTCAndRelId(String relTypeCode, int relId) {
		return replyDao.getForPrintRepliesByRTCAndRelId(relTypeCode, relId);
	}

	public Reply getReplyByReplyId(int id) {
		return replyDao.getReplyByReplyId(id);
	}

	public void doDelete(int id) {
		replyDao.doDelete(id);
	}

	public void doModify(Map<String, Object> args) {
		replyDao.doModify(args);

	}

}
