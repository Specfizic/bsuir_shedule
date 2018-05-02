//
//  SheduleService.swift
//  ExampleBsuirProject
//
//  Created by Andrew Rolya on 4/26/18.
//  Copyright © 2018 Andrew Rolya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias GroupSheduleCompletion = (SheduleService.GroupSheduleResult?, Error?)->(Void)

class SheduleService: BaseRestService {
    
    public class GroupSheduleResult: BaseMapResponse {
        var employee: String?
        var studentGroup: StudentGroup?
        var schedules: [SheduleDay]?
        var examSchedules: [SheduleDay]?
        var todayDate: String?
        var todaySchedules: [SheduleDay]?
        var tomorrowDate: String?
        var tomorrowSchedules: [SheduleDay]?
        var currentWeekNumber: Int?

        override func mapping(map: Map) {
            super.mapping(map: map)
            
            employee <- map["employee"]
            currentWeekNumber <- map["currentWeekNumber"]
            studentGroup <- map["studentGroup"]
            tomorrowDate <- map["tomorrowDate"]
        }
    }
    
    class StudentGroup: BaseMapResponse {
        var name: String?
        var facultyId: Int?
        var facultyName: String?
        var specialityDepartmentEducationFormId: Int?
        var specialityName: String?
        var course: Int?
        var id: Int?
        var calendarId: String?
        override func mapping(map: Map) {
            super.mapping(map: map)
            name <- map["name"]
            facultyId <- map["facultyId"]
            facultyName <- map["facultyName"]
            specialityDepartmentEducationFormId <- map["specialityDepartmentEducationFormId"]
            specialityName <- map["specialityName"]
            course <- map["course"]
            id <- map["id"]
            calendarId <- map["calendarId"]
        }
    }
    
    class SheduleDay: BaseMapResponse {
        var weekDay: String?
        var schedule: [Shedule]?
        override func mapping(map: Map) {
            super.mapping(map: map)
            weekDay <- map["weekDay"]
            schedule <- map["schedule"]
        }
    }
    
    class Shedule: BaseMapResponse {
        var weekNumber: [Int]?
        var studentGroup: [String]?
        var studentGroupInformation: [String]?
        var numSubgroup: Int?
        var auditory: [String]?
        var lessonTime: String?
        var startLessonTime: String?
        var endLessonTime: String?
        var subject: String?
        var note: String?
        var lessonType: String?
        var employee: [Employee]?
        var studentGroupModelList: [String]? // see
        var zaoch: Bool?
    }
    
    class Employee: BaseMapResponse {
        var firstName: String?
        var rank: String?
        var academicDepartment: [String]?
    }
    
    func requestSheduleGroup(groupName: String, andCompletion completion: GroupSheduleCompletion?) {
        let request = RestApiRequestFactory.requestSheduleGroup(groupName).urlRequest
        restApiService.sendMappableRequest(request, completion: completion)
    }
}
