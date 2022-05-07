//
//  TaskListScreen.swift
//  Task
//
//  Created by Tran Manh Quy on 01/01/2022.
//

import UIKit
import CoreMotion
import AVKit
import AVFoundation

struct VideoItem {
    var thumbnailURL = ""
    var videoURL = ""
    var name = ""
}

class TaskListScreen: UIViewController {
    
    @IBOutlet weak var tableViewVideo: UITableView!
    @IBOutlet weak var labelHost: UILabel!
    @IBOutlet weak var tableViewVDideo: UITableView!
    
    var listVideo: [VideoItem] = []
    
    let coreMotion = CMMotionManager.init()
    let pool = OperationQueue.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Environment", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
        }
        self.labelHost.text = nsDictionary!["api_host"] as? String
        
        coreMotion.accelerometerUpdateInterval = 0.1
        coreMotion.startAccelerometerUpdates(to: pool) { data, err in
            guard let _data = data else { return }
            DispatchQueue.main.async {
                print(String.init(format: "G-Force (x:y:z) %.3f:%.3f:%.3f", arguments: [_data.acceleration.x, _data.acceleration.y, _data.acceleration.z]))
            }
        }
        
        setupTableView()
        initData()
    }
    
    private func setupTableView() {
        tableViewVideo.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableViewVideo.dataSource = self
        tableViewVideo.delegate = self
    }
    
    private func initData() {
        self.listVideo = [
            .init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny")
            ,.init(thumbnailURL: "https://i.ytimg.com/vi/qk2y-TiLDZo/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/terdD_DH_5Q/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", name: "Sintel"),
            .init(thumbnailURL: "https://i.ytimg.com/vi/OwRQaaW6HdU/hqdefault.jpg", videoURL: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", name: "Big Buck Bunny")
        ]
    }
    
    // MARK: - UI Actions
    @IBAction func actionClickA(_ sender: Any) {
        
    }
    
    class DownloadImageInfo {
        
        internal init(isDownloading: Bool = false, url: String = "", image: UIImage? = nil) {
            self.isDownloading = isDownloading
            self.url = url
            self.image = image
        }
        
        var isDownloading = false
        var url = ""
        var image: UIImage?
        
        private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func download() {
            if isDownloading { return }
            isDownloading = false
            guard let urlForLoad = URL(string: url) else { return isDownloading = false }
            
            getData(from: urlForLoad) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? urlForLoad.lastPathComponent)
                print("Download Finished")
                self?.image = UIImage(data: data)
                self?.onFinishLoadImg(self?.image)
            }
        }
        
        var onFinishLoadImg: (UIImage?) -> Void = {_ in }
    }
        
    private var dictDownloadedImage: [String: DownloadImageInfo] = [:]
    
    fileprivate func loadImage(imgURL: String, completion: @escaping (String, UIImage?) -> Void) {
        if let imageData = dictDownloadedImage[imgURL] {
            imageData.onFinishLoadImg = { image in
                completion(imgURL, image)
            }
            
            if let image = imageData.image {
                completion(imgURL, image)
            } else {
                completion(imgURL, nil)
            }
        } else {
            let item = DownloadImageInfo.init(isDownloading: false, url: imgURL, image: nil)
            dictDownloadedImage.updateValue(item, forKey: imgURL)
            
            item.onFinishLoadImg = { image in
                completion(imgURL, image)
            }
            item.download()
            
            completion(imgURL, nil)
        }
    }
}

extension TaskListScreen: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let item = listVideo[indexPath.item]
        self.loadImage(imgURL: item.thumbnailURL) {[weak self] imgURL, image in
            DispatchQueue.main.async {
                guard let _self = self else { return }
                let item = _self.listVideo[indexPath.item]
                if imgURL == item.thumbnailURL { cell.imgViewThumbnail.image = image }
            }
        }
        cell.labelTitle.text = item.name
        return cell
    }
}

extension TaskListScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = listVideo[indexPath.item]

        let videoURL = URL(string: item.videoURL)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
