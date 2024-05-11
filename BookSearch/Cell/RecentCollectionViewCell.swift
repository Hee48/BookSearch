
import UIKit
import SnapKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    let recentImage = UIImageView()
    static let identifier2 = "RecentCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(recentImage)
        recentImage.backgroundColor = .lightGray
        recentImage.layer.cornerRadius = 20
        recentImage.clipsToBounds = true
        recentImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(90)
            $0.height.equalTo(110)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
