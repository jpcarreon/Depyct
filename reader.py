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
        try:
            self.result += self.parseImg(fileName[8:])
            self.signalPaste.emit(True)
        except Exception as e:
            print(e)
            self.signalPaste.emit(False)

    @Slot()
    def getClipboard(self):
        tempPath = "./Images/temp.png"
        try:
            ImageGrab.grabclipboard().save(tempPath, "PNG")
            self.result += self.parseImg(tempPath)
            self.signalPaste.emit(True)
        except Exception as e:
            print(e)
            self.signalPaste.emit(False)
            return
        
        os.remove(tempPath)

    @Slot()
    def printContents(self):
        print(self.result)

    def parseImg(self, fileName):
        myconfig = r"--psm 6 --oem 3"
        img = cv2.imread(fileName)

        return pytesseract.image_to_string(img, config=myconfig)

