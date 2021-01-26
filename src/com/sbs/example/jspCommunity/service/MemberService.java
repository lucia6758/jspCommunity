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

	public MemberService() {
		memberDao = Container.memberDao;
		emailService = Container.emailService;
	}

	public List<Member> getForPrintMembers() {
		return memberDao.getForPrintMembers();
	}

	public int join(Map<String, Object> joinArgs) {
		return memberDao.join(joinArgs);
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
	}

	private void modify(Map<String, Object> param) {
		memberDao.modify(param);

	}

}
