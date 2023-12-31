package controller.member;

import common.Handler;
import data.entity.Member;
import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class EditHandler implements Handler {
	MemberService service = new MemberService();

	@Override
	public String doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		Member m = service.getMember(id);
		request.setAttribute("m", m);
		request.setAttribute("view", "/member/edit.jsp");
		return "/index.jsp";
	}

	@Override
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String tel = request.getParameter("tel");
		service.editMember(new Member(0, id, password, "", nickname, "", tel));

		HttpSession session = request.getSession();
		session.setAttribute("nickname", nickname);

		return "redirect/index.jsp";
	}

	@Override
	public String getPath() {
		return path + "/member/edit";
	}
}