package servlet;

import dao.AdminDAO;
import model.Admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        Admin admin = dao.loginAdmin(username, password);

        if (admin != null) {

            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);

            response.sendRedirect("adminDashboard.jsp");

        } else {

            response.sendRedirect("adminLogin.jsp?error=1");
        }
    }
}