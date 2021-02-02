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
import com.sbs.example.jspCommunity.util.Util;

public class UsrMemberController extends Controller {
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

		if (Util.isEmpty(loginId)) {
			return msgAndBack(req, "아이디를 입력해주세요.");
		}

		if (Util.isEmpty(loginPw)) {
			return msgAndBack(req, "비밀번호를 입력해주세요.");
		}

		if (Util.isEmpty(name)) {
			return msgAndBack(req, "이름을 입력해주세요.");
		}

		if (Util.isEmpty(nickname)) {
			return msgAndBack(req, "닉네임을 입력해주세요.");
		}

		if (Util.isEmpty(email)) {
			return msgAndBack(req, "이메일을 입력해주세요.");
		}

		if (Util.isEmpty(cellphoneNo)) {
			return msgAndBack(req, "핸드폰번호를 입력해주세요.");
		}

		Member oldMember = memberService.getMemberByLoginId(loginId);

		if (oldMember != null) {
			return msgAndBack(req, "이미 사용중인 아이디입니다.");
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

		return magAndReplace(req, newMemberId + "번 회원으로 가입되었습니다.", "../home/main");
	}

	public String login(HttpServletRequest req, HttpServletResponse resp) {

		return "usr/member/login";
	}

	public String doLogin(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();

		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPwReal");

		if (Util.isEmpty(loginId)) {
			return msgAndBack(req, "아이디를 입력해주세요.");
		}

		if (Util.isEmpty(loginPw)) {
			return msgAndBack(req, "비밀번호를 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return msgAndBack(req, "아이디가 존재하지 않습니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return msgAndBack(req, "비밀번호가 일치하지 않습니다.");
		}

		session.setAttribute("loginedMemberId", member.getId());
		boolean isUsingTempPassword = memberService.isUsingTempPassword(member.getId());

		String alertMsg = String.format("%s님 환영합니다.", member.getNickname());
		String replaceUrl = "../home/main";

		if (isUsingTempPassword) {
			alertMsg = "현재 임시비밀번호를 사용중입니다. 비밀번호를 변경해주십시오.";
			replaceUrl = "../member/myPage";
		}

		return magAndReplace(req, alertMsg, replaceUrl);
	}

	public String doLogout(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		session.removeAttribute("loginedMemberId");

		return magAndReplace(req, "로그아웃되었습니다.", "../home/main");
	}

	public String getLoginIdDup(HttpServletRequest req, HttpServletResponse resp) {
		String loginId = req.getParameter("loginId");

		Member member = memberService.getMemberByLoginId(loginId);

		String resultCode = null;
		String msg = null;

		if (member != null) {
			resultCode = "F-1";
			msg = "이미 사용중인 아이디입니다.";
		} else {
			resultCode = "S-1";
			msg = "사용가능한 아이디입니다.";
		}

		return json(req, new ResultData(resultCode, msg, "loginId", loginId));
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

		if (Util.isEmpty(name)) {
			return msgAndBack(req, "이름을 입력해주세요.");
		}

		if (Util.isEmpty(email)) {
			return msgAndBack(req, "이메일을 입력해주세요.");
		}

		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			return msgAndBack(req, "일치하는 회원이 존재하지 않습니다.");
		}

		return magAndReplace(req, String.format("로그인 아이디는 %s 입니다.", member.getLoginId()), "../member/login");
	}

	public String findLoginPw(HttpServletRequest req, HttpServletResponse resp) {
		return "usr/member/findLoginPw";
	}

	public String doFindLoginPw(HttpServletRequest req, HttpServletResponse resp) {
		String loginId = req.getParameter("loginId");
		String email = req.getParameter("email");

		if (Util.isEmpty(loginId)) {
			return msgAndBack(req, "아이디를 입력해주세요.");
		}

		if (Util.isEmpty(email)) {
			return msgAndBack(req, "이메일을 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return msgAndBack(req, "일치하는 회원이 존재하지 않습니다.");
		}

		if (member.getEmail().equals(email) == false) {
			return msgAndBack(req, "이메일 주소가 일치하지 않습니다.");
		}

		ResultData sendTempLoginPwToEmailRs = memberService.sendTempLoginPwToEmail(member);

		if (sendTempLoginPwToEmailRs.isFail()) {
			return msgAndBack(req, sendTempLoginPwToEmailRs.getMsg());
		}

		return magAndReplace(req, sendTempLoginPwToEmailRs.getMsg(), "../member/login");
	}

	public String doModify(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String loginPw = req.getParameter("loginPwReal");

		if (loginPw != null && loginPw.length() == 0) {
			loginPw = null;
		}

		if (loginPw != null) {
			Container.attrService.remove("member__" + loginedMemberId + "__extra__isUsingTempPassword");
		}

		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String email = req.getParameter("email");
		String cellphoneNo = req.getParameter("cellphoneNo");

		if (Util.isEmpty(name)) {
			return msgAndBack(req, "이름을 입력해주세요.");
		}

		if (Util.isEmpty(nickname)) {
			return msgAndBack(req, "닉네임을 입력해주세요.");
		}

		if (Util.isEmpty(email)) {
			return msgAndBack(req, "이메일을 입력해주세요.");
		}

		if (Util.isEmpty(cellphoneNo)) {
			return msgAndBack(req, "핸드폰번호를 입력해주세요.");
		}

		Map<String, Object> modifyParam = new HashMap<>();
		modifyParam.put("loginPw", loginPw);
		modifyParam.put("name", name);
		modifyParam.put("nickname", nickname);
		modifyParam.put("email", email);
		modifyParam.put("cellphoneNo", cellphoneNo);
		modifyParam.put("id", loginedMemberId);

		memberService.modify(modifyParam);

		return magAndReplace(req, "회원정보가 수정되었습니다.", "../home/main");
	}

}