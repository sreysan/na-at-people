//
//  Tools.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import Foundation
import UIKit

class DateNews: NSObject{
	
	static let shared = DateNews()
	
	func setDateNew(date:String) -> String {
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

		let dateFormatterPrint = DateFormatter()
		dateFormatterPrint.dateFormat = "dd/MM/yyyy"
		
		if let dateModified = dateFormatterGet.date(from: date) {
			return dateFormatterPrint.string(from: dateModified)
		} else {
			return date
		}
	}
	
	func setDateNewDetail(date:String) -> String {
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

		let dateFormatterPrint = DateFormatter()
		dateFormatterPrint.dateFormat = "dd/MM/yyyy | HH:mm"
		
		if let dateModified = dateFormatterGet.date(from: date) {
			return dateFormatterPrint.string(from: dateModified)
		} else {
			return date
		}
	}
}

class Service: NSObject {
	
	static let shared = Service()
	
	func newsListResponse(completion: @escaping(Result<[NewsListResponse],Error>) -> ()) {
		
		guard let url = URL(string: "http://3.238.21.227:8080/news") else {
			return
		}
		
		let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
			data, response, error in
			
			if let error = error {
				print("Error: ", error)
				return
			}
			
			guard let data = data else {
				return
			}
			
			print(String(data: data, encoding: .utf8) ?? "")
			
			do {
				
			 let decodedData = try JSONDecoder().decode([NewsListResponse].self, from: data)
				completion(.success(decodedData))
			}
			catch {
				print("Error en la descarga. ", error)
				completion(.failure(error))
			}
		})
		urlSession.resume()
	}
	
	func activitiesListResponse(completion: @escaping(Result<[ActivitiesListResponse],Error>) -> ()) {
		
		guard let url = URL(string: "http://3.238.21.227:8080/activities") else {
			return
		}
		
		let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
			data, response, error in
			
			if let error = error {
				print("Error: ", error)
				return
			}
			
			guard let data = data else {
				return
			}
			
			print(String(data: data, encoding: .utf8) ?? "")
			
			do {
				
			 let decodedData = try JSONDecoder().decode([ActivitiesListResponse].self, from: data)
				completion(.success(decodedData))
			}
			catch {
				print("Error en la descarga. ", error)
				completion(.failure(error))
			}
		})
		urlSession.resume()
	}
	
	func clientsListResponse(completion: @escaping(Result<[ClientsListResponse],Error>) -> ()) {
		
		guard let url = URL(string: "http://3.238.21.227:8080/clients") else {
			return
		}
		
		let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
			data, response, error in
			
			if let error = error {
				print("Error: ", error)
				return
			}
			
			guard let data = data else {
				return
			}
			
			print(String(data: data, encoding: .utf8) ?? "")
			
			do {
				
			 let decodedData = try JSONDecoder().decode([ClientsListResponse].self, from: data)
				completion(.success(decodedData))
			}
			catch {
				print("Error en la descarga. ", error)
				completion(.failure(error))
			}
		})
		urlSession.resume()
	}
	
	func newsDetailsResponse(id: String,completion: @escaping(Result<NewsDetailResponse,Error>) -> ()) {
		
		let idNew = id
		
		
		guard let url = URL(string: "http://3.238.21.227:8080/news/\(idNew)") else {
			return
		}
		
		let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
			data, response, error in
			
			if let error = error {
				print("Error: ", error)
				return
			}
			
			guard let data = data else {
				return
			}
			
			print(String(data: data, encoding: .utf8) ?? "")
			
			do {
				
			 let decodedData = try JSONDecoder().decode(NewsDetailResponse.self, from: data)
				completion(.success(decodedData))
			}
			catch {
				print("Error en la descarga. ", error)
				completion(.failure(error))
			}
		})
		urlSession.resume()
	}
	
	func projectsByClientsResponse(id: String,completion: @escaping(Result<[ProjectsByClientListResponse],Error>) -> ()) {
		
		let idClient = id
		
		
		guard let url = URL(string: "http://3.238.21.227:8080/clients/\(idClient)/projects") else {
			return
		}
		
		let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
			data, response, error in
			
			if let error = error {
				print("Error: ", error)
				return
			}
			
			guard let data = data else {
				return
			}
			
			print(String(data: data, encoding: .utf8) ?? "")
			
			do {
				
			 let decodedData = try JSONDecoder().decode([ProjectsByClientListResponse].self, from: data)
				completion(.success(decodedData))
			}
			catch {
				print("Error en la descarga. ", error)
				completion(.failure(error))
			}
		})
		urlSession.resume()
	}
	
	func activityRecordsListResponse(completion: @escaping(Result<[ActivityRecordsListResponse],Error>) -> ()) {
		
		guard let url = URL(string: "http://3.238.21.227:8080/activity-records") else {
			return
		}
		
		let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
			data, response, error in
			
			if let error = error {
				print("Error: ", error)
				return
			}
			
			guard let data = data else {
				return
			}
			
			print(String(data: data, encoding: .utf8) ?? "")
			
			do {
				
			 let decodedData = try JSONDecoder().decode([ActivityRecordsListResponse].self, from: data)
				completion(.success(decodedData))
			}
			catch {
				print("Error en la descarga. ", error)
				completion(.failure(error))
			}
		})
		urlSession.resume()
	}
	
	
}
