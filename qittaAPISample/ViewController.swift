//
//  ViewController.swift
//  qittaAPISample
//
//  Created by 松島悠人 on 2021/02/01.
//

// 今回はライブラリを使用しないver.
// 参考　https://fukatsu.tech/api-tableview
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!

    fileprivate var articles: [[String: Any]] = [] { // fileprivateを追加
        didSet {
            tableview.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        initTableView()
        getArticles()
    }
    private func getArticles() {
        // apiのurlをURL型に変換
        let url : URL = URL(string: "https://qiita.com/api/v2/items")!
        // 非同期処理
        //api通信は電波の状況やサーバーの状況によっていつ返ってくるか場合によって違うので、返ってきた段階で実行してほしい処理をクロージャーに定義して渡すようにしている。
        let task : URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            do {
                // Data型をJSON型に変換(Any型)
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] else {
                    return
                }
                // map関数を使用して全てのjsonの型を指定
                let articles = json.flatMap({ (article) -> [String: Any]? in
                    return article as? [String: Any]
                })
                self.articles = articles
            }
            catch {
                print(error)
            }
        })
        // 実行
        task.resume()
    }
    private func initTableView() {
        tableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
}
  extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    // セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles) // nil
        print(articles.count)
        return articles.count
    }
    // セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            abort()
        }
        let article = articles[indexPath.row]
        let title = article["title"] as? String ?? ""
        print(title)
        cell.bindData(text: "title:\(title)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section) index: \(indexPath.row)")
        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        return
    }
  }




