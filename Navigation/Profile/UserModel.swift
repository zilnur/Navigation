import Foundation

struct User {
    let name: String
    let pass: String
}

class Users {
    
    let users: [User] = [
        User(name: "Fry", pass: "123"),
        User(name: "Lila", pass: "321"),
        User(name: "Bender", pass: "Bite my shiny metal ass")
    ]
}
