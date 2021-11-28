import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    private let imageProcessor = ImageProcessor()
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
    
    var photoSection:[UIImage] = [] {
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
        addPhotos1()
        addPhotos2()
        addPhotos3()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.photoInCollection.image = self.photoSection[indexPath.item]
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

// Время выполнения: 16.78 секунд
extension PhotosViewController {
    func addPhotos1()  {
        let timer = ParkBenchTimer()
        self.imageProcessor.processImagesOnThread(sourceImages: Photo.photos, filter: .colorInvert, qos: .background) {images in DispatchQueue.main.sync {
            for i in images {
                if let photo = i {
                    self.photoSection.append(UIImage(cgImage: photo))
                }
            }
            print("\(timer.stop()) seconds.")
        }
        }
    }
}

// Время выполнения: 3.57 секунды
extension PhotosViewController {
    func addPhotos2()  {
        let timer = ParkBenchTimer()
        self.imageProcessor.processImagesOnThread(sourceImages: Photo.photos1, filter: .fade, qos: .userInitiated) {images in DispatchQueue.main.sync {
            for i in images {
                if let photo = i {
                    self.photoSection.append(UIImage(cgImage: photo))
                }
            }
            print("\(timer.stop()) seconds.")
        }
        }
    }
}

// Время выполнения: 5.84 секунд
extension PhotosViewController {
    func addPhotos3()  {
        let timer = ParkBenchTimer()
        self.imageProcessor.processImagesOnThread(sourceImages: Photo.photos2, filter: .crystallize(radius: 10), qos: .default) {images in DispatchQueue.main.sync {
            for i in images {
                if let photo = i {
                    self.photoSection.append(UIImage(cgImage: photo))
                }
            }
            print("\(timer.stop()) seconds.")
        }
        }
    }
}
