

import UIKit
import SnapKit
import Kingfisher

//책 상세페이지 모달창으로 띄우는부분 
class BookDetailsViewController: ViewController {
    
    //데이터를 넘겨받을곳
    var selectedBook: Document?
    
    let bookImage = UIImageView()
    let bookLabel = UILabel()
    let writerLabel = UILabel()
    let priceLabel = UILabel()
    let bookDescriptionLabel = UILabel()
    let putbutton = UIButton()
    let cancelbutton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - addSubView,오토레이아웃 등
    override func setupConstraints() {
        [bookLabel, writerLabel, bookImage, priceLabel, bookDescriptionLabel, putbutton, cancelbutton].forEach {
            view.addSubview($0)
        }
        bookLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
        }
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(bookLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        bookImage.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(300)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        bookDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        putbutton.snp.makeConstraints {
            $0.top.equalTo(bookDescriptionLabel.snp.bottom).offset(30)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(250)
            $0.height.equalTo(50)
        }
        cancelbutton.snp.makeConstraints {
            $0.top.equalTo(bookDescriptionLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(putbutton.snp.leading).offset(-15)
            $0.height.equalTo(50)
        }
     }
    //MARK: - UI속성
     override func configureUI() {
         view.backgroundColor = .white
         //책이름
         bookLabel.text = selectedBook?.title
         bookLabel.font = UIFont.boldSystemFont(ofSize: 20)
         bookLabel.numberOfLines = 0
         bookLabel.textAlignment = .center
         //작가이름
         writerLabel.text = selectedBook?.authors.first
         writerLabel.font = UIFont.systemFont(ofSize: 15)
         writerLabel.textColor = .gray
         //가격
         priceLabel.text = "\(String(selectedBook!.price))\("원")"
         priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
         //책설명
         bookDescriptionLabel.text = selectedBook?.contents
         bookDescriptionLabel.numberOfLines = 0
         bookDescriptionLabel.lineBreakMode = .byTruncatingTail
         //책이미지
         bookImage.layer.cornerRadius = 10
         bookImage.layer.masksToBounds = true
         //담기버튼
         putbutton.backgroundColor = UIColor(red: 0.1098, green: 0.0863, blue: 0.4706, alpha: 1)
         putbutton.layer.cornerRadius = 25
         putbutton.setTitle("담기", for: .normal)
         putbutton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
         putbutton.addTarget(self, action: #selector(addbuttonfunc), for: .touchUpInside)
         //취소버튼
         cancelbutton.backgroundColor = .lightGray
         cancelbutton.layer.cornerRadius = 25
         cancelbutton.setTitle("X", for: .normal)
         cancelbutton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
         cancelbutton.addTarget(self, action: #selector(cancelbuttonfunc), for: .touchUpInside)
         //킹피셔이미지함수
         loadImage()
     }
}
//MARK: - 썸네일 킹피셔, 코어데이터Create부분
extension BookDetailsViewController {
    //담기 눌리면 CoreData에 Create
    @objc func addbuttonfunc(sender: UIButton) {
        if let selectedBookCreate = selectedBook {
            saveBookList(with: selectedBookCreate)
        }
        let alert = UIAlertController(title: "책을 담기 성공했습니다", message: nil, preferredStyle: .alert)
        let okalert = UIAlertAction(title: "확인", style: .default) {_ in 
            self.dismiss(animated: true)
        }
        alert.addAction(okalert)
        present(alert, animated: true)
    }
    //모달창 꺼지게하기
    @objc func cancelbuttonfunc(sender: UIButton) {
        self.dismiss(animated: true)
    }
    //저장부분
    func saveBookList(with selectedBook: Document) {
        let context = ContainerManager.shared.persistentContainer.viewContext
        let bookList = BookSearchList(context: context)
        bookList.authors = selectedBook.authors.first
        bookList.title = selectedBook.title
        bookList.price = Int32(selectedBook.price)
        do {
            try context.save()
            print("Save Data")
        } catch {
            print("SaveWishList Error")
        }
    }
    //이미지 킹피셔 쓴거
    func loadImage() {
        let url = URL(string: selectedBook!.thumbnail)
        bookImage.kf.setImage(with: url)
    }
}
