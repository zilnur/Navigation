import iOSIntPackage

struct Post {
    var autor: String
    var description: String? = nil
    var image: String
    var filtr: ColorFilter
    var likes: Int
    var views: Int
}

struct PostSection {
    let posts: [Post]
}

enum Sections {
    case posts(post:[Post])
}

struct Posts {
    
    static var posts: [PostSection] = [
        PostSection(posts: [
            Post(autor: "Apple", description: "Ждете iOS 15?", image: "post-1", filtr: .colorInvert, likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500)),
            Post(autor: "Радость для мужских глаз", image: "post-2",filtr: .chrome, likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500)),
            Post(autor: "NBA", description: "Он верил что ты сможешь!", image: "post-3",filtr: .noir,  likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500))])]
}


