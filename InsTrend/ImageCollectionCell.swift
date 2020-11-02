

import UIKit
import Kingfisher

class ImageCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        self.addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
            make.edges.equalToSuperview()
//            make.center.equalToSuperview()
            
//            make.leading.trailing.equalToSuperview().inset(8)
            make.center.equalToSuperview()
//            make.height.equalTo(UIScreen.main.bounds.width - 16)
        }
        
        return imgView
    }()
    
    func setImage(_ img: URL) {
        self.imageView.kf.setImage(with: img)
    }
    
}
//
//
//class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
//    
//    var scrollImg: UIScrollView!
//    var imgView: UIImageView!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        scrollImg = UIScrollView()
//        scrollImg.delegate = self
//        scrollImg.alwaysBounceVertical = false
//        scrollImg.alwaysBounceHorizontal = false
//        scrollImg.showsVerticalScrollIndicator = true
//        scrollImg.flashScrollIndicators()
//        
//        scrollImg.minimumZoomScale = 1.0
//        scrollImg.maximumZoomScale = 4.0
//        
//        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
//        doubleTapGest.numberOfTapsRequired = 2
//        scrollImg.addGestureRecognizer(doubleTapGest)
//        
//        self.addSubview(scrollImg)
//        
//        imgView = UIImageView()
//        imgView.image = UIImage(named: "user3")
//        scrollImg.addSubview(imgView!)
//        imgView.contentMode = .scaleAspectFit
//    }
//    
//    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
//        if scrollImg.zoomScale == 1 {
//            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
//        } else {
//            scrollImg.setZoomScale(1, animated: true)
//        }
//    }
//    
//    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
//        var zoomRect = CGRect.zero
//        zoomRect.size.height = imgView.frame.size.height / scale
//        zoomRect.size.width  = imgView.frame.size.width  / scale
//        let newCenter = imgView.convert(center, from: scrollImg)
//        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
//        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
//        return zoomRect
//    }
//    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return self.imgView
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        scrollImg.frame = self.bounds
//        imgView.frame = self.bounds
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        scrollImg.setZoomScale(1, animated: true)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
