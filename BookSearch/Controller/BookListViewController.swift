

import UIKit
import SnapKit
import CoreData

//담은책 리스트
class BookListViewController: ViewController {
    
    var selectList: [BookSearchList] = []
    
    let bookListTableView = UITableView()
    let putbookLabel = UILabel()
    let addButton = UIButton()
    let deleteallButton = UIButton()
    let stackView = UIStackView()
    
    //스토리보드에서 재사용 셀 등록하는거 대신하는부분
    static let identifier3 = "BookListCell"

    //이 화면이 메모리에올라갔을때 불림 껏다키면 불리는데 그외는 불일일이없다
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //화면이 보일때마다 업데이트 해야하는데 보일때마다 불리는것
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
        bookSearchfetch()
    }
    //MARK: - addSubView,오토레이아웃 등
    override func setupConstraints() {
        [deleteallButton, putbookLabel, addButton, bookListTableView].forEach {
            view.addSubview($0)
        }
        deleteallButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.leading.equalToSuperview().inset(20)
        }
        putbookLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.leading.equalTo(deleteallButton.snp.trailing).offset(75)
        }
        addButton.snp.makeConstraints {
            $0.top.equalTo(deleteallButton.snp.top)
            $0.trailing.equalToSuperview().inset(20)
        }
        bookListTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(100)
            $0.height.equalTo(630)
        }
    }
    //MARK: - UI속성
    override func configureUI() {
        putbookLabel.text = "담은책"
        putbookLabel.font = UIFont.systemFont(ofSize: 20)
        putbookLabel.font = UIFont.boldSystemFont(ofSize: 30)
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.green, for: .normal)
        deleteallButton.setTitle("전체 삭제", for: .normal)
        deleteallButton.setTitleColor(.gray, for: .normal)
        //테이블뷰 델리게잇,데이터소스
        bookListTableView.dataSource = self
        bookListTableView.delegate = self
        bookListTableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.identifier3)
        deleteallButton.addTarget(self, action: #selector(deletAll), for: .touchUpInside)
    }
}
//MARK: - 테이블뷰
extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookListTableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath) as! BookListTableViewCell
        let selectData = selectList[indexPath.row]
//        print("데이터확인",selectData)
        cell.bookNameLabel.text = selectData.title
        cell.writerLabel.text = selectData.authors
        cell.priceLabel.text = String(selectData.price)
        return cell
    }
}
//MARK: - 코어데이터에서 Read부분
extension BookListViewController {
    
    func bookSearchfetch() {
        let context = ContainerManager.shared.persistentContainer.viewContext
        do {
            selectList = try context.fetch(BookSearchList.fetchRequest()) as! [BookSearchList]
            print("CoreData Read")
        } catch {
            print("CoreData Read Error")
        }
    }
    //테이블뷰 다시그려주기
    func reloadTableView() {
        DispatchQueue.main.async {
            self.bookListTableView.reloadData()
        }
    }
    
    //버튼눌리면 코어데이터 삭제하기 구현해야함
        @objc func deletAll(sender: UIButton) {
        
        }
        
}
