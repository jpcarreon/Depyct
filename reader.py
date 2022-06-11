import pytesseract
import cv2
import os

from PIL import ImageGrab
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import QGuiApplication

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    @Slot(str)
    def openFile(self, fileName):
        myconfig = r"--psm 6 --oem 3"
        img = cv2.imread(fileName[8:])
        text = pytesseract.image_to_string(img, config=myconfig)
        
        with open("output.txt", "w", encoding="utf-8") as fp:
            fp.write(text)

    @Slot()
    def getClipboard(self):
        ImageGrab.grabclipboard().save("./Images/temp.png", "PNG")
