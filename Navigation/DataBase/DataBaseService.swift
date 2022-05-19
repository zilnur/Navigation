import Foundation
import CoreData

class DataBaseService {
    
    static let shared = DataBaseService()
    
    private let dataContainer: NSPersistentContainer
    private lazy var backgroundContext = dataContainer.newBackgroundContext()
    
    init() {
        let container = NSPersistentContainer(name: "DataBaseModel")
        container.loadPersistentStores { description, error in
           if let error = error {
               fatalError("Unable to load persistent stores: \(error)")
           }
        }
        self.dataContainer = container
        
        backgroundContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
    
    func savePost(autor: String?, discription: String?, image: String?, likes: Int?, views: Int?) {
        backgroundContext.perform { [weak self] in
            guard let self = self else {return}
                guard let uAutor = autor, let uImage = image,
                      let uLikes = likes, let uViews = views else {return}
            let newLikedPost = NSEntityDescription.insertNewObject(forEntityName: "PostModel", into: self.backgroundContext) as! PostModel
                newLikedPost.autor = uAutor
                newLikedPost.discription = discription ?? ""
                newLikedPost.image = uImage
                newLikedPost.likes = Int16(uLikes)
                newLikedPost.views = Int16(uViews)
            do {
                try self.backgroundContext.save()
            } catch let error {
                print(error)
            }
        }
    }
    
    func setPosts() -> [Post] {
        var uPosts = [Post]()
        let fetch = PostModel.fetchRequest()
        do {
            let posts = try backgroundContext.fetch(fetch)
            for post in posts {
                guard let autor = post.autor,
                      let image = post.image else {return []}
                let uPost = Post(autor: autor, description: post.discription, image: image, likes: Int(post.likes), views: Int(post.views))
                uPosts.append(uPost)
            }
        } catch let error {
            print(error)
        }
        return uPosts
    }
    
    func deletePost(_ indexPath: Int) {
        dataContainer.viewContext.performAndWait {
            let request = PostModel.fetchRequest()
            do {
                let posts = try dataContainer.viewContext.fetch(request)
                let post = posts[indexPath]
                dataContainer.viewContext.delete(post)
                try dataContainer.viewContext.save()
                print(posts.count)
            } catch let error {
                print(error)
            }
        }
    }
    
    func qwe() {
        let request = PostModel.fetchRequest()
        do {
            let posts = try dataContainer.viewContext.fetch(request)
            print(posts)
        } catch let error {
            print(error)
        }
    }
}
