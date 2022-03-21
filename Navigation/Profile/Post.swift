
struct Post {
    var autor: String
    var description: String
    var image: String
    var likes: Int16
    var views: Int16
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
                        Post(autor: "Apple", description: "Ждете iOS 15?", image: "post-1", likes: Int16.random(in: 0...1000), views: Int16.random(in: 1000...1500)),
                        Post(autor: "Радость для мужских глаз", description: "", image: "post-2", likes: Int16.random(in: 0...1000), views: Int16.random(in: 1000...1500)),
                        Post(autor: "NBA", description: "Он верил что ты сможешь!", image: "post-3", likes: Int16.random(in: 0...1000), views: Int16.random(in: 1000...1500))])]
}


