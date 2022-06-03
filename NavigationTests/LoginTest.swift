import XCTest
@testable import Navigation

class LoginTest: XCTestCase {
    
    var helper: LoginHelper!
    var mock: LoginPresentMock!
    
    override func setUp() {
        super.setUp()
        helper = LoginHelper()
        mock = LoginPresentMock()
        helper.presenter = mock
    }
    
    func testLogin() {
        let user = User(name: "qwe", pass: "123")
        mock.logInProfile(user: user, isAccess: false)
        
        XCTAssertTrue(mock.loginCalled)
        XCTAssertEqual(mock.loginUser, User(name: "qwe", pass: "123"))
    }
    
}

class LoginPresentMock: LoginPresenter {
    
    var loginUser: User?
    var loginCalled = false
    
    
    func logInProfile(user: User, isAccess: Bool) {
        loginUser = user
        loginCalled = true
    }
}
