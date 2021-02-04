package com.sbs.example.jspCommunity.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.App;
import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.util.Util;

public class MemberService {
	private MemberDao memberDao;
	private EmailService emailService;
	private AttrService attrService;

	public MemberService() {
		memberDao = Container.memberDao;
		emailService = Container.emailService;
		attrService = Container.attrService;
	}

	public List<Member> getForPrintMembers() {
		return memberDao.getForPrintMembers();
	}

	public int join(Map<String, Object> joinArgs) {
		int id = memberDao.join(joinArgs);

		setLoginPwModifiedNow(id);

		return id;
	}

	private void setLoginPwModifiedNow(int id) {
		attrService.setValue("member__" + id + "__extra__loginPwModifiedDate", Util.getNowDateStr(), null);

	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int memberId) {
		return memberDao.getMemberById(memberId);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}

	public ResultData sendTempLoginPwToEmail(Member actor) {
		// 메일 제목과 내용
		String siteName = App.getSite();
		String siteLoginUrl = App.getLoginUrl();
		String siteMainUrl = App.getMainUrl();
		String title = "[" + siteName + "] 임시 비밀번호입니다";
		String tempPassword = Util.getTempPassword(6);
		String body = "<h1>임시 비밀번호 :" + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUrl + "\" target=\"_blank\">사이트 바로가기</a>";
		body += "<a href=\"" + siteLoginUrl + "\" target=\"_blank\">로그인 바로가기</a>";

		Map<String, Object> rs = new HashMap<>();

		// 메일 발송
		int sendRs = emailService.send(actor.getEmail(), title, body);

		if (sendRs != 1) {
			return new ResultData("F-1", "메일 발송에 실패하였습니다. 다시 시도해주십시오.");
		}

		// 고객의 비번을 임시비번으로 변경
		setTempPassword(actor, tempPassword);

		String resultMsg = String.format("%s (으)로 임시 비밀번호가 발송되었습니다.", actor.getEmail());

		return new ResultData("S-1", resultMsg, "email", actor.getEmail());
	}

	private void setTempPassword(Member actor, String tempPassword) {
		Map<String, Object> modifyParam = new HashMap<>();
		modifyParam.put("id", actor.getId());
		modifyParam.put("loginPw", Util.sha256(tempPassword));
		modify(modifyParam);

		attrService.setValue("member__" + actor.getId() + "__extra__isUsingTempPassword", "1", null);
	}

	public void modify(Map<String, Object> param) {
		if (param.get("loginPw") != null) {
			setLoginPwModifiedNow((int) param.get("id"));
		}

		memberDao.modify(param);
	}

	public boolean isUsingTempPassword(int id) {
		if (attrService.getValue("member__" + id + "__extra__isUsingTempPassword").equals("1")) {
			return true;
		}
		return false;
	}

	public Member getMemberIncludeAttrById(int memberId) {
		Member member = getMemberById(memberId);

		boolean isUsingTempPassword = isUsingTempPassword(member.getId());
		member.getAttr().put("isUsingTempPassword", isUsingTempPassword);

		return member;
	}

	public boolean isNeedToChangeLoginPw(int id) {
		String date = attrService.getValue("member__" + id + "__extra__loginPwModifiedDate");

		if (Util.isEmpty(date)) {
			return true;
		}

		int pass = Util.getPassedSecondFrom(date);

		int oldPasswordDays = getOldPasswordDays();

		if (pass > oldPasswordDays * 60 * 60 * 24) {
			return true;
		}

		return false;
	}

	public int getOldPasswordDays() {
		return 90;
	}

}
