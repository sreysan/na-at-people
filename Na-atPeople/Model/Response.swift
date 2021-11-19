//
//  Response.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import Foundation

//Login
struct LoginResponse: Codable {
	var accessToken: String
	var refreshToken: String
	var email: String
	var name: String
	var lastName: String
	var id: String
}

//NewsList
struct NewsListResponse: Codable {
	var id: String
	var image: String
	var creationDate: String
	var headline: String
	var summary: String
	var body: String
}

//NewDetail
struct NewsDetailResponse: Codable {
	var id: String
	var creationDate: String
	var modificationDate: String
	var enabled: Bool
	var idAuthor: IdAuthor
	var headline: String
	var summary: String
	var body: String
	var image: String
}
struct IdAuthor: Codable {
   var name: String
}

//ClientList
struct ClientsListResponse: Codable {
	var id: String
	var key: String
	var name: String
	var description: String
}

//ActivitiesList
struct ActivitiesListResponse: Codable {
	var id: String
	var key: String
	var name: String
	var description: String
}

//ProjectsByClientList
struct ProjectsByClientListResponse: Codable {
	var id: String
	var key: String
	var name: String
	var description: String
	var idClient: IdClient
}
struct IdClient: Codable {
	var name: String
}

//ActivityRecordsList
struct ActivityRecordsListResponse: Codable {
	var project: Project
	var activityRecords: [ActivityRecords]
}
struct Project: Codable {
	var name: String
	var client: Client
}
struct Client: Codable {
	var name: String
}
struct ActivityRecords: Codable {
	var activity: Activity
	var date: String
	var duration: Int
	var id: String
}
struct Activity: Codable {
	var name: String
}

//
