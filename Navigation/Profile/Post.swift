import UIKit

struct Post {
    var autor: String? = nil
    var description: String? = nil
    var image: UIImage?
    var likes: Int? = nil
    var views: Int? = nil
}

struct PostSection {
    var posts: [Post]
}

enum Sections {
    case posts(post:[Post])
}

struct Posts {
    
    static var posts: [Post] = [
            Post(autor: "Apple", description: "Ждете iOS 15?", image: UIImage(named: "post-1")!, likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500)),
            Post(autor: "Радость для мужских глаз",description: "Описание", image: .init(named: "post-2")!, likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500)),
            Post(autor: "NBA", description: "Он верил что ты сможешь!", image: .init(named: "post-3")!, likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500))]
}


