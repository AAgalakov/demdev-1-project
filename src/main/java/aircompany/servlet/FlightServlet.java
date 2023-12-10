package main.java.aircompany.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.java.aircompany.entity.Flight;
import main.java.aircompany.repository.FlightDao;

import java.io.IOException;

@WebServlet("/flight")
public class FlightServlet extends HttpServlet {

	private final FlightDao flightDao = FlightDao.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html");
		var number = req.getParameter("number");
		try (var printWriter = resp.getWriter()) {
			String answer = flightDao.getFlightByNumber(Integer.parseInt(number))
				.map(Flight::toString)
				.orElse("Нет такого");
			printWriter.write(
          """
          <h1>Hello from First Servlet</h1>
          <b>
          Информация о рейсе %s -> %s
          """.formatted(number, answer));
		}
	}
}
