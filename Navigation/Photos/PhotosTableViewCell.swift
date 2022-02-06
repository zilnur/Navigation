import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private var photoLabel: UILabel = {
        let photo = UILabel()
        photo.text = "Photos"
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photo.textColor = .black
        return photo
    }()
    
    var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.backgroundColor = .white
        return stackView
    }()

    var cursorImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addImage(imageName: "fry1")
        addImage(imageName: "fry2")
        addImage(imageName: "fry3")
        addImage(imageName: "fry4")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension PhotosTableViewCell {
    func setupViews() {
        contentView.addSubview(photoLabel)
        contentView.addSubview(photoStackView)
        contentView.addSubview(cursorImage)
        let constraints = [
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.bottomAnchor.constraint(equalTo: photoStackView.topAnchor, constant: -12),
            photoLabel.widthAnchor.constraint(equalToConstant: 200),
            
            cursorImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cursorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cursorImage.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            cursorImage.bottomAnchor.constraint(equalTo: photoStackView.topAnchor, constant: -12),
            cursorImage.widthAnchor.constraint(equalToConstant: 25),
            cursorImage.heightAnchor.constraint(equalToConstant: 25),
            
            photoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoStackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
//            photoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension PhotosTableViewCell {
    
    func addImage(imageName: String) {
        let image = UIImageView(image: UIImage(named: imageName))
        image.translatesAutoresizingMaskIntoConstraints = false
        [image.widthAnchor.constraint(equalToConstant:(contentView.frame.width + 24)/4),
         image.heightAnchor.constraint(equalTo: image.widthAnchor)]
            .forEach {
                $0.isActive = true
            }
                                      
        photoStackView.addArrangedSubview(image)
    }
    
}
