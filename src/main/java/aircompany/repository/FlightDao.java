package main.java.aircompany.repository;

import main.java.aircompany.entity.Flight;
import main.java.aircompany.exception.DaoException;
import main.java.aircompany.util.ConnectionManager;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class FlightDao {

	private static final FlightDao INSTANCE = new FlightDao();
	private static final String DELETE_SQL = """
		DELETE FROM flight
		WHERE number = ?
		""";
	private static final String SAVE_SQL = """
		INSERT INTO flight (number, departure, arrive, dep_time, duration_flight, airplane_type_id)
		VALUES (?, ?, ?, ?, ?, ?);
		""";
	private static final String UPDATE_SQL = """
		UPDATE flight SET
		 departure = ?,
		 arrive = ?,
		 airplane_type_id = ?,
		 dep_time = ?,
		 duration_flight = ?
		 WHERE number = ?;
		""";
	private static final String FIND_BY_NUMBER = """
		SELECT number,
		 flight.departure AS departure,
		 flight.arrive AS arrive,
		 airplane_type_id,
		 dep_time,
		 duration_flight
		 FROM flight WHERE number = ?;
		""";
	private static final String FIND_ALL = """
		SELECT number,
		 flight.departure AS departure,
		 flight.arrive AS arrive,
		 airplane_type_id,
		 dep_time,
		 duration_flight
		 FROM flight;
		""";

	private FlightDao() {
	}

	public static FlightDao getInstance() {
		return INSTANCE;
	}

	public Flight saveFlight(Flight flight) {
		try (var connection = ConnectionManager.open()) {
			var preparedStatement = connection.prepareStatement(SAVE_SQL);
			preparedStatement.setInt(1, flight.getNumber());
			preparedStatement.setObject(2, flight.getDepartureAirport());
			preparedStatement.setObject(3, flight.getArriveAirport());
			preparedStatement.setTime(4, Time.valueOf(flight.getDepartureTime()));
			preparedStatement.setInt(5, flight.getDuration());
			preparedStatement.setInt(6, flight.getAirplane());

			preparedStatement.execute();
			return flight;
		} catch (SQLException e) {
			throw new DaoException(e);
		}
	}

	public Flight updateFlight(Flight flight) {
		try (var connection = ConnectionManager.open()) {
			var preparedStatement = connection.prepareStatement(UPDATE_SQL);
			preparedStatement.setObject(1, flight.getDepartureAirport());
			preparedStatement.setObject(2, flight.getArriveAirport());
			preparedStatement.setInt(3, flight.getAirplane());
			preparedStatement.setTime(4, Time.valueOf(flight.getDepartureTime()));
			preparedStatement.setInt(5, flight.getDuration());
			preparedStatement.setInt(6, flight.getNumber());

			preparedStatement.execute();
			return flight;
		} catch (SQLException e) {
			throw new DaoException(e);
		}
	}

	public boolean deleteFlight(Integer number) {
		try (var connection = ConnectionManager.open()) {
			var preparedStatement = connection.prepareStatement(DELETE_SQL);
			preparedStatement.setInt(1, number);

			return preparedStatement.execute();
		} catch (SQLException e) {
			throw new DaoException(e);
		}
	}

	public Optional<Flight> getFlightByNumber(Integer number) {
		try (var connection = ConnectionManager.open()) {
			var preparedStatement = connection.prepareStatement(FIND_BY_NUMBER);
			preparedStatement.setInt(1, number);

			var resultSet = preparedStatement.executeQuery();
			Flight flight = null;
			if (resultSet.next()) {
				flight = buildFlight(resultSet);
			}
			return Optional.ofNullable(flight);
		} catch (SQLException e) {
			throw new DaoException(e);
		}
	}

	public List<Flight> getAllFlights() {
		try (var connection = ConnectionManager.open()) {
			var preparedStatement = connection.prepareStatement(FIND_ALL);
			var resultSet = preparedStatement.executeQuery();
			List<Flight> result = new ArrayList<>();
			while (resultSet.next()) {
				result.add(buildFlight(resultSet));
			}
			return result;
		} catch (SQLException e) {
			throw new DaoException(e);
		}
	}

	private Flight buildFlight(ResultSet resultSet) throws SQLException {
		return new Flight(resultSet.getInt("number"), resultSet.getObject("departure", UUID.class),
						  resultSet.getObject("arrive", UUID.class), resultSet.getObject("dep_time", LocalTime.class),
						  resultSet.getInt("duration_flight"), resultSet.getInt("airplane_type_id"));
	}
}
