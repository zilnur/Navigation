
struct Post {
    var autor: String? = nil
    var description: String? = nil
    var image: String? = nil
    var likes: Int? = nil
    var views: Int? = nil
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
                        Post(autor: "Apple", description: "Ждете iOS 15?", image: "post-1", likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500)),
                        Post(autor: "Радость для мужских глаз", image: "post-2", likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500)),
                        Post(autor: "NBA", description: "Он верил что ты сможешь!", image: "post-3", likes: Int.random(in: 0...1000), views: Int.random(in: 1000...1500))])]
}


