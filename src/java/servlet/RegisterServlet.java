
package servlet;

import dao.StudentDAO;
import model.Student;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        Student student = new Student();

        student.setName(request.getParameter("name"));
        student.setGender(request.getParameter("gender"));
        student.setEmail(request.getParameter("email"));
        student.setMobile(request.getParameter("mobile"));
        student.setCourse(request.getParameter("course"));
        student.setPassword(request.getParameter("password"));

        StudentDAO dao = new StudentDAO();

        boolean status = dao.registerStudent(student);

        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html>");
        response.getWriter().println("<head>");
        response.getWriter().println("<meta charset='UTF-8'>");
        response.getWriter().println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        response.getWriter().println("<title>Registration Status</title>");

        response.getWriter().println("<style>");
        response.getWriter().println("body{font-family:Arial,sans-serif;background:#f1f5f9;display:flex;justify-content:center;align-items:center;min-height:100vh;margin:0;}");
        response.getWriter().println(".box{background:white;padding:35px;border-radius:12px;text-align:center;box-shadow:0 4px 15px rgba(0,0,0,0.1);width:90%;max-width:420px;}");
        response.getWriter().println("h2{color:#15803d;}");
        response.getWriter().println(".error{color:#dc2626;}");
        response.getWriter().println("a{display:inline-block;background:#0284c7;color:white;text-decoration:none;padding:12px 22px;border-radius:6px;margin-top:15px;}");
        response.getWriter().println("a:hover{background:#0369a1;}");
        response.getWriter().println("</style>");

        response.getWriter().println("</head>");
        response.getWriter().println("<body>");
        response.getWriter().println("<div class='box'>");

        if (status) {
            response.getWriter().println("<h2>Registration Successful!</h2>");
            response.getWriter().println("<p>Your account has been created successfully.</p>");
            response.getWriter().println("<a href='login.jsp'>Go to Login</a>");
        } else {
            response.getWriter().println("<h2 class='error'>Registration Failed!</h2>");
            response.getWriter().println("<p>Please check your details or try again with a different email.</p>");
            response.getWriter().println("<a href='register.jsp'>Back to Registration</a>");
        }

        response.getWriter().println("</div>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}
