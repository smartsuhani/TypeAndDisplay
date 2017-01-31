import UIKit
import Photos
import PhotosUI

private extension UICollectionView {
    func indexPathsForElements(in rect: CGRect) -> [IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
}

class ThirdViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet var nextbtn: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var collectionViewLayout = UICollectionViewController().collectionViewLayout
    @IBOutlet var backbtn: UIButton!
    @IBOutlet var rootbtn: UIButton!
    
    fileprivate let imageManager = PHCachingImageManager()
    var fetchResult: PHFetchResult<PHAsset>!
    var assetCollection: PHAssetCollection!
    fileprivate var thumbnailSize: CGSize!
    fileprivate var previousPreheatRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        
        PHPhotoLibrary.shared().register(self)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 25)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: self.view1.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
       // collectionView.register(GridViewCell.self, forCellWithReuseIdentifier: "GridViewCell")
        collectionView.register(UINib(nibName: "photoViewCell", bundle: nil), forCellWithReuseIdentifier: "photoViewCell")
        collectionView.backgroundColor = UIColor.clear
        self.view1.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gotoroot(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    @IBAction func back(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    @IBAction func next(_ sender: Any) {
        self.navigationController?.pushViewController(FourthViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoViewCell", for: indexPath) as? photoViewCell
            else { fatalError("unexpected cell in collection view") }

        let asset = fetchResult.object(at: indexPath.item)
        
        let img = getAssetThumbnail(asset: asset)
        
        cell.imgView.image = img
       
        return cell
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

    // MARK: - Navigation

    fileprivate func resetCachedAssets() {
        imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }
    
    
    // MARK: UI Actions
}

// MARK: PHPhotoLibraryChangeObserver
extension ThirdViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: fetchResult)
            else { return }
        
        // Change notifications may be made on a background queue. Re-dispatch to the
        // main queue before acting on the change as we'll be updating the UI.
        DispatchQueue.main.sync {
            // Hang on to the new fetch result.
            fetchResult = changes.fetchResultAfterChanges
            if changes.hasIncrementalChanges {
                // If we have incremental diffs, animate them in the collection view.
                guard let collectionView = self.collectionView else { fatalError() }
                collectionView.performBatchUpdates({
                    // For indexes to make sense, updates must be in this order:
                    // delete, insert, reload, move
                    if let removed = changes.removedIndexes, removed.count > 0 {
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let inserted = changes.insertedIndexes, inserted.count > 0 {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let changed = changes.changedIndexes, changed.count > 0 {
                        collectionView.reloadItems(at: changed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                // Reload the collection view if incremental diffs are not available.
                collectionView!.reloadData()
            }
            resetCachedAssets()
        }
    }
}
