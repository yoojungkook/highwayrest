package controller.member;

import common.Handler;
import data.entity.Member;
import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ResetPwdHandler implements Handler {
    MemberService service = new MemberService();

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Member m = service.getMember(id);
        request.setAttribute("m", m);
        request.setAttribute("view", "/member/resetPwd.jsp");
        return "/index.jsp";
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        Member m = service.getMember(id);

        service.editMember(new Member(0, id, password, "", m.getNickname(), "", m.getTel()));

        return "redirect/index.jsp";
    }

    @Override
    public String getPath() {
        return path + "/member/reset";
    }
}
