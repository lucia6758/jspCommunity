package com.sbs.example.jspCommunity.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.example.jspCommunity.App;
import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.service.MemberService;

public class UsrMemberController {
	private MemberService memberService;

	public UsrMemberController() {
		memberService = Container.memberService;
	}

	public String showList(HttpServletRequest req, HttpServletResponse resp) {
		List<Member> members = memberService.getForPrintMembers();

		req.setAttribute("members", members);

		return "usr/member/list";
	}

	public String join(HttpServletRequest req, HttpServletResponse resp) {
		return "usr/member/join";
	}

	public String doJoin(HttpServletRequest req, HttpServletResponse resp) {

		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPwReal");
		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String email = req.getParameter("email");
		String cellphoneNo = req.getParameter("cellphoneNo");

		Member oldMember = memberService.getMemberByLoginId(loginId);

		if (oldMember != null) {
			req.setAttribute("alertMsg", "이미 사용중인 아이디입니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		Map<String, Object> joinArgs = new HashMap<>();
		joinArgs.put("loginId", loginId);
		joinArgs.put("loginPw", loginPw);
		joinArgs.put("name", name);
		joinArgs.put("nickname", nickname);
		joinArgs.put("email", email);
		joinArgs.put("cellphoneNo", cellphoneNo);

		int newMemberId = memberService.join(joinArgs);

		String siteName = App.getSite();
		String siteLoginUrl = App.getLoginUrl();
		String siteMainUrl = App.getMainUrl();
		String title = "[" + siteName + "] 회원가입이 완료되었습니다.";
		String body = siteName + " 회원이 되신것을 환영합니다.<br/><br/>";
		body += "가입정보<br/>";
		body += "아이디 : " + loginId;
		body += "<br/>이름 : " + name;
		body += "<br/>닉네임 : " + nickname;
		body += "<br/><br/><a href=\"" + siteMainUrl + "\" target=\"_blank\">" + siteName + " 바로가기</a>";

		Container.emailService.send(email, title, body);

		req.setAttribute("alertMsg", newMemberId + "번 회원으로 가입되었습니다.");
		req.setAttribute("replaceUrl", "../home/main");

		return "common/redirect";
	}

	public String login(HttpServletRequest req, HttpServletResponse resp) {

		return "usr/member/login";
	}

	public String doLogin(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();

		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPwReal");

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			req.setAttribute("alertMsg", "아이디가 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			req.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());

		req.setAttribute("alertMsg", String.format("%s님 환영합니다.", member.getNickname()));
		req.setAttribute("replaceUrl", "../home/main");

		return "common/redirect";
	}

	public String doLogout(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		session.removeAttribute("loginedMemberId");

		req.setAttribute("alertMsg", "로그아웃되었습니다.");
		req.setAttribute("replaceUrl", "../home/main");

		return "common/redirect";
	}

	public String getLoginIdDup(HttpServletRequest req, HttpServletResponse resp) {
		String loginId = req.getParameter("loginId");

		Member member = memberService.getMemberByLoginId(loginId);

		Map<String, Object> rs = new HashMap<>();

		String resultCode = null;
		String msg = null;

		if (member != null) {
			resultCode = "F-1";
			msg = "이미 사용중인 아이디입니다.";
		} else {
			resultCode = "S-1";
			msg = "사용가능한 아이디입니다.";
		}

		req.setAttribute("data", new ResultData(resultCode, msg, "loginId", loginId));
		return "common/json";
	}

	public String myPage(HttpServletRequest req, HttpServletResponse resp) {

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		Member member = memberService.getMemberById(loginedMemberId);

		req.setAttribute("member", member);

		return "usr/member/myPage";
	}

	public String findLoginId(HttpServletRequest req, HttpServletResponse resp) {
		return "usr/member/findLoginId";
	}

	public String doFindLoginId(HttpServletRequest req, HttpServletResponse resp) {
		String name = req.getParameter("name");
		String email = req.getParameter("email");

		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			req.setAttribute("alertMsg", "일치하는 회원이 존재하지않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}
		req.setAttribute("alertMsg", String.format("로그인 아이디는 %s 입니다.", member.getLoginId()));
		req.setAttribute("replaceUrl", "../member/login");

		return "common/redirect";
	}

	public String findLoginPw(HttpServletRequest req, HttpServletResponse resp) {
		return "usr/member/findLoginPw";
	}

	public String doFindLoginPw(HttpServletRequest req, HttpServletResponse resp) {
		String loginId = req.getParameter("loginId");
		String email = req.getParameter("email");

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			req.setAttribute("alertMsg", "일치하는 회원이 존재하지않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		if (member.getEmail().equals(email) == false) {
			req.setAttribute("alertMsg", "이메일 주소가 일치하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		ResultData sendTempLoginPwToEmailRs = memberService.sendTempLoginPwToEmail(member);

		if (sendTempLoginPwToEmailRs.isFail()) {
			req.setAttribute("alertMsg", sendTempLoginPwToEmailRs.getMsg());
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		req.setAttribute("alertMsg", sendTempLoginPwToEmailRs.getMsg());
		req.setAttribute("replaceUrl", "../member/login");

		return "common/redirect";
	}

	public String doModify(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String loginPw = req.getParameter("loginPwReal");

		if (loginPw != null && loginPw.length() == 0) {
			loginPw = null;
		}

		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String email = req.getParameter("email");
		String cellphoneNo = req.getParameter("cellphoneNo");

		Map<String, Object> modifyParam = new HashMap<>();
		modifyParam.put("loginPw", loginPw);
		modifyParam.put("name", name);
		modifyParam.put("nickname", nickname);
		modifyParam.put("email", email);
		modifyParam.put("cellphoneNo", cellphoneNo);
		modifyParam.put("id", loginedMemberId);

		memberService.modify(modifyParam);

		req.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
		req.setAttribute("replaceUrl", "../home/main");

		return "common/redirect";
	}

}