
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    var photoInCollection: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.contentMode = .scaleToFill
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension PhotosCollectionViewCell {
    func setupViews() {
        contentView.addSubview(photoInCollection)
        
        let constrains = [
            photoInCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoInCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoInCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoInCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constrains)
    }
}

