

import UIKit

class ImageCell: UICollectionViewCell {
  
  @IBOutlet var imageView: UIImageView!
  
}

class DetailViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  
  var photos: [Flickr.Photo] = []
  
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.photos.count
  }
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCell
    let photo = self.photos[indexPath.row]
    photo.loadImage(true) {
      switch $0 {
      case .Error:
        break
      case .Image(let image):
        imageCell.imageView.image = image
      }
    }
    return imageCell
  }
  
}

