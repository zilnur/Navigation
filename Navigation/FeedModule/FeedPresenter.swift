import Foundation

protocol FeedModuleControllerInput {
    func input(_: String)
}

protocol FeedModuleControllerOutput {
    func output(word: String)
}

final class FeedPresenter {
    
    var coordinator: FeedViewCoordinatorDelegate?
    var input: FeedModuleControllerInput?
    
}

extension FeedPresenter: FeedModuleControllerOutput {
    
    func output(word: String) {
        coordinator?.toPostVC(post: word)
    }
    
}
