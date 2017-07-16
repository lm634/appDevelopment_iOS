//
//  SecondViewController.swift
//  apP
//
//  Created by Lluis Mather on 12/05/2017.
//  Copyright © 2017 Lluis Mather. All rights reserved.
//

import UIKit
import AVFoundation

var songs:[String] = []
var audioPlayer = AVAudioPlayer()
var thisSong = 0
var audioLoaded = false

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var progress: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    @IBAction func play(_ sender: Any) {
        if audioLoaded == false {
            playThis(thisOne: songs[thisSong])
            label.text = songs[thisSong]
        }
        else {
            if audioPlayer.isPlaying == false {
                audioPlayer.play()
                }
            }
        }
 
    @IBAction func pause(_ sender: Any) {
        if audioLoaded == false {}
        else {
            if audioPlayer.isPlaying == true {
                audioPlayer.pause()
            }
        }
    }
    
    @IBAction func skip(_ sender: Any) {
        if audioLoaded == false {}
        else {
            if thisSong < songs.count-1 {
                playThis(thisOne: songs[thisSong+1])
                thisSong += 1
                label.text = songs[thisSong]
            }
            else{}
        }
    }
    
    @IBAction func back(_ sender: Any) {
        if audioLoaded == false {}
        else {
            if thisSong <= 1 {}
            else {
                playThis(thisOne: songs[thisSong-1])
                thisSong -= 1
                label.text = songs[thisSong]
            }
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        if audioLoaded == true {
        audioPlayer.volume = sender.value
        }
        else {}
    }
    
    
    
    func playThis(thisOne:String) {
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            audioLoaded = true
        }
        catch {}
    }

    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            label.text = songs[thisSong]
            audioLoaded = true
        }
        
        catch {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gettingSongName()
        if audioLoaded == false {}
        else {
            label.text = songs[thisSong]
            progress.text = String(audioPlayer.currentTime)
            total.text = String(audioPlayer.duration/60)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func gettingSongName() {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
        
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath {
                var mySong = song.absoluteString
                if mySong.contains(".mp3") {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count - 1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                }
            }
            myTableView.reloadData()
        }
            
        catch{}
        
    }

}

