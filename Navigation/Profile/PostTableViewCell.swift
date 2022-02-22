
import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            postAutor.text = post!.autor
            postImage.image = UIImage(named: post!.image!)
            postDescription.text = post!.description
            postLikes.text = "Likes: \(String(post!.likes!))"
            postViews.text = "Views: \(String(post!.views!))"
        }
    }
    
    
    var postAutor: UILabel = {
        let pa = UILabel()
        pa.translatesAutoresizingMaskIntoConstraints = false
        pa.numberOfLines = 2
        pa.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        pa.textColor = .black
        return pa
    }()
    
    var postImage: UIImageView = {
        let pi = UIImageView()
        pi.contentMode = .scaleAspectFit
        pi.translatesAutoresizingMaskIntoConstraints = false
        pi.backgroundColor = .black
        return pi
    }()
    
    var postDescription: UILabel = {
       let pd = UILabel()
        pd.translatesAutoresizingMaskIntoConstraints = false
        pd.numberOfLines = 0
        pd.font = UIFont.systemFont(ofSize: 14)
        pd.textColor = .systemGray
        return pd
    }()
    
    var postLikes: UILabel = {
        let pl = UILabel()
        pl.translatesAutoresizingMaskIntoConstraints = false
        pl.numberOfLines = 1
        pl.font = UIFont.systemFont(ofSize: 16)
        pl.textColor = .black
        return pl
    }()
    
    var postViews: UILabel = {
        let pw = UILabel()
        pw.translatesAutoresizingMaskIntoConstraints = false
        pw.numberOfLines = 1
        pw.font = UIFont.systemFont(ofSize: 16)
        pw.textColor = .black
        return pw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupView()
    }
    
}

extension PostTableViewCell {
    
    private func setupView() {
        contentView.addSubview(postAutor)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
        contentView.addSubview(postLikes)
        contentView.addSubview(postViews)
        
        postAutor.setContentHuggingPriority(.required, for: .vertical)
        postImage.setContentHuggingPriority(.required, for: .vertical)
        postDescription.setContentHuggingPriority(.required, for: .vertical)
        postLikes.setContentHuggingPriority(.required, for: .vertical)
        postViews.setContentHuggingPriority(.required, for: .vertical)
        
        let constraints = [
            postAutor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postAutor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postAutor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postAutor.bottomAnchor.constraint(equalTo: postImage.topAnchor),
            
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            postImage.topAnchor.constraint(equalTo: postAutor.bottomAnchor),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.bottomAnchor.constraint(equalTo: postDescription.topAnchor),
            
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postDescription.bottomAnchor.constraint(equalTo: postLikes.topAnchor, constant: -16),
            
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -16)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
