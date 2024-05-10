
import UIKit
import SnapKit

class BookListTableViewCell: UITableViewCell {
    
    let bookNameLabel = UILabel()
    let priceLabel = UILabel()
    let writerLabel = UILabel()
    
    //스토리보드에서 재사용 셀 등록하는거 대신하는부분
    static let identifier3 = "BookListCell"
    
    //MARK: - 셀부분 오토레이아웃
    func setupConstraints () {
        [bookNameLabel, writerLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
        //책이름 레이블
        bookNameLabel.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(writerLabel.snp.leading).offset(-10)
        }
        //작가명
        writerLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview().offset(50)
        }
        //책가격
        priceLabel.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview().inset(10)
        }
    }
    //MARK: - UI속성들 수정부분
    func configureUI() {
        writerLabel.textColor = .gray
        writerLabel.font = UIFont.systemFont(ofSize: 12)
        bookNameLabel.font = UIFont.systemFont(ofSize: 15)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupConstraints()
        configureUI()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
