import UIKit

class PhotosViewController: UIViewController {
    
    var notError = Bool.random()

    private lazy var photoCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.backgroundColor = .white
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        
        photoCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        
        photoCollection.dataSource = self
        photoCollection.delegate = self
        
        return photoCollection
    }()
    
    private var photoSection:[PhotoSection] = [] {
        didSet {
            photoCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(photoCollection)
        setupView()
        self.navigationController?.isNavigationBarHidden = false
        
        DispatchQueue.global().async { [weak self] in
            self?.addPhotos { result in
                switch result {
                case .success(let photos):
                    self?.photoSection = photos
                case .failure(let error):
                    self?.present(error.addAlert(), animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
}

extension PhotosViewController {
    func setupView() {
        let constrains = [
            photoCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constrains)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.photoSection.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSection[section].photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.photos = self.photoSection[indexPath.section].photo[indexPath.row]
        return cell
    }
    
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = (collectionView.frame.width - 8*5)/3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PhotosViewController {
    func addPhotos(completion: (Result<[PhotoSection], MyError>) -> Void) {
        if notError {
            completion(.success(Photos.photos))
        } else {
            completion(.failure(.photosNotFound))
        }
    }
}
