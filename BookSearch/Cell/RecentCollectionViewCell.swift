
import UIKit
import SnapKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    let recentImage = UIImageView()
    static let identifier2 = "RecentCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(recentImage)
        recentImage.backgroundColor = .white
        recentImage.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(120)
        }
        recentImage.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
