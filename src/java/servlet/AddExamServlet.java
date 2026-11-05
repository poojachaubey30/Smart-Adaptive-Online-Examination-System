package servlet;

import dao.ExamDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Exam;

@WebServlet("/AddExamServlet")
public class AddExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        String examName = request.getParameter("examName");
        int totalQuestions = Integer.parseInt(request.getParameter("totalQuestions"));
        int totalMarks = Integer.parseInt(request.getParameter("totalMarks"));
        int durationMinutes = Integer.parseInt(request.getParameter("durationMinutes"));
        int passingMarks = Integer.parseInt(request.getParameter("passingMarks"));
        double negativeMarking = Double.parseDouble(request.getParameter("negativeMarking"));

        Exam exam = new Exam();

        exam.setSubjectId(subjectId);
        exam.setExamName(examName);
        exam.setTotalQuestions(totalQuestions);
        exam.setTotalMarks(totalMarks);
        exam.setDurationMinutes(durationMinutes);
        exam.setPassingMarks(passingMarks);
        exam.setNegativeMarking(negativeMarking);

        ExamDAO dao = new ExamDAO();

        boolean status = dao.addExam(exam);

        if (status) {
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.getWriter().println("Exam Not Added!");
        }
    }
}