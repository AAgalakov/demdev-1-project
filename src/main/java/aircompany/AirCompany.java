package main.java.aircompany;

import main.java.aircompany.entity.Flight;
import main.java.aircompany.repository.FlightDao;

import java.time.LocalTime;
import java.util.UUID;

public class AirCompany {

	public static void main(String[] args) {
		var flightRepository = FlightDao.getInstance();

		flightRepository.getAllFlights().forEach(System.out::println);

		flightRepository.getFlightByNumber(201)
			.ifPresentOrElse(System.out::println, () -> System.out.println("Нет такой сущности :("));

		Flight flight = new Flight(201, UUID.fromString("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"),
								   UUID.fromString("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14"),
								   LocalTime.now().withSecond(0), 65, 4);
		flightRepository.saveFlight(flight);

		flightRepository.getFlightByNumber(201)
			.ifPresentOrElse(System.out::println, () -> System.out.println("Нет такой сущности :("));

		flightRepository.updateFlight(new Flight(201, UUID.fromString("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"),
												 UUID.fromString("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"),
												 LocalTime.now().withSecond(0).plusHours(2L), 75, 2));

		flightRepository.getFlightByNumber(201)
			.ifPresentOrElse(System.out::println, () -> System.out.println("Нет такой сущности :("));

		flightRepository.deleteFlight(201);

		flightRepository.getFlightByNumber(201)
			.ifPresentOrElse(System.out::println, () -> System.out.println("Нет такой сущности :("));
	}
}
