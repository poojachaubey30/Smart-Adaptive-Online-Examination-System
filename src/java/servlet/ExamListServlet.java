package servlet;

import dao.ExamDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Exam;

@WebServlet("/ExamListServlet")
public class ExamListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create ExamDAO object
        ExamDAO examDAO = new ExamDAO();

        // Get all exams from database
        List<Exam> examList = examDAO.getAllExams();

        // Store exam list in request
        request.setAttribute("examList", examList);

        // Open examList.jsp
        request.getRequestDispatcher("student/examList.jsp")
                .forward(request, response);
    }
}