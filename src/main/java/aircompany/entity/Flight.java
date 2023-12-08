package main.java.aircompany.entity;

import java.time.LocalTime;
import java.util.UUID;

public class Flight {

	private Integer number;
	private UUID departureAirport;
	private UUID arriveAirport;
	private LocalTime departureTime;
	private Integer duration;
	private Integer airplane;

	public Flight() {
	}

	public Flight(Integer number,
				  UUID departureAirport,
				  UUID arriveAirport,
				  LocalTime departureTime,
				  Integer duration,
				  Integer airplane) {
		this.number = number;
		this.departureAirport = departureAirport;
		this.arriveAirport = arriveAirport;
		this.departureTime = departureTime;
		this.duration = duration;
		this.airplane = airplane;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public UUID getDepartureAirport() {
		return departureAirport;
	}

	public void setDepartureAirport(UUID departureAirport) {
		this.departureAirport = departureAirport;
	}

	public UUID getArriveAirport() {
		return arriveAirport;
	}

	public void setArriveAirport(UUID arriveAirport) {
		this.arriveAirport = arriveAirport;
	}

	public LocalTime getDepartureTime() {
		return departureTime;
	}

	public void setDepartureTime(LocalTime departureTime) {
		this.departureTime = departureTime;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public Integer getAirplane() {
		return airplane;
	}

	public void setAirplane(Integer airplane) {
		this.airplane = airplane;
	}

	@Override
	public String toString() {
		return "Flight{" + "number=" + number + ", departureAirport=" + departureAirport + ", arriveAirport="
			   + arriveAirport + ", departureTime=" + departureTime + ", duration=" + duration + ", airplane="
			   + airplane + '}';
	}
}
