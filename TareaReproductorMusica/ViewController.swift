//
//  ViewController.swift
//  TareaReproductorMusica
//
//  Created by Nicolás Narria on 4/11/16.
//  Copyright © 2016 Nicolás Narria. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerSound: UIPickerView!
    @IBOutlet weak var albumImg: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var volumen: UISlider!
    
    var reproductor:AVAudioPlayer!
    
    let pickerSoundData = ["Blue eyes blue","Lifehouse","A day in the life","Nunca me alejaré","Cantaré"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerSound.delegate = self
        pickerSound.dataSource = self
    }

    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSoundData.count
    }
    
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let myTitle = NSAttributedString(string: pickerSoundData[row], attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        tocarMostrarPortada(row)
        
    }
    
    func tocarMostrarPortada (nSong:Int) {
        var sonidoURL:NSURL?
        
        switch nSong {
        case 0:
            self.albumImg.image = UIImage(named: "images05_10sec.jpg")
            self.titulo.text = "Eric Clapton - Blue eyes blue"
            sonidoURL =  NSBundle.mainBundle().URLForResource("song05_10sec", withExtension: "mp3")
        case 1:
            self.albumImg.image = UIImage(named: "images04_10sec.jpg")
            //self.view.backgroundColor = UIColor.redColor();
            self.titulo.text = "Lifehouse - Everything"
            sonidoURL =  NSBundle.mainBundle().URLForResource("song04_10sec", withExtension: "mp3")
        case 2:
            self.albumImg.image = UIImage(named: "images07_10sec.jpg")
            //self.view.backgroundColor =  UIColor.greenColor();
            self.titulo.text = "Sting - A day in the life"
            sonidoURL =  NSBundle.mainBundle().URLForResource("song07_10sec", withExtension: "mp3")
        case 3:
            self.albumImg.image = UIImage(named: "images06_10sec.jpg")
            //self.view.backgroundColor =  UIColor.greenColor();
            self.titulo.text = "Línea Roja - Nunca me alejaré"
            sonidoURL =  NSBundle.mainBundle().URLForResource("song06_10sec", withExtension: "mp3")
        default:
            self.albumImg.image = UIImage(named: "images03_10sec.jpg")
            //self.view.backgroundColor = UIColor.blueColor();
            self.titulo.text = "Generación 12 - Cantaré"
            sonidoURL =  NSBundle.mainBundle().URLForResource("song03_10sec", withExtension: "mp3")
        }
        
        
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
        }
        catch {
            print("Error al cargar el archivo de sonido");
        }
        
        pickerSound.selectRow(nSong, inComponent: 0, animated: true)
        
        reproductor.volume = volumen.value
        reproductor.play();
        
    }
    

    @IBAction func play() {
        reproductor.play();
    }

    @IBAction func pause() {
        reproductor.pause()
    }
    
    @IBAction func stop() {
        reproductor.stop()
        reproductor.currentTime = 0.0
    }
    
    @IBAction func changeVolumen() {
        reproductor.volume = self.volumen.value
    }
    
    @IBAction func seleccionAleatoria() {
        let randomNumber0To5 = arc4random_uniform(5)
        tocarMostrarPortada(Int(randomNumber0To5))
    }
}

