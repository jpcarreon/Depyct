from unittest import result
import pytesseract
import cv2
import os

from PIL import ImageGrab
from PySide6.QtCore import QObject, Slot, Signal

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    signalPaste = Signal(bool)
    result = ""

    @Slot(str)
    def openFile(self, fileName):
        self.parseImg(fileName[8:])

    @Slot()
    def getClipboard(self):
        tempPath = "./Images/temp.png"
        try:
            ImageGrab.grabclipboard().save(tempPath, "PNG")
            self.signalPaste.emit(True)
        except:
            print("Invalid Clipboard Contents!")
            self.signalPaste.emit(False)
            return
        
        self.parseImg(tempPath)
        os.remove(tempPath)

    @Slot()
    def printContents(self):
        print(self.result)

    def parseImg(self, fileName):
        myconfig = r"--psm 6 --oem 3"
        img = cv2.imread(fileName)
        text = pytesseract.image_to_string(img, config=myconfig)
        
        with open("output.txt", "w", encoding="utf-8") as fp:
            fp.write(text)
