package murach.email;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import murach.business.User;

public class EmailListServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {
        String url = "/index.html";
        String action = request.getParameter("action");
        if (action == null) {
            action = "join"; // default action
        }

        if (action.equals("join")) {
            url = "/index.html";
        } else if (action.equals("add")) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");

            // Instantiate the User object
            User user = new User(firstName, lastName, email);

            request.setAttribute("user", user);
            url = "/thanks.jsp"; // the "thanks" page
        }

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {
        doPost(request, response);
    }
}