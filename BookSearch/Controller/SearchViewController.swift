
import UIKit
import SnapKit


class SearchViewController: ViewController {
    
  //Model부분을 book에 넣기 bookModel로 접근하지말고 Document로 바로접근가능
    var bookData: [Document] = []
    
    let searchBar = UISearchBar()
    let searchTableView = UITableView()
    let searchResultLabel = UILabel()
    let recentSearchLabel = UILabel()
    //컬렉션뷰는 초기화할때 항상 레이아웃을 제공해야한다 UICollectionViewFlowLayout을 레이아웃으로 설정해야함
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - 테이블뷰,컬렉션뷰 델리게잇,재사용셀부분 등
    func setproperties() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchBar.delegate = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchCollectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifier2)
        //컬렉션뷰 가로 방향 스크롤로 바꾸는것
        layout.scrollDirection = .horizontal
        searchCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    //MARK: - addSubView,오토레이아웃 등
    override func setupConstraints() {
        [searchBar, searchCollectionView, searchTableView, searchResultLabel, recentSearchLabel].forEach {
            view.addSubview($0)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(400)
            $0.bottom.equalToSuperview().inset(100)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchResultLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.bottom.equalTo(searchTableView.snp.top).offset(-10)
        }
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(searchResultLabel.snp.top).offset(-10)
        }
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(25)
        }
    }
    //MARK: - UI속성
    override func configureUI() {
        setproperties()
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 20
        searchBar.placeholder = "책 이름을 검색해 주세요"
        searchBar.layer.masksToBounds = true
        searchResultLabel.text = "검색 결과"
        recentSearchLabel.text = "최근 본 책"
        searchResultLabel.font = UIFont.boldSystemFont(ofSize: 30)
        recentSearchLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
}
//MARK: - 테이블뷰
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        //Document가 배열이라서 그중에 .타이틀,작가,금액을 고르는것
        cell.bookNameLabel.text = self.bookData[indexPath.row].title
        cell.writerLabel.text = self.bookData[indexPath.row].authors.first
        cell.priceLabel.text = "\(self.bookData[indexPath.row].price)원"
        // 셀 테두리의 너비
        cell.layer.cornerRadius = 15
        return cell
    }
    //테이블뷰 셀누르면 화면전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //이동도 뷰컨트롤러를 생성해야함
        let selectedBook = bookData[indexPath.row]
        let bookDetailsVC = BookDetailsViewController()
        //선택된 해당하는 데이터 넘겨주기
        bookDetailsVC.selectedBook = selectedBook
        present(bookDetailsVC, animated: true)
    }
}
//MARK: - 컬렉션뷰
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCollectionViewCell
        return cell
    }
   //컬렉션뷰 셀사이즈 지정하는부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 100
        let cellheight: CGFloat = 120
        return CGSize(width: cellWidth, height: cellheight)
    }
    //컬렉션뷰 섹션의 여백부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
}
//MARK: - 서치바
extension SearchViewController: UISearchBarDelegate {
    //텍스트 받아서 반영하는부분
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        //searchText부분에 들어가있는 서치데이터를 fetchBookAPI에 쿼리값으로 전달
        fetchBookAPI(query: searchText)
    }
}
//MARK: - 네트워크통신
extension SearchViewController {
    
    //1.url 만들기
    //2.urlRequest만들기 + 설정하기
    //3.URLSession의 Task 만들기
    //4.response처리하기
    
    func fetchBookAPI(query: String) {
        //1.url 만들기
        guard var url = URL(string: "https://dapi.kakao.com/v3/search/book") else { return }
//        url = URL(string: url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        url.append(queryItems: [URLQueryItem(name: "query", value: query)])
        
        //2.urlRequest만들기
        var urlRequest = URLRequest(url: url)
        
        //2.urlRequest설정하기 http메소드나 헤더나 바디를 넣어줄수있다
        urlRequest.addValue(APIKey.apikey, forHTTPHeaderField: "Authorization")
        
        //3.Task 만들기 data,response나 error 세가지가 내려옴 data랑 error는 동시에 내려올수없다 올지안올지몰라서 옵셔널
        //JSON데이터는 data에 저장되어있는것 그래서 옵셔널이라서 guard문으로 옵셔널 해제시키는것
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
//            print("data",data)
//            print("response",response)
//            print("error",error)
            if let error = error {
                print("에러",error)
            }
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8))
            //BookModel으로 매핑되는지 확인되는부분(디코딩)
            guard let bookdata = try? JSONDecoder().decode(BookModel.self, from: data) else {
                print("디코딩실패했다!!!!")
                return
            }
//            print("책검색결과",bookdata)
            self.bookData = bookdata.documents
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
       task.resume()
    }
}
