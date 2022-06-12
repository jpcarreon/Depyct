import pytesseract
import cv2
import os

from PIL import ImageGrab
from PySide6.QtCore import QObject, Slot, Signal

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    signalOutput = Signal(str)
    signalError = Signal(str)
    signalAlert = Signal(str)
    result = ""

    @Slot(str)
    def openFile(self, fileName):
        try:
            self.result += self.parseImg(fileName[8:])
            self.signalAlert.emit("Input parsed successfully")
        except Exception as e:
            print(e)

            self.signalError.emit("Failed to parse image")
            self.signalAlert.emit("Error: Failed to parse image")

    @Slot()
    def getClipboard(self):
        tempPath = "./Images/temp.png"
        try:
            ImageGrab.grabclipboard().save(tempPath, "PNG")
            self.result += self.parseImg(tempPath)
            self.signalAlert.emit("Input parsed successfully")
        except Exception as e:
            print(e)

            self.signalError.emit("Failed to parse image")
            self.signalAlert.emit("Error: Failed to parse image")
            return
        
        os.remove(tempPath)

    @Slot()
    def printContents(self):
        #   For testing purposes
        #self.result += self.parseImg("./Samples/img.png")

        if (len(self.result)):
            self.signalOutput.emit(self.result)

    def parseImg(self, fileName):
        myconfig = r"--psm 6 --oem 3"
        img = cv2.imread(fileName)

        return pytesseract.image_to_string(img, config=myconfig)

