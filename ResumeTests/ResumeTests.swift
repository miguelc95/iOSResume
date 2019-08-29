//
//  ResumeTests.swift
//  ResumeTests
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import XCTest
@testable import Resume

class ResumeTests: XCTestCase {
    var me : Me!
    var work : Work!
    var personal : Personal!


    func testMe() {
        me = Me()
        Network.getExternalData(fileLocation: Endpoints.shared.me) { (event: Me?, error) in
            if let err = error {
                XCTAssertNil(err)
            }
            if let me = event {
                if let edArray = me.education {
                    XCTAssertEqual(me.info, "Computer science Engineer with great passion for iOS and web development, I like to be updated on new technology and am really interested in cool projects and personal ones")
                    XCTAssertNil(me.education)
                    XCTAssert(edArray.count == 3)
                    XCTAssertNil(me.info)
                }
            }
        }
    }
    
    func testWork() {
        work = Work()
        Network.getExternalData(fileLocation: Endpoints.shared.work) { (event: Work?, error) in
            if let err = error {
                XCTAssertNil(err)
            }
            if let work = event {
                if let jobs = work.experience {
                    XCTAssertEqual(jobs[0].logo, "https://github.com/miguelc95/images/raw/master/tpal.png")
                    XCTAssertNil(work.experience)
                    XCTAssert(jobs.count == 3)
                    XCTAssertNil(work.info)
                }
            }
        }
    }
    
    func testPersonal() {
        personal = Personal()
        Network.getExternalData(fileLocation: Endpoints.shared.personal) { (event: Personal?, error) in
            if let err = error {
                XCTAssertNil(err)
            }
            if let personal = event {
                if let projects = personal.projects {
                    XCTAssertEqual(projects[0].description,"Development and maintanance of API for the financial applications of the Company using Node JS and development of management dashboards using Angular")
                    XCTAssertNil(projects)
                    print(projects.count)
                    XCTAssertEqual(projects.count, 3)
                    XCTAssertNil(personal.info)
                }
            }
        }
    }

}
