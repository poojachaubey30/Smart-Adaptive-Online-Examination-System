package servlet;

import dao.QuestionDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Question;

@WebServlet("/StartExamServlet")
public class StartExamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String examId = request.getParameter("examId");

        if (examId == null || examId.trim().isEmpty()) {
            response.sendRedirect("ExamListServlet");
            return;
        }

        try {

            int id = Integer.parseInt(examId);

            QuestionDAO questionDAO = new QuestionDAO();

            List<Question> questionList =
                    questionDAO.getQuestionsByExam(id);

            request.setAttribute("questionList", questionList);
            request.setAttribute("examId", id);

            request.getRequestDispatcher("student/startExam.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while starting exam: " + e.getMessage()
            );
        }
    }
}